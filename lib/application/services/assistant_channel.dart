import 'package:beta/application/services/assistant_search_service.dart';
import 'package:beta/application/services/deep_link_service.dart';
import 'package:beta/domain/deep_link_target.dart';
import 'package:flutter/services.dart';

/// The `assistant` MethodChannel, through which the device assistants
/// (Gemini through Android AppFunctions, Siri through iOS App Intents) search
/// the content the user unlocked and open it.
///
/// Native code calls it on a headless engine that runs `assistantMain`
/// (lib/main.dart), so it works when the assistant starts the app in the
/// background; the UI engine answers it too. Methods:
///
/// - `search({query, limit?})`: up to [maxResults] results, best match first,
///   each with `type`, `id`, `title`, `answer`, `snippet` and `deepLink`.
///   `status` is `noMatch`, with an empty list and a [message], when nothing
///   matches, so the assistant does not answer from elsewhere.
/// - `lookup({deepLinks})`: the same results for links that are still
///   unlocked (for iOS entities, which Siri looks up by id).
/// - `open({deepLink})`: checks the link. `status` is `opened` when the
///   content can be opened, otherwise `locked`, `expired`, `unavailable` or
///   `invalid`. On the UI engine it also opens the link; on the headless
///   engine (`openedInApp` false) native code opens the app with it, and the
///   app checks access again and shows the unlock flow when needed.
///
/// Locked and expired content is never returned: results come from
/// [AssistantSearchService], which only searches unlocked terms.
class AssistantChannel {
  static const String name = 'assistant';
  static const MethodChannel channel = MethodChannel(name);
  static const int maxResults = 5;

  final AssistantSearchService searchService;
  final ContentAccessService contentAccessService;

  /// Opens a link in the UI; null on the headless engine.
  final Future<void> Function(Uri uri)? openInApp;

  AssistantChannel({
    required this.searchService,
    required this.contentAccessService,
    this.openInApp,
  });

  void attach() => channel.setMethodCallHandler(handle);

  Future<Map<String, Object?>> handle(MethodCall call) {
    final arguments = call.arguments is Map ? call.arguments as Map : const {};
    switch (call.method) {
      case 'search':
        return _search(arguments['query'], arguments['limit']);
      case 'lookup':
        return _lookup(arguments['deepLinks']);
      case 'open':
        return _open(arguments['deepLink']);
      default:
        throw MissingPluginException('No method ${call.method} on $name');
    }
  }

  Future<Map<String, Object?>> _search(Object? query, Object? limit) async {
    if (query is! String || query.trim().isEmpty) {
      return {
        'status': 'invalid',
        'results': const [],
        'message': 'The query is empty.',
      };
    }
    final results = await searchService.search(
      query,
      limit: limit is int ? limit.clamp(1, maxResults) : maxResults,
    );
    if (results.isEmpty) {
      return {
        'status': 'noMatch',
        'query': query,
        'results': const [],
        'message':
            'Perfect has no unlocked content that matches "$query", so it has '
            'no answer to this question.',
      };
    }
    return {
      'status': 'ok',
      'query': query,
      'results': results.map((e) => e.toJson()).toList(),
      'message':
          'Found ${results.length} unlocked item(s) in Perfect, best match '
          'first.',
    };
  }

  Future<Map<String, Object?>> _lookup(Object? deepLinks) async {
    final targets = (deepLinks is List ? deepLinks : const [])
        .whereType<String>()
        .map(Uri.tryParse)
        .whereType<Uri>()
        .map(DeepLinkTarget.parse)
        .whereType<DeepLinkTarget>();
    final results = await searchService.lookup(targets);
    return {'status': 'ok', 'results': results.map((e) => e.toJson()).toList()};
  }

  Future<Map<String, Object?>> _open(Object? deepLink) async {
    final uri = deepLink is String ? Uri.tryParse(deepLink) : null;
    final target = uri == null ? null : DeepLinkTarget.parse(uri);
    if (target == null) {
      return {
        'status': 'invalid',
        'openedInApp': false,
        'message': 'This is not a Perfect content link.',
      };
    }
    final outcome = await contentAccessService.check(target);
    final status = switch (outcome) {
      // Opening shows the "download first" message itself.
      DeepLinkOutcome.opened || DeepLinkOutcome.notDownloaded => 'opened',
      DeepLinkOutcome.locked => 'locked',
      DeepLinkOutcome.expired => 'expired',
      DeepLinkOutcome.unavailable => 'unavailable',
    };
    final canOpen = status != 'unavailable';
    final openInApp = this.openInApp;
    if (canOpen && openInApp != null) await openInApp(target.toUri());
    return {
      'status': status,
      'deepLink': target.toUri().toString(),
      'openedInApp': canOpen && openInApp != null,
      'message': switch (status) {
        'locked' =>
          'This content is locked. Perfect shows how to contact the team to '
              'unlock it.',
        'expired' =>
          'The subscription for this content has expired. Perfect opens the '
              'coupon screen instead.',
        'unavailable' => 'This content is not on this device.',
        _ => 'Opening the content in Perfect.',
      },
    };
  }
}
