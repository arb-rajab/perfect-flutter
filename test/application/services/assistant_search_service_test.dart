import 'package:beta/application/services/assistant_search_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/public_content_cache_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/domain/assistant_search_result.dart';
import 'package:beta/domain/deep_link_target.dart';
import 'package:beta/domain/frequent_question.dart';
import 'package:beta/domain/news.dart';
import 'package:beta/domain/value/description.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart';
import 'package:drift/drift.dart' show Value;
import 'package:get/instance_manager.dart';
import 'package:test/test.dart' hide Description;

import '../../common/tests.dart';
import 'assistant_test_fixtures.dart';

void main() {
  late AssistantSearchService searchService;

  setUp(() async {
    await initTests();
    await AssistantFixtures.seed();
    searchService = Get.find();
  });

  Set<int> idsOf(
    List<AssistantSearchResult> results,
    AssistantContentType type,
  ) => results.where((e) => e.type == type).map((e) => e.id).toSet();

  group('access', () {
    test(
      'returns only unlocked content when locked content matches too',
      () async {
        final results = await searchService.search('الميتوكوندريا', limit: 100);

        expect(idsOf(results, AssistantContentType.question), {
          AssistantFixtures.unlockedQuestionId,
        });
        // Every locked term is named after the query; none may show up.
        expect(idsOf(results, AssistantContentType.term), isEmpty);
      },
    );

    test(
      'never returns content of a locked term, whatever the reason',
      () async {
        for (final query in [
          'الميتوكوندريا',
          'وظيفة',
          'إنتاج الطاقة',
          'السرية',
          'Mitochondria',
          'powerhouse',
          'المقفلة',
          'المنتهية',
          'المعطلة',
          'مجلد',
        ]) {
          final results = await searchService.search(query, limit: 100);
          expect(
            idsOf(
              results,
              AssistantContentType.question,
            ).intersection(AssistantFixtures.lockedQuestionIds),
            isEmpty,
            reason: query,
          );
          expect(
            idsOf(
              results,
              AssistantContentType.term,
            ).intersection(AssistantFixtures.lockedTermIds),
            isEmpty,
            reason: query,
          );
          expect(
            idsOf(results, AssistantContentType.flashcard),
            isNot(contains(AssistantFixtures.lockedFlashcardId)),
            reason: query,
          );
        }
      },
    );

    test('does not leak the answers of locked questions', () async {
      // Only the locked questions have this answer.
      expect(await searchService.search('السرية'), isEmpty);
    });

    test('drops content once the coupon covering it expires', () async {
      expect(
        idsOf(
          await searchService.search('الميتوكوندريا'),
          AssistantContentType.question,
        ),
        {AssistantFixtures.unlockedQuestionId},
      );

      await AssistantFixtures.expireActiveCoupon();

      final results = await searchService.search('الميتوكوندريا');
      expect(idsOf(results, AssistantContentType.question), isEmpty);
      expect(
        await searchService.search('الخلية'),
        everyElement(
          isNot(
            predicate<AssistantSearchResult>(
              (e) =>
                  e.type == AssistantContentType.term &&
                  e.id == AssistantFixtures.unlockedQuestionsTermId,
            ),
          ),
        ),
      );
    });

    test('drops content once its term is disabled', () async {
      final TermService termService = Get.find();
      await (databaseService.update(databaseService.terms)
            ..where((tbl) => tbl.id.equals(AssistantFixtures.unlockedFolderId)))
          .write(const TermsCompanion(enabled: Value(0)));
      expect(
        await termService.isUnlocked(AssistantFixtures.unlockedFolderId),
        isFalse,
      );

      final results = await searchService.search('الميتوكوندريا');
      expect(idsOf(results, AssistantContentType.question), isEmpty);
    });

    test('isUnlocked agrees with the search for every seeded term', () async {
      final TermService termService = Get.find();
      for (final id in AssistantFixtures.lockedTermIds) {
        expect(await termService.isUnlocked(id), isFalse, reason: '$id');
      }
      for (final id in [
        AssistantFixtures.unlockedFolderId,
        AssistantFixtures.unlockedQuestionsTermId,
        AssistantFixtures.flashcardsTermId,
        AssistantFixtures.ebookTermId,
      ]) {
        expect(await termService.isUnlocked(id), isTrue, reason: '$id');
      }
    });
  });

  group('results', () {
    test(
      'a question has its correct answer as the snippet and a deep link',
      () async {
        final results = await searchService.search('وظيفة الميتوكوندريا');

        final question = results.firstWhere(
          (e) => e.type == AssistantContentType.question,
        );
        expect(question.id, AssistantFixtures.unlockedQuestionId);
        expect(question.title, 'ما هي وظيفة الميتوكوندريا؟');
        expect(question.snippet, 'إنتاج الطاقة');
        expect(question.deepLink.toString(), 'perfect://question/1');
      },
    );

    test(
      'a question is found by its correct answer but not a wrong one',
      () async {
        expect(
          idsOf(
            await searchService.search('إنتاج الطاقة'),
            AssistantContentType.question,
          ),
          {AssistantFixtures.unlockedQuestionId},
        );
        expect(await searchService.search('تخزين الماء'), isEmpty);
      },
    );

    test(
      'terms are found by name and text, and ebooks get their own type',
      () async {
        final results = await searchService.search('الخلية', limit: 100);

        expect(idsOf(results, AssistantContentType.term), {
          AssistantFixtures.unlockedQuestionsTermId,
        });
        expect(idsOf(results, AssistantContentType.ebook), {
          AssistantFixtures.ebookTermId,
        });
        final ebook = results.firstWhere(
          (e) => e.type == AssistantContentType.ebook,
        );
        expect(ebook.deepLink.toString(), 'perfect://ebook/9');

        final byText = await searchService.search('العضيات');
        expect(byText.single.id, AssistantFixtures.unlockedQuestionsTermId);
        expect(byText.single.snippet, 'مقدمة عن الخلية والعضيات');
      },
    );

    test(
      'terms without downloaded content and folders are not results',
      () async {
        expect(
          idsOf(
            await searchService.search('بدون محتوى'),
            AssistantContentType.term,
          ),
          isEmpty,
        );
        expect(
          idsOf(
            await searchService.search('العلوم'),
            AssistantContentType.term,
          ),
          isEmpty,
        );
      },
    );

    test(
      'flashcards are found by head and tail, with the tail as snippet',
      () async {
        final results = await searchService.search('powerhouse');

        expect(results.single.type, AssistantContentType.flashcard);
        expect(results.single.id, AssistantFixtures.unlockedFlashcardId);
        expect(results.single.title, 'Mitochondria');
        expect(results.single.snippet, 'The powerhouse of the cell');
        expect(results.single.deepLink.toString(), 'perfect://flashcard/1');
      },
    );

    test('cached FAQs and news are searchable', () async {
      final PublicContentCacheService cache = Get.find();
      await cache.cacheFrequentQuestions([
        FrequentQuestion(
          id: const Id(3),
          title: const Title('كيف أفعّل رمز الشراء؟'),
          description: const Description('من القائمة اختر إضافة رمز'),
        ),
      ]);
      await cache.cacheNews([
        News(
          id: const Id(4),
          title: const Title('تحديث جديد'),
          content: const Description('<p>أضفنا رمز شراء للمستخدمين</p>'),
          createdAt: DateTime(2024),
        ),
      ]);

      final results = await searchService.search('رمز الشراء');

      expect(results.map((e) => e.deepLink.toString()), [
        'perfect://faq/3',
        'perfect://news/4',
      ]);
      expect(results.first.snippet, 'من القائمة اختر إضافة رمز');
      expect(results.last.snippet, 'أضفنا رمز شراء للمستخدمين');
    });
  });

  group('matching', () {
    test(
      'ignores diacritics, hamza forms, taa marbuta and alef maqsura',
      () async {
        for (final query in [
          'الْخَلِيَّة',
          'الخليه',
          'خلية',
          'انتاج الطاقه',
          'إنتاج',
          'وظيفه الميتوكوندريا',
        ]) {
          expect(await searchService.search(query), isNotEmpty, reason: query);
        }
        // Diacritics in the content are ignored too.
        await databaseService
            .into(databaseService.flashcards)
            .insert(
              const Flashcard(
                id: 50,
                head: 'مَعْنَى الطَّاقَةِ',
                tail: 'القُدْرَةُ على العَمَلِ',
                parentTermId: AssistantFixtures.flashcardsTermId,
              ),
            );
        final results = await searchService.search('معني القدره');
        expect(results.single.id, 50);
      },
    );

    test('ignores Latin letter case', () async {
      expect(
        (await searchService.search('MITOCHONDRIA')).single.id,
        AssistantFixtures.unlockedFlashcardId,
      );
    });

    test('requires every word of the query', () async {
      expect(await searchService.search('Mitochondria ribosome'), isEmpty);
    });

    test('treats LIKE wildcards in the query literally', () async {
      expect(await searchService.search('%'), isEmpty);
      expect(await searchService.search('_'), isEmpty);
    });

    test('does not match inside HTML tags', () async {
      final QuestionService questionService = Get.find();
      await questionService.addQuestions([
        AssistantFixtures.question(
          40,
          '00000000-0000-4000-8000-000000000040',
          '<span class="highlight">سؤال منسق</span>',
          AssistantFixtures.unlockedQuestionsTermId,
        ),
      ]);

      expect(await searchService.search('highlight'), isEmpty);
      expect((await searchService.search('سؤال منسق')).single.id, 40);
    });

    test('returns nothing for an empty query or limit', () async {
      expect(await searchService.search(''), isEmpty);
      expect(await searchService.search('   '), isEmpty);
      expect(await searchService.search('الخلية', limit: 0), isEmpty);
    });
  });

  group('ranking', () {
    test('ranks a title match above a body match', () async {
      await databaseService
          .into(databaseService.flashcards)
          .insert(
            const Flashcard(
              id: 60,
              head: 'Cell membrane',
              tail: 'Surrounds the Ribosome and more',
              parentTermId: AssistantFixtures.flashcardsTermId,
            ),
          );

      final results = await searchService.search('ribosome');

      expect(results.map((e) => e.id), [
        AssistantFixtures.secondUnlockedFlashcardId,
        60,
      ]);
      expect(results.first.score, greaterThan(results.last.score));
    });

    test('ranks an exact title match first', () async {
      final results = await searchService.search('الخلية', limit: 100);
      expect(results.first.type, AssistantContentType.term);
      expect(results.first.id, AssistantFixtures.unlockedQuestionsTermId);
    });

    test('applies the limit after ranking', () async {
      final all = await searchService.search('الخلية', limit: 100);
      final limited = await searchService.search('الخلية', limit: 1);
      expect(all.length, greaterThan(1));
      expect(limited.single.deepLink, all.first.deepLink);
    });

    test('shortens long snippets around the match', () async {
      final longTail =
          '${List.filled(60, 'filler').join(' ')} '
          'ribosomal target words ${List.filled(60, 'more').join(' ')}';
      await databaseService
          .into(databaseService.flashcards)
          .insert(
            Flashcard(
              id: 70,
              head: 'Long card',
              tail: longTail,
              parentTermId: AssistantFixtures.flashcardsTermId,
            ),
          );

      final result = (await searchService.search('Long card')).single;

      expect(
        result.snippet.length,
        lessThanOrEqualTo(AssistantSearchService.snippetLength + 2),
      );
      final aroundMatch = (await searchService.search('target words')).single;
      expect(aroundMatch.snippet, contains('target words'));
      expect(aroundMatch.snippet, startsWith('…'));
    });
  });
}
