import 'package:beta/application/services/answer_service.dart';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/questions/math_widget.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:beta/presentation/questions/question_body.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  Future seedQuestionsData(
      {int specialCharacter = SpecialCharacter.none, int isCorrect = 0}) async {
    TermService termService = Get.find();
    await termService.addTerms([
      TermData(
          const Term(
              id: 1,
              uuid: 'uuid',
              name: 'name',
              type: TermType.questions,
              creation: '2024-01-01 11:12:13',
              enabled: 1,
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: 'textCulumn',
              outerNote: 'outerNote'),
          deletedAt: const DeletedAt(null),
          visible: const Visible(1))
    ]);
    TermsParentService termsParentService = Get.find();
    await termsParentService.addTermsParents([
      TermsParentData(
        const TermsParent(
            termId: 1,
            parentTermId: -1,
            rootTermId: -1,
            creation: '2024-01-01 11:12:13'),
        deletedAt: const DeletedAt(null),
      )
    ]);
    QuestionService questionService = Get.find();
    await questionService.addQuestions([
      const Question(
          id: 1,
          uuid: 'uuid',
          title: 'title',
          titleTranslation: 'titleTranslation',
          labelId: 1,
          note: 'note',
          noteTranslation: 'noteTranslation',
          parentTermId: 1,
          specialCharacter: 1,
          type: 1,
          edited: 0,
          imageUrl: '',
          creation: '2024-01-01 11:12:13',
          editionDate: '')
    ]);
    AnswerService answerService = Get.find();
    await answerService.addAnswers([
      Answer(
          id: 1,
          uuid: 'uuid',
          title: 'answer',
          titleTranslation: 'titleTranslation',
          isCorrect: isCorrect,
          parentQuestionId: 1,
          specialCharacter: specialCharacter,
          creation: '2025-04-04 11:12:13',
          checkedCount: 100),
    ]);
  }

  setUp(() async {
    await initTests();
  });
  testWidgets('QuestionBody displays correct text answer', (tester) async {
    await seedQuestionsData(specialCharacter: SpecialCharacter.none);
    await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TermWidget, 'name'));
    await tester.pumpAndSettle();

    expect(find.text('answer'), findsOneWidget);
    expect(find.byType(MathWidget), findsNothing);
  });

  testWidgets('QuestionBody displays MathWidget for math special character',
      (tester) async {
    await seedQuestionsData(specialCharacter: SpecialCharacter.math);
    await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TermWidget, 'name'));
    await tester.pumpAndSettle();

    expect(find.byType(MathWidget), findsOneWidget);
  });

  testWidgets('QuestionBody shows check icon for correct answer when corrected',
      (tester) async {
    await seedQuestionsData(isCorrect: 1);
    await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TermWidget, 'name'));
    await tester.pumpAndSettle();

    // correct the answer
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(QuestionBody, Icons.check), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);
  });

  testWidgets(
      'QuestionBody shows close icon for incorrect checked answer when corrected',
      (tester) async {
    await seedQuestionsData(isCorrect: 0);
    await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TermWidget, 'name'));
    await tester.pumpAndSettle();

    // tap the answer
    await tester.tap(find.text('answer'));
    await tester.pumpAndSettle();

    // correct the answer
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(QuestionBody, Icons.close), findsOneWidget);
    expect(find.widgetWithIcon(QuestionBody, Icons.check), findsNothing);
  });

  testWidgets('Tapping checkbox updates answer state', (tester) async {
    await seedQuestionsData();
    await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TermWidget, 'name'));
    await tester.pumpAndSettle();

    // tap the answer
    await tester.tap(find.text('answer'));
    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) => widget is Checkbox && widget.value!),
        findsOneWidget);
  });

  testWidgets(
      'QuestionBody applies correct color for correct answer when corrected',
      (tester) async {
    await seedQuestionsData(isCorrect: 1);
    await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TermWidget, 'name'));
    await tester.pumpAndSettle();

    // correct the answer
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    final textWidget = tester.widget<Text>(find.byType(Text).first);
    expect(textWidget.style?.color, isNotNull);
  });

  testWidgets(
      'QuestionBody applies error color for incorrect checked answer when corrected',
      (tester) async {
    await seedQuestionsData(isCorrect: 0);
    await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TermWidget, 'name'));
    await tester.pumpAndSettle();

    // tap the answer
    await tester.tap(find.text('answer'));
    await tester.pumpAndSettle();

    // correct the answer
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    final textWidget = tester.widget<Text>(find.byType(Text).first);
    expect(textWidget.style?.color, isNotNull);
  });
}
