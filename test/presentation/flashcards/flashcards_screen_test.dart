import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/flashcards/flashcards_screen.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../common/tests.dart';

class MockFlashcardService extends FlashcardService {
  final List<Flashcard> testData;
  MockFlashcardService(this.testData) : super(databaseService: Get.find());

  @override
  Future<List<Flashcard>> getFlashcardsFromQuery(String query) async {
    return testData;
  }
}

class MockScreenshotRepository extends ScreenshotRepository {
  bool preventCalled = false;
  bool allowCalled = false;

  @override
  Future<void> preventScreenshot() async {
    preventCalled = true;
  }

  @override
  Future<void> allowScreenshot() async {
    allowCalled = true;
  }
}

class MockFlashcardsScreenArgument extends FlashcardsScreenArgument {
  MockFlashcardsScreenArgument()
      : super(
          query: 'test_query',
          title: 'Test Flashcards',
          term: TermData(
            const Term(
              id: 1,
              uuid: 'uuid',
              name: 'Test Term',
              type: 5,
              creation: '2022-01-01 00:00:00',
              enabled: 1,
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: '',
              outerNote: '',
            ),
          ),
        );
}

Future main() async {
  group('FlashcardsScreen Widget Tests', () {
    setUp(() async {
      await initTests();
      Get.delete<FlashcardService>();
      Get.put<FlashcardService>(MockFlashcardService([
        const Flashcard(
          id: 1,
          head: 'Front 1',
          tail: 'Back 1',
          parentTermId: 1,
        ),
        const Flashcard(
          id: 2,
          head: 'Front 2',
          tail: 'Back 2',
          parentTermId: 1,
        ),
      ]));
      Get.delete<ScreenshotRepository>();
      Get.put<ScreenshotRepository>(MockScreenshotRepository());
      Get.delete<FlashcardsScreenArgument>();
      Get.put<FlashcardsScreenArgument>(MockFlashcardsScreenArgument());
    });

    testWidgets('displays initial flashcard', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: FlashcardsScreen.route,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('1/2'), findsOneWidget);
      expect(find.text('Front 1'), findsOneWidget);
    });
    testWidgets('shows Next button when not on last flashcard',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: FlashcardsScreen.route,
        ),
      );
      await tester.pumpAndSettle();
      // On first card, Next button should be visible
      expect(find.textContaining(StringConstant.next), findsOneWidget);
    });

    testWidgets('shows Previous button when not on first flashcard',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: FlashcardsScreen.route,
        ),
      );
      await tester.pumpAndSettle();
      // Go to next card
      await tester.tap(find.textContaining(StringConstant.next));
      await tester.pumpAndSettle();
      // On second card, Previous button should be visible
      expect(find.textContaining(StringConstant.previous), findsOneWidget);
    });

    testWidgets('hides Next button when on last flashcard',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: FlashcardsScreen.route,
        ),
      );
      await tester.pumpAndSettle();
      // Go to last card
      await tester.tap(find.textContaining(StringConstant.next));
      await tester.pumpAndSettle();
      // On last card, Next button should not be visible
      expect(find.textContaining(StringConstant.next), findsNothing);
    });

    testWidgets('hides Previous button when on first flashcard',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: FlashcardsScreen.route,
        ),
      );
      await tester.pumpAndSettle();
      // On first card, Previous button should not be visible
      expect(find.textContaining(StringConstant.previous), findsNothing);
    });

    testWidgets('flips flashcard on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: FlashcardsScreen.route,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Front 1'));
      await tester.pumpAndSettle();
      expect(find.text('Back 1'), findsOneWidget);
    });

    testWidgets('navigates to next flashcard', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: FlashcardsScreen.route,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining(StringConstant.next));
      await tester.pumpAndSettle();
      expect(find.text('2/2'), findsOneWidget);
      expect(find.text('Front 2'), findsOneWidget);
    });

    testWidgets('navigates to previous flashcard', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: FlashcardsScreen.route,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining(StringConstant.next));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining(StringConstant.previous));
      await tester.pumpAndSettle();
      expect(find.text('1/2'), findsOneWidget);
      expect(find.text('Front 1'), findsOneWidget);
    });
  });
}
