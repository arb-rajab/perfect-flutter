import 'dart:async';
import 'dart:convert';

import 'package:beta/application/services/assistant_channel.dart';
import 'package:beta/application/services/assistant_search_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Keeps the iOS Spotlight index (Core Spotlight) in step with the content
/// the user can open, so Spotlight and Siri only suggest unlocked content.
///
/// It replaces the whole index through `replaceIndex` on the [AssistantChannel]
/// when the indexed items change: it checks when the app starts or resumes
/// (coupons expire with time) and after writes to the tables that grant
/// access or hold content (coupons, syncs, downloads). Each item also carries
/// the expiry of the access to it, so iOS removes it on time even when the
/// app is not opened again.
class AssistantIndexService {
  static const int maxItems = 2000;
  static const Duration debounce = Duration(seconds: 3);

  /// The index is also rebuilt once a week, in case iOS cleared it.
  static const Duration rebuildInterval = Duration(days: 7);

  final AssistantSearchService searchService;
  final DatabaseService databaseService;
  final KeyValue keyValue;
  final MethodChannel channel;
  final DateTime Function() _now;

  StreamSubscription<Set<TableUpdate>>? _tableUpdates;
  Timer? _timer;
  Future<void> _current = Future.value();
  Future<void>? _queued;

  AssistantIndexService({
    required this.searchService,
    required this.databaseService,
    required this.keyValue,
    this.channel = AssistantChannel.channel,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  void start() {
    if (_tableUpdates != null) return;
    unawaited(sync());
    _tableUpdates = databaseService
        .tableUpdates(
          TableUpdateQuery.onAllTables([
            databaseService.terms,
            databaseService.termTrees,
            databaseService.coupons,
            databaseService.couponsLinkedToTerms,
            databaseService.questions,
            databaseService.flashcards,
            databaseService.ebooks,
          ]),
        )
        .listen((_) => _schedule());
    AppLifecycleListener(onResume: _schedule);
  }

  void _schedule() {
    _timer?.cancel();
    _timer = Timer(debounce, () => unawaited(sync()));
  }

  /// Replaces the index if its items changed since the last replace. Calls
  /// made while a sync runs share one follow-up sync.
  Future<void> sync() => _queued ??= _current.then((_) {
    _queued = null;
    return _current = _replaceIfChanged();
  });

  Future<void> _replaceIfChanged() async {
    try {
      final items = await buildItems();
      final week =
          _now().millisecondsSinceEpoch ~/ rebuildInterval.inMilliseconds;
      final fingerprint = _fingerprint('$week ${jsonEncode(items)}');
      if (keyValue.getString(KeyValueConstant.assistantIndexFingerprint) ==
          fingerprint) {
        return;
      }
      await channel.invokeMethod('replaceIndex', {'items': items});
      await keyValue.setString(
        KeyValueConstant.assistantIndexFingerprint,
        fingerprint,
      );
    } catch (error) {
      debugPrint('Could not update the assistant index: $error');
    }
  }

  /// The items to index: `id` (the deep link), `type`, `title`,
  /// `description`, `keywords` (the names of the term and its ancestors) and
  /// `expiresAt` (milliseconds since epoch, or null when access does not
  /// end).
  Future<List<Map<String, Object?>>> buildItems() async {
    final results = await searchService.listUnlocked(limit: maxItems);
    final termIds = results.map((e) => e.termId).whereType<int>().toSet();
    final expiries = await _accessExpiries(termIds);
    final names = await _termNames(termIds);
    return [
      for (final result in results)
        {
          'id': result.deepLink.toString(),
          'type': result.type.pathName,
          'title': result.title,
          'description': result.snippet,
          'keywords': [
            for (final name in names[result.termId] ?? const <String>[])
              if (name != result.title) name,
          ],
          'expiresAt': expiries[result.termId]?.millisecondsSinceEpoch,
        },
    ];
  }

  Future<Map<int, DateTime>> _accessExpiries(Set<int> termIds) async {
    if (termIds.isEmpty) return {};
    final rows = await databaseService
        .customSelect(
          'select t.id as id, ${TermService.accessExpiryExpression} as expiresAt '
          'from terms t where t.id in (${termIds.join(',')})',
        )
        .get();
    return {
      for (final row in rows)
        if (row.readNullable<String>('expiresAt') case final expiresAt?)
          row.read<int>('id'): DateTime.parse('${expiresAt}Z'),
    };
  }

  /// The names of each term and its ancestors, nearest first.
  Future<Map<int, List<String>>> _termNames(Set<int> termIds) async {
    if (termIds.isEmpty) return {};
    final rows = await databaseService
        .customSelect(
          "select tt.termId as termId, coalesce(a.name, '') as name "
          'from termTrees tt join terms a on a.id=tt.parentTermId '
          'where tt.termId in (${termIds.join(',')}) order by tt.depth',
        )
        .get();
    final names = <int, List<String>>{};
    for (final row in rows) {
      final name = row.read<String>('name').trim();
      if (name.isEmpty) continue;
      (names[row.read<int>('termId')] ??= []).add(name);
    }
    return names;
  }

  /// FNV-1a, so the stored fingerprint is the same in every run.
  static String _fingerprint(String text) {
    int hash = 0x811c9dc5;
    for (final unit in text.codeUnits) {
      hash = ((hash ^ unit) * 0x01000193) & 0xffffffff;
    }
    return '${text.length}:${hash.toRadixString(16)}';
  }
}
