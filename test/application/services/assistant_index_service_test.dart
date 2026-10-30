import 'package:beta/application/services/assistant_channel.dart';
import 'package:beta/application/services/assistant_index_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';
import 'assistant_test_fixtures.dart';

void main() {
  late AssistantIndexService indexService;
  late List<List<Map>> replaced;
  late DateTime now;

  setUp(() async {
    await initTests();
    await AssistantFixtures.seed();
    replaced = [];
    now = DateTime(2026, 10, 30);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(AssistantChannel.channel, (call) async {
          expect(call.method, 'replaceIndex');
          replaced.add(((call.arguments as Map)['items'] as List).cast<Map>());
          return null;
        });
    indexService = AssistantIndexService(
      searchService: Get.find(),
      databaseService: Get.find(),
      keyValue: Get.find(),
      now: () => now,
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(AssistantChannel.channel, null);
  });

  Map<String, Map> byId(List<Map> items) => {
    for (final item in items) item['id'] as String: item,
  };

  test('indexes only content the user can open', () async {
    final items = byId(await indexService.buildItems());

    expect(
      items.keys.toSet(),
      containsAll({
        'perfect://term/${AssistantFixtures.unlockedQuestionsTermId}',
        'perfect://term/${AssistantFixtures.flashcardsTermId}',
        'perfect://ebook/${AssistantFixtures.ebookTermId}',
        'perfect://question/${AssistantFixtures.unlockedQuestionId}',
        'perfect://flashcard/${AssistantFixtures.unlockedFlashcardId}',
      }),
    );
    for (final id in AssistantFixtures.lockedQuestionIds) {
      expect(items, isNot(contains('perfect://question/$id')));
    }
    for (final id in AssistantFixtures.lockedTermIds) {
      expect(items, isNot(contains('perfect://term/$id')));
    }
    expect(
      items,
      isNot(
        contains('perfect://flashcard/${AssistantFixtures.lockedFlashcardId}'),
      ),
    );
  });

  test('describes items with their answer, terms and access expiry', () async {
    final items = byId(await indexService.buildItems());

    final question = items['perfect://question/1']!;
    expect(question['type'], 'question');
    expect(question['title'], 'ما هي وظيفة الميتوكوندريا؟');
    expect(question['description'], 'إنتاج الطاقة');
    expect(question['keywords'], containsAll(['الخلية', 'العلوم']));
    // Activated yesterday for 365 days.
    final expiresAt = DateTime.fromMillisecondsSinceEpoch(
      question['expiresAt'] as int,
    );
    expect(expiresAt.difference(DateTime.now()).inHours, closeTo(364 * 24, 2));

    final freeFlashcard = items['perfect://flashcard/1']!;
    expect(freeFlashcard['expiresAt'], isNull);
    expect(freeFlashcard['keywords'], ['Cell biology flashcards']);
  });

  test('replaces the index only when the items change', () async {
    await indexService.sync();
    await indexService.sync();
    expect(replaced, hasLength(1));
    expect(
      byId(replaced.single),
      contains('perfect://question/${AssistantFixtures.unlockedQuestionId}'),
    );

    await AssistantFixtures.expireActiveCoupon();
    await indexService.sync();

    expect(replaced, hasLength(2));
    final items = byId(replaced.last);
    expect(items, isNot(contains('perfect://question/1')));
    expect(
      items,
      isNot(
        contains('perfect://term/${AssistantFixtures.unlockedQuestionsTermId}'),
      ),
    );
    expect(items, contains('perfect://flashcard/1'));
  });

  test('rebuilds the index once a week', () async {
    await indexService.sync();
    now = now.add(AssistantIndexService.rebuildInterval);
    await indexService.sync();

    expect(replaced, hasLength(2));
  });

  test('retries after the index could not be replaced', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          AssistantChannel.channel,
          (call) async => throw PlatformException(code: 'failed'),
        );
    await indexService.sync();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(AssistantChannel.channel, (call) async {
          replaced.add(((call.arguments as Map)['items'] as List).cast<Map>());
          return null;
        });
    await indexService.sync();

    expect(replaced, hasLength(1));
  });
}
