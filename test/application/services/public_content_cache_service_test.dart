import 'package:beta/application/services/public_content_cache_service.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/domain/frequent_question.dart';
import 'package:beta/domain/news.dart';
import 'package:beta/domain/value/description.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart' hide Description;

import '../../common/tests.dart';

void main() {
  late PublicContentCacheService cache;

  setUp(() async {
    await initTests();
    cache = Get.find();
  });

  FrequentQuestion faq(int id, String title) => FrequentQuestion(
    id: Id(id),
    title: Title(title),
    description: Description('$title?'),
  );

  test('starts empty', () {
    expect(cache.getFrequentQuestions(), isEmpty);
    expect(cache.getNews(), isEmpty);
  });

  test('stores FAQs and replaces ones with the same id', () async {
    await cache.cacheFrequentQuestions([faq(1, 'one'), faq(2, 'two')]);
    await cache.cacheFrequentQuestions([
      faq(2, 'two updated'),
      faq(3, 'three'),
    ]);

    expect(cache.getFrequentQuestions(), [
      faq(2, 'two updated'),
      faq(3, 'three'),
      faq(1, 'one'),
    ]);
  });

  test('stores news', () async {
    final news = News(
      id: const Id(4),
      title: const Title('title'),
      content: const Description('content'),
      createdAt: DateTime(2024, 1, 2),
    );
    await cache.cacheNews([news]);

    expect(cache.getNews(), [news]);
  });

  test('keeps at most maxCachedItems', () async {
    await cache.cacheFrequentQuestions([
      for (int i = 1; i <= PublicContentCacheService.maxCachedItems + 5; i++)
        faq(i, '$i'),
    ]);

    final cached = cache.getFrequentQuestions();
    expect(cached.length, PublicContentCacheService.maxCachedItems);
    expect(cached.first.id.value, 1);
  });

  test('ignores a corrupt cache', () async {
    final KeyValue keyValue = Get.find();
    await keyValue.setString(KeyValueConstant.cachedNews, 'not json');

    expect(cache.getNews(), isEmpty);
  });
}
