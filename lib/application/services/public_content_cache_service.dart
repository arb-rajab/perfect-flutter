import 'dart:convert';

import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/domain/frequent_question.dart';
import 'package:beta/domain/news.dart';
import 'package:beta/infrastructure/key_value_repository.dart';

/// Keeps the last fetched FAQs and news so they can be searched offline.
///
/// Both are public (not gated by coupons) and only exist on the server, so
/// the lists store what the user has already loaded.
class PublicContentCacheService {
  static const int maxCachedItems = 200;

  final KeyValue keyValue;

  PublicContentCacheService({required this.keyValue});

  Future cacheFrequentQuestions(List<FrequentQuestion> frequentQuestions) =>
      _merge(
        KeyValueConstant.cachedFrequentQuestions,
        frequentQuestions.map((e) => e.toJson()).toList(),
      );

  List<FrequentQuestion> getFrequentQuestions() => _read(
    KeyValueConstant.cachedFrequentQuestions,
  ).map(FrequentQuestion.fromJson).toList();

  Future cacheNews(List<News> news) =>
      _merge(KeyValueConstant.cachedNews, news.map((e) => e.toJson()).toList());

  List<News> getNews() =>
      _read(KeyValueConstant.cachedNews).map(News.fromJson).toList();

  List<Map<String, dynamic>> _read(String key) {
    final String? stored = keyValue.getString(key);
    if (stored == null) return [];
    try {
      return (jsonDecode(stored) as List).cast<Map<String, dynamic>>();
    } on FormatException {
      return [];
    }
  }

  /// Newly fetched items replace cached ones with the same id and go first.
  Future _merge(String key, List<Map<String, dynamic>> items) {
    final fetchedIds = items.map((e) => e['id']).toSet();
    final merged = [
      ...items,
      ..._read(key).where((e) => !fetchedIds.contains(e['id'])),
    ].take(maxCachedItems).toList();
    return keyValue.setString(key, jsonEncode(merged));
  }
}
