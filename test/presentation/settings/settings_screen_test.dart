import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/term_property_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/settings/select_theme_widget.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/settings/text_scale_factor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../common/tests.dart';

void main() {
  setUp(() async {
    await initTests();
  });

  testWidgets('SettingsScreen displays correctly', (WidgetTester tester) async {
    setDesktopDevice(tester);
    await tester.pumpWidget(
      const MyApp(
        child: SettingsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SelectThemeWidget), findsOneWidget);
    expect(find.byType(TextScaleFactorWidget), findsOneWidget);
    expect(find.byType(DeleteUserNotesWidget), findsOneWidget);
    expect(find.byType(DeleteUserFavoriteQuestionsWidget), findsOneWidget);
    expect(find.byType(DeleteUserAnswersWidget), findsOneWidget);
    expect(find.byType(DeleteTermLastAccessWidget), findsOneWidget);
    expect(find.byType(DeleteStudiedTermsWidget), findsOneWidget);
    expect(find.byType(DeleteFavoriteTermsWidget), findsOneWidget);
  });

  group('DeleteUserNotesWidget', () {
    testWidgets('displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserNotesWidget(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.note), findsOneWidget);
    });

    testWidgets('shows dialogue when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserNotesWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteUserNotesWidget));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsOneWidget);
    });

    testWidgets('user notes are reserved when cancel tapped',
        (WidgetTester tester) async {
      QuestionPropertyService questionPropertyService = Get.find();
      await questionPropertyService.setUserNote(1, 'note');
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserNotesWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteUserNotesWidget));
      await tester.pumpAndSettle();

      // tap cancel
      await tester.tap(find.text(StringConstant.cancel));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect(
          (await questionPropertyService.getQuestionProperties(const Id(1)))
              .where((property) =>
                  property.name == 'userNote' && property.value == 'note')
              .length,
          1);
    });

    testWidgets('user notes are deleted when ok tapped',
        (WidgetTester tester) async {
      QuestionPropertyService questionPropertyService = Get.find();
      await questionPropertyService.setUserNote(1, 'note');
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserNotesWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteUserNotesWidget));
      await tester.pumpAndSettle();

      // tap ok
      await tester.tap(find.text(StringConstant.ok));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect(
          (await questionPropertyService.getQuestionProperties(const Id(1)))
              .where((property) =>
                  property.name == 'userNote' && property.value == 'note')
              .length,
          0);
    });
  });

  group('DeleteUserFavoriteQuestionsWidget', () {
    testWidgets('displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserFavoriteQuestionsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('shows dialogue when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserFavoriteQuestionsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteUserFavoriteQuestionsWidget));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsOneWidget);
    });

    testWidgets('user favorite questions are reserved when cancel tapped',
        (WidgetTester tester) async {
      QuestionPropertyService questionPropertyService = Get.find();
      await questionPropertyService.addQuestionToFavorite(1);
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserFavoriteQuestionsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteUserFavoriteQuestionsWidget));
      await tester.pumpAndSettle();

      // tap cancel
      await tester.tap(find.text(StringConstant.cancel));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect(
          (await questionPropertyService.getQuestionProperties(const Id(1)))
              .where((property) =>
                  property.name == 'favorite' && property.value == 'true')
              .length,
          1);
    });

    testWidgets('user favorite questions are deleted when ok tapped',
        (WidgetTester tester) async {
      QuestionPropertyService questionPropertyService = Get.find();
      await questionPropertyService.addQuestionToFavorite(1);
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserFavoriteQuestionsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteUserFavoriteQuestionsWidget));
      await tester.pumpAndSettle();

      // tap ok
      await tester.tap(find.text(StringConstant.ok));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect(
          (await questionPropertyService.getQuestionProperties(const Id(1)))
              .where((property) =>
                  property.name == 'favorite' && property.value == 'true')
              .length,
          0);
    });
  });

  group('DeleteUserAnswersWidget', () {
    testWidgets('displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserAnswersWidget(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('shows dialogue when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserAnswersWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteUserAnswersWidget));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsOneWidget);
    });

    testWidgets('user answers are reserved when cancel tapped',
        (WidgetTester tester) async {
      AnswerPropertyService answerPropertyService = Get.find();
      await answerPropertyService.checkAnswer(1);
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserAnswersWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteUserAnswersWidget));
      await tester.pumpAndSettle();

      // tap cancel
      await tester.tap(find.text(StringConstant.cancel));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect(
          (await answerPropertyService.getAnswerProperties(1))
              .where((property) =>
                  property.name == 'checked' && property.value == 'true')
              .length,
          1);
    });

    testWidgets('user answers are deleted when ok tapped',
        (WidgetTester tester) async {
      AnswerPropertyService answerPropertyService = Get.find();
      await answerPropertyService.checkAnswer(1);
      await tester.pumpWidget(
        const MyApp(
          child: DeleteUserAnswersWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteUserAnswersWidget));
      await tester.pumpAndSettle();

      // tap ok
      await tester.tap(find.text(StringConstant.ok));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect(
          (await answerPropertyService.getAnswerProperties(1))
              .where((property) =>
                  property.name == 'checked' && property.value == 'true')
              .length,
          0);
    });
  });

  group('DeleteTermLastAccessWidget', () {
    testWidgets('displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteTermLastAccessWidget(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.timeline), findsOneWidget);
    });

    testWidgets('shows dialogue when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteTermLastAccessWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteTermLastAccessWidget));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsOneWidget);
    });

    testWidgets('term last accesses are reserved when cancel tapped',
        (WidgetTester tester) async {
      TermLastAccessService termLastAccessService = Get.find();
      await termLastAccessService.addTermLastAccessed(const Id(1), const Id(1));
      await tester.pumpWidget(
        const MyApp(
          child: DeleteTermLastAccessWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteTermLastAccessWidget));
      await tester.pumpAndSettle();

      // tap cancel
      await tester.tap(find.text(StringConstant.cancel));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect((await termLastAccessService.getTermLastAccess(1)) == null, false);
    });

    testWidgets('term last accesses are deleted when ok tapped',
        (WidgetTester tester) async {
      TermLastAccessService termLastAccessService = Get.find();
      await termLastAccessService.addTermLastAccessed(const Id(1), const Id(1));
      await tester.pumpWidget(
        const MyApp(
          child: DeleteTermLastAccessWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteTermLastAccessWidget));
      await tester.pumpAndSettle();

      // tap ok
      await tester.tap(find.text(StringConstant.ok));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect((await termLastAccessService.getTermLastAccess(1)) == null, true);
    });
  });

  group('DeleteStudiedTermsWidget', () {
    testWidgets('displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteStudiedTermsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.fact_check_outlined), findsOneWidget);
    });

    testWidgets('shows dialogue when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteStudiedTermsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteStudiedTermsWidget));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsOneWidget);
    });

    testWidgets('studied terms are reserved when cancel tapped',
        (WidgetTester tester) async {
      TermPropertyService termPropertyService = Get.find();
      await termPropertyService.addTermToStudied(const Id(1));
      await tester.pumpWidget(
        const MyApp(
          child: DeleteStudiedTermsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteStudiedTermsWidget));
      await tester.pumpAndSettle();

      // tap cancel
      await tester.tap(find.text(StringConstant.cancel));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect((await termPropertyService.isTermStudied(const Id(1))), true);
    });

    testWidgets('studied terms are deleted when ok tapped',
        (WidgetTester tester) async {
      TermPropertyService termPropertyService = Get.find();
      await termPropertyService.addTermToStudied(const Id(1));
      await tester.pumpWidget(
        const MyApp(
          child: DeleteStudiedTermsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteStudiedTermsWidget));
      await tester.pumpAndSettle();

      // tap ok
      await tester.tap(find.text(StringConstant.ok));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect((await termPropertyService.isTermStudied(const Id(1))), false);
    });
  });

  group('DeleteFavoriteTermsWidget', () {
    testWidgets('displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteFavoriteTermsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('shows dialogue when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(
          child: DeleteFavoriteTermsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteFavoriteTermsWidget));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsOneWidget);
    });

    testWidgets('favorite terms are reserved when cancel tapped',
        (WidgetTester tester) async {
      TermPropertyService termPropertyService = Get.find();
      await termPropertyService.addTermToFavorite(const Id(1));
      await tester.pumpWidget(
        const MyApp(
          child: DeleteFavoriteTermsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteFavoriteTermsWidget));
      await tester.pumpAndSettle();

      // tap cancel
      await tester.tap(find.text(StringConstant.cancel));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect((await termPropertyService.isTermFavorite(const Id(1))), true);
    });

    testWidgets('favorite terms are deleted when ok tapped',
        (WidgetTester tester) async {
      TermPropertyService termPropertyService = Get.find();
      await termPropertyService.addTermToFavorite(const Id(1));
      await tester.pumpWidget(
        const MyApp(
          child: DeleteFavoriteTermsWidget(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DeleteFavoriteTermsWidget));
      await tester.pumpAndSettle();

      // tap ok
      await tester.tap(find.text(StringConstant.ok));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialogue), findsNothing);
      expect((await termPropertyService.isTermFavorite(const Id(1))), false);
    });
  });
}
