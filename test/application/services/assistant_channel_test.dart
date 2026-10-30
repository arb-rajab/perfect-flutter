import 'package:beta/application/services/assistant_channel.dart';
import 'package:beta/application/services/assistant_search_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';
import 'assistant_test_fixtures.dart';

void main() {
  late AssistantChannel assistant;
  late List<Uri> opened;

  setUp(() async {
    await initTests();
    await AssistantFixtures.seed();
    opened = [];
    assistant = AssistantChannel(
      searchService: Get.find(),
      contentAccessService: Get.find(),
      openInApp: (uri) async => opened.add(uri),
    );
  });

  Future<Map<String, Object?>> call(String method, Object? arguments) =>
      assistant.handle(MethodCall(method, arguments));

  List<Map> resultsOf(Map<String, Object?> response) =>
      (response['results'] as List).cast<Map>();

  group('search', () {
    test('answers with the correct answer of an unlocked question', () async {
      final response = await call('search', {'query': 'وظيفة الميتوكوندريا'});

      expect(response['status'], 'ok');
      final best = resultsOf(response).first;
      expect(best['type'], 'question');
      expect(best['id'], AssistantFixtures.unlockedQuestionId);
      expect(best['title'], 'ما هي وظيفة الميتوكوندريا؟');
      expect(best['answer'], 'إنتاج الطاقة');
      expect(best['deepLink'], 'perfect://question/1');
    });

    test('never returns locked or expired content', () async {
      for (final query in ['الميتوكوندريا', 'السرية', 'Locked powerhouse']) {
        final response = await call('search', {'query': query});
        for (final result in resultsOf(response)) {
          expect(
            result['answer'],
            isNot(contains('السرية')),
            reason: '$query: $result',
          );
          expect(result['answer'], isNot(contains('Locked')), reason: query);
          if (result['type'] == 'question') {
            expect(
              AssistantFixtures.lockedQuestionIds,
              isNot(contains(result['id'])),
            );
          }
        }
      }
    });

    test('reports an explicit no match', () async {
      for (final query in ['زلزال بركاني', 'السرية']) {
        final response = await call('search', {'query': query});

        expect(response['status'], 'noMatch', reason: query);
        expect(response['results'], isEmpty);
        expect(response['message'], contains('no unlocked content'));
      }
    });

    test('rejects an empty query', () async {
      expect((await call('search', {'query': '  '}))['status'], 'invalid');
      expect((await call('search', null))['status'], 'invalid');
    });

    test('returns at most five results, best match first', () async {
      final QuestionService questionService = Get.find();
      await questionService.addQuestions([
        for (int i = 0; i < 8; i++)
          AssistantFixtures.question(
            100 + i,
            'extra-$i',
            'سؤال عن الانقسام رقم $i',
            AssistantFixtures.unlockedQuestionsTermId,
          ),
        AssistantFixtures.question(
          200,
          'extra-exact',
          'الانقسام',
          AssistantFixtures.unlockedQuestionsTermId,
        ),
      ]);

      final response = await call('search', {'query': 'الانقسام'});
      final results = resultsOf(response);

      expect(results, hasLength(AssistantChannel.maxResults));
      expect(results.first['id'], 200);
      expect(
        resultsOf(await call('search', {'query': 'الانقسام', 'limit': 2})),
        hasLength(2),
      );
      expect(
        resultsOf(await call('search', {'query': 'الانقسام', 'limit': 50})),
        hasLength(AssistantChannel.maxResults),
      );
    });

    test('returns more than the snippet for long answers', () async {
      final tail = List.filled(60, 'الطاقة الخلوية').join(' ');
      final FlashcardService flashcardService = Get.find();
      await flashcardService.addFlashcards([
        Flashcard(
          id: 50,
          head: 'Cellular respiration',
          tail: tail,
          parentTermId: AssistantFixtures.flashcardsTermId,
        ),
      ]);

      final result = resultsOf(
        await call('search', {'query': 'Cellular respiration'}),
      ).first;

      final answer = result['answer'] as String;
      expect(
        (result['snippet'] as String).length,
        lessThanOrEqualTo(AssistantSearchService.snippetLength + 1),
      );
      expect(
        answer.length,
        greaterThan(AssistantSearchService.snippetLength * 2),
      );
      expect(
        answer.length,
        lessThanOrEqualTo(AssistantSearchService.answerLength + 1),
      );
    });

    test('answers through the platform channel', () async {
      assistant.attach();
      addTearDown(() => AssistantChannel.channel.setMethodCallHandler(null));
      const codec = StandardMethodCodec();

      final reply = await TestDefaultBinaryMessengerBinding
          .instance
          .defaultBinaryMessenger
          .handlePlatformMessage(
            AssistantChannel.name,
            codec.encodeMethodCall(
              const MethodCall('search', {'query': 'الميتوكوندريا'}),
            ),
            null,
          );

      final response = codec.decodeEnvelope(reply!) as Map;
      expect(response['status'], 'ok');
      expect((response['results'] as List).first['deepLink'], isA<String>());
    });
  });

  group('lookup', () {
    test('returns the links that are still unlocked', () async {
      final response = await call('lookup', {
        'deepLinks': [
          'perfect://question/1',
          'perfect://question/2',
          'perfect://flashcard/${AssistantFixtures.unlockedFlashcardId}',
          'perfect://flashcard/${AssistantFixtures.lockedFlashcardId}',
          'perfect://term/${AssistantFixtures.disabledTermId}',
          'not a link',
          42,
        ],
      });

      expect(resultsOf(response).map((e) => e['deepLink']), [
        'perfect://question/1',
        'perfect://flashcard/${AssistantFixtures.unlockedFlashcardId}',
      ]);
    });

    test('drops content whose coupon expired since the search', () async {
      await AssistantFixtures.expireActiveCoupon();

      final response = await call('lookup', {
        'deepLinks': ['perfect://question/1'],
      });

      expect(response['results'], isEmpty);
    });
  });

  group('open', () {
    test('opens unlocked content in the app', () async {
      final response = await call('open', {'deepLink': 'perfect://question/1'});

      expect(response['status'], 'opened');
      expect(response['openedInApp'], isTrue);
      expect(opened, [Uri.parse('perfect://question/1')]);
    });

    test('reports why content cannot be opened', () async {
      Future<String?> statusOf(String link) async =>
          (await call('open', {'deepLink': link}))['status'] as String?;

      expect(await statusOf('perfect://question/4'), 'locked');
      expect(await statusOf('perfect://question/3'), 'expired');
      expect(await statusOf('perfect://question/999'), 'unavailable');
      expect(await statusOf('https://example.com/question/1'), 'invalid');
      expect(await statusOf('perfect://question/abc'), 'invalid');
      // Locked and expired links still open the app's unlock flow.
      expect(opened, [
        Uri.parse('perfect://question/4'),
        Uri.parse('perfect://question/3'),
      ]);
    });

    test('leaves opening to native code on the headless engine', () async {
      final headless = AssistantChannel(
        searchService: Get.find(),
        contentAccessService: Get.find(),
      );

      final response = await headless.handle(
        const MethodCall('open', {
          'deepLink': 'prfct://perfect-app.scienceontheweb.net/question/1',
        }),
      );

      expect(response['status'], 'opened');
      expect(response['openedInApp'], isFalse);
      expect(response['deepLink'], 'perfect://question/1');
    });
  });

  test('rejects unknown methods', () {
    expect(() => call('delete', null), throwsA(isA<MissingPluginException>()));
  });
}
