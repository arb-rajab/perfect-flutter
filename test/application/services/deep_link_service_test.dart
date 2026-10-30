import 'package:beta/application/services/assistant_search_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/deep_link_service.dart';
import 'package:beta/application/services/path/shared.dart';
import 'package:beta/configs/links.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/deep_link_target.dart';
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:beta/presentation/ebook/ebook_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/flashcards/flashcards_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';
import 'assistant_test_fixtures.dart';

class FakeDeepLinkNavigator implements DeepLinkNavigator {
  @override
  String currentLocation;
  final List<String> calls = [];
  void Function()? lastOnConfirm;

  FakeDeepLinkNavigator(this.currentLocation);

  @override
  Future<void> get ready => Future.value();

  @override
  Future<void> go(String location) async {
    calls.add('go $location');
    currentLocation = location;
  }

  @override
  Future<void> push(String location) async {
    calls.add('push $location');
    currentLocation = location;
  }

  @override
  Future<void> showMessage(
    String messageKey, {
    void Function()? onConfirm,
  }) async {
    calls.add('message $messageKey');
    lastOnConfirm = onConfirm;
  }
}

Future<List<int>> _rowCounts(DatabaseService db) async => [
  for (final table in ['questions', 'terms', 'answers', 'coupons'])
    (await db.customSelect('select count(*) as c from $table').getSingle())
        .read<int>('c'),
];

void main() {
  late DeepLinkService deepLinkService;

  setUp(() async {
    await initTests();
    await AssistantFixtures.seed();
    deepLinkService = Get.find();
  });

  Future<DeepLinkResolution> resolve(AssistantContentType type, int id) =>
      deepLinkService.resolve(DeepLinkTarget(type, id));

  void expectResolution(
    DeepLinkResolution resolution,
    DeepLinkOutcome outcome, [
    String? location,
  ]) {
    expect(resolution.outcome, outcome);
    expect(resolution.location, location);
  }

  group('resolve', () {
    test(
      'opens an unlocked question scrolled to it through its uuid',
      () async {
        expectResolution(
          await resolve(
            AssistantContentType.question,
            AssistantFixtures.unlockedQuestionId,
          ),
          DeepLinkOutcome.opened,
          '/q/${AssistantFixtures.unlockedQuestionUuid}',
        );
      },
    );

    test('opens the term of an unlocked question without a uuid', () async {
      expectResolution(
        await resolve(
          AssistantContentType.question,
          AssistantFixtures.unlockedQuestionWithoutUuidId,
        ),
        DeepLinkOutcome.opened,
        QuestionsScreen.route,
      );
      final argument = Get.find<QuestionsScreenArgument>();
      expect(
        argument.sourceId!.value,
        AssistantFixtures.unlockedQuestionsTermId,
      );
      expect(
        argument.termData!.term.id,
        AssistantFixtures.unlockedQuestionsTermId,
      );
    });

    test(
      'sends a question of a term no coupon covers to the unlock flow',
      () async {
        expectResolution(
          await resolve(AssistantContentType.question, 2),
          DeepLinkOutcome.expired,
          EnterCouponScreen.route,
        );
      },
    );

    test('sends content of an expired coupon to the unlock flow', () async {
      expectResolution(
        await resolve(AssistantContentType.question, 3),
        DeepLinkOutcome.expired,
        EnterCouponScreen.route,
      );
      expectResolution(
        await resolve(
          AssistantContentType.term,
          AssistantFixtures.expiredTermId,
        ),
        DeepLinkOutcome.expired,
        EnterCouponScreen.route,
      );
    });

    test(
      'reports disabled content, or content under a disabled term, locked',
      () async {
        expectResolution(
          await resolve(AssistantContentType.question, 4),
          DeepLinkOutcome.locked,
        );
        expectResolution(
          await resolve(AssistantContentType.question, 5),
          DeepLinkOutcome.locked,
        );
        expectResolution(
          await resolve(
            AssistantContentType.term,
            AssistantFixtures.disabledAncestorTermId,
          ),
          DeepLinkOutcome.locked,
        );
      },
    );

    test('reports content that is not on the device unavailable', () async {
      for (final type in [
        AssistantContentType.term,
        AssistantContentType.ebook,
        AssistantContentType.question,
        AssistantContentType.flashcard,
      ]) {
        expectResolution(await resolve(type, 999), DeepLinkOutcome.unavailable);
      }
    });

    test('opens a flashcard within its deck', () async {
      expectResolution(
        await resolve(
          AssistantContentType.flashcard,
          AssistantFixtures.secondUnlockedFlashcardId,
        ),
        DeepLinkOutcome.opened,
        FlashcardsScreen.route,
      );
      final argument = Get.find<FlashcardsScreenArgument>();
      expect(
        argument.initialFlashcardId,
        AssistantFixtures.secondUnlockedFlashcardId,
      );
      expect(argument.term.term.id, AssistantFixtures.flashcardsTermId);
      expect(argument.query, contains('parentTermId=8'));
    });

    test('does not open a locked flashcard', () async {
      Get.delete<FlashcardsScreenArgument>();
      expectResolution(
        await resolve(
          AssistantContentType.flashcard,
          AssistantFixtures.lockedFlashcardId,
        ),
        DeepLinkOutcome.expired,
        EnterCouponScreen.route,
      );
      expect(Get.isRegistered<FlashcardsScreenArgument>(), isFalse);
    });

    test('opens a questions term', () async {
      expectResolution(
        await resolve(
          AssistantContentType.term,
          AssistantFixtures.unlockedQuestionsTermId,
        ),
        DeepLinkOutcome.opened,
        QuestionsScreen.route,
      );
      expect(
        Get.find<QuestionsScreenArgument>().termData!.term.id,
        AssistantFixtures.unlockedQuestionsTermId,
      );
    });

    test('asks to download a term without content first', () async {
      expectResolution(
        await resolve(
          AssistantContentType.term,
          AssistantFixtures.notDownloadedTermId,
        ),
        DeepLinkOutcome.notDownloaded,
      );
    });

    test(
      'opens a downloaded ebook, and asks to download a missing one',
      () async {
        final PathService pathService = Get.find();
        pathService.testFileInSupport = false;
        expectResolution(
          await resolve(
            AssistantContentType.ebook,
            AssistantFixtures.ebookTermId,
          ),
          DeepLinkOutcome.notDownloaded,
        );

        pathService.testFileInSupport = true;
        expectResolution(
          await resolve(
            AssistantContentType.ebook,
            AssistantFixtures.ebookTermId,
          ),
          DeepLinkOutcome.opened,
          EbookScreen.route,
        );
        expect(
          Get.find<EbookScreenArgument>().term.term.id,
          AssistantFixtures.ebookTermId,
        );
      },
    );

    test(
      'an ebook link to a term that is not an ebook is unavailable',
      () async {
        expectResolution(
          await resolve(
            AssistantContentType.ebook,
            AssistantFixtures.unlockedQuestionsTermId,
          ),
          DeepLinkOutcome.unavailable,
        );
      },
    );

    test('opens a folder term on the home screen', () async {
      expectResolution(
        await resolve(
          AssistantContentType.term,
          AssistantFixtures.unlockedFolderId,
        ),
        DeepLinkOutcome.opened,
      );
    });

    test('opens FAQs and news on their screens', () async {
      expectResolution(
        await resolve(AssistantContentType.faq, 3),
        DeepLinkOutcome.opened,
        '/frequent-questions?id=3',
      );
      expectResolution(
        await resolve(AssistantContentType.news, 4),
        DeepLinkOutcome.opened,
        '/news/4',
      );
    });
  });

  group('DeepLinkCoordinator', () {
    late FakeDeepLinkNavigator navigator;
    late DateTime now;
    late DeepLinkCoordinator coordinator;

    void createCoordinator(String currentLocation) {
      navigator = FakeDeepLinkNavigator(currentLocation);
      now = DateTime(2024);
      coordinator = DeepLinkCoordinator(
        deepLinkService: deepLinkService,
        navigator: navigator,
        now: () => now,
      );
    }

    final questionLink = Uri.parse('perfect://question/1');

    test(
      'on cold start, opens the content on top of the home screen',
      () async {
        createCoordinator(SplashScreen.route);

        await coordinator.handle(questionLink);

        expect(navigator.calls, ['go ${HomeScreen.route}', 'push /q/00000000-0000-4000-8000-000000000001']);
      },
    );

    test(
      'on warm start, opens the content on top of the current screen',
      () async {
        createCoordinator('/settings');

        await coordinator.handle(questionLink);

        expect(navigator.calls, ['push /q/00000000-0000-4000-8000-000000000001']);
      },
    );

    test(
      'opens the launch link once although app_links delivers it twice',
      () async {
        createCoordinator(SplashScreen.route);

        await Future.wait([
          coordinator.handle(questionLink),
          coordinator.handle(questionLink),
        ]);
        expect(navigator.calls, ['go ${HomeScreen.route}', 'push /q/00000000-0000-4000-8000-000000000001']);

        // The same link opened again later is a new request.
        now = now.add(DeepLinkCoordinator.duplicateWindow);
        await coordinator.handle(questionLink);
        expect(navigator.calls.last, 'push /q/00000000-0000-4000-8000-000000000001');
        expect(navigator.calls.length, 3);
      },
    );

    test('keeps the previous behaviour for other links', () async {
      createCoordinator(SplashScreen.route);

      await coordinator.handle(Uri.parse('https://perfect-app.com/settings'));

      expect(navigator.calls, ['go /settings']);
    });

    group('/q/<uuid> links', () {
      Uri link(String uuid) =>
          Uri.parse('https://perfect-app.com/q/${Uri.encodeComponent(uuid)}');

      test('open the question of an unlocked term', () async {
        createCoordinator('/settings');

        await coordinator.handle(link(AssistantFixtures.unlockedQuestionUuid));

        expect(navigator.calls, [
          'push /q/${AssistantFixtures.unlockedQuestionUuid}',
        ]);
      });

      test('of an expired coupon open the expired flow', () async {
        createCoordinator('/settings');

        await coordinator.handle(link(AssistantFixtures.expiredQuestionUuid));

        expect(navigator.calls, [
          'push ${EnterCouponScreen.route}',
          'message ${StringConstant.termIsExpired}',
        ]);
      });

      test('of a disabled term open the locked flow', () async {
        createCoordinator('/settings');

        await coordinator.handle(link(AssistantFixtures.disabledQuestionUuid));

        expect(navigator.calls, ['message ${StringConstant.contentLocked}']);
      });

      for (final uuid in [
        "'; DROP TABLE questions; --",
        "' OR '1'='1",
        'not-a-uuid',
        '${AssistantFixtures.unlockedQuestionUuid}x',
      ]) {
        test('reject "$uuid", query nothing and change no data', () async {
          createCoordinator('/settings');
          final before = await _rowCounts(deepLinkService.databaseService);

          await coordinator.handle(link(uuid));
          final resolution = await deepLinkService.resolveQuestionUuid(uuid);

          expect(resolution.outcome, DeepLinkOutcome.unavailable);
          expect(navigator.calls, [
            'message ${StringConstant.contentUnavailable}',
          ]);
          expect(await _rowCounts(deepLinkService.databaseService), before);
        });
      }
    });

    test('opens the home screen for an unknown perfect:// link', () async {
      createCoordinator('/settings');

      await coordinator.handle(Uri.parse('perfect://unknown/1'));

      expect(navigator.calls, ['go ${HomeScreen.route}']);
    });

    test('falls back to the unlock flow when access has been lost', () async {
      final AssistantSearchService searchService = Get.find();
      final result = (await searchService.search('الميتوكوندريا')).single;
      await AssistantFixtures.expireActiveCoupon();
      createCoordinator('/home');

      await coordinator.handle(result.deepLink);

      expect(navigator.calls, [
        'push ${EnterCouponScreen.route}',
        'message ${StringConstant.termIsExpired}',
      ]);
    });

    test('offers to contact us about locked content', () async {
      createCoordinator('/home');

      await coordinator.handle(Uri.parse('perfect://question/4'));

      expect(navigator.calls, ['message ${StringConstant.contentLocked}']);
      navigator.lastOnConfirm!();
      expect(Get.find<UrlLauncherRepository>().openedUrl, telegramChannelLink);
    });

    test(
      'explains missing and not downloaded content on the home screen',
      () async {
        createCoordinator(SplashScreen.route);

        await coordinator.handle(Uri.parse('perfect://term/999'));
        await coordinator.handle(
          Uri.parse('perfect://term/${AssistantFixtures.notDownloadedTermId}'),
        );

        expect(navigator.calls, [
          'go ${HomeScreen.route}',
          'message ${StringConstant.contentUnavailable}',
          'message ${StringConstant.youHaveToDownloadFirst}',
        ]);
      },
    );

    test('opens the sections of the app shortcuts over home', () async {
      createCoordinator(SplashScreen.route);

      await coordinator.handle(Uri.parse('perfect://coupon'));
      now = now.add(DeepLinkCoordinator.duplicateWindow);
      await coordinator.handle(Uri.parse('perfect://FAQ/'));

      expect(navigator.calls, [
        'go ${HomeScreen.route}',
        'push ${EnterCouponScreen.route}',
        'push ${FrequentQuestionsScreen.route}',
      ]);
    });

    test('opens home for a section link with a path', () async {
      createCoordinator('/settings');

      await coordinator.handle(Uri.parse('perfect://contact/me'));

      expect(navigator.calls, ['go ${HomeScreen.route}']);
    });
  });

  group('ContentAccessService', () {
    late ContentAccessService accessService;

    setUp(() => accessService = Get.find());

    Future<DeepLinkOutcome> check(AssistantContentType type, int id) =>
        accessService.check(DeepLinkTarget(type, id));

    test('reports each kind of access without navigating', () async {
      expect(
        await check(
          AssistantContentType.question,
          AssistantFixtures.unlockedQuestionId,
        ),
        DeepLinkOutcome.opened,
      );
      // No coupon covers term 3; the coupon of term 4 expired.
      expect(
        await check(AssistantContentType.question, 2),
        DeepLinkOutcome.expired,
      );
      expect(
        await check(AssistantContentType.question, 3),
        DeepLinkOutcome.expired,
      );
      expect(
        await check(AssistantContentType.question, 4),
        DeepLinkOutcome.locked,
      );
      expect(
        await check(
          AssistantContentType.flashcard,
          AssistantFixtures.lockedFlashcardId,
        ),
        DeepLinkOutcome.expired,
      );
      expect(
        await check(AssistantContentType.term, 999),
        DeepLinkOutcome.unavailable,
      );
      expect(
        await check(AssistantContentType.question, 999),
        DeepLinkOutcome.unavailable,
      );
      expect(await check(AssistantContentType.faq, 1), DeepLinkOutcome.opened);
      expect(Get.isRegistered<QuestionsScreenArgument>(), isFalse);
    });
  });
}
