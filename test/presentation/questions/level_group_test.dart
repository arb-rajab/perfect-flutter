import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/application/services/terms_with_questions_filtering_enabled_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/term_with_questions_filtering_enabled_properties.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
  Future seedQuestionsData() async {
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
          title: 'easy',
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
          editionDate: ''),
      const Question(
          id: 2,
          uuid: 'uuid',
          title: 'medium',
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
          editionDate: ''),
      const Question(
          id: 3,
          uuid: 'uuid',
          title: 'hard',
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
    answerService.addAnswers([
      // easy question answers
      const Answer(
          id: 1,
          uuid: 'uuid',
          title: 'correct',
          titleTranslation: 'titleTranslation',
          isCorrect: 1,
          parentQuestionId: 1,
          specialCharacter: 1,
          creation: '2024-01-01 11:12:13',
          checkedCount: 100),
      const Answer(
          id: 2,
          uuid: 'uuid',
          title: 'incorrect',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1,
          specialCharacter: 1,
          creation: '2024-01-01 11:12:13',
          checkedCount: 10),
// medium question answers
      const Answer(
          id: 3,
          uuid: 'uuid',
          title: 'correct',
          titleTranslation: 'titleTranslation',
          isCorrect: 1,
          parentQuestionId: 2,
          specialCharacter: 1,
          creation: '2024-01-01 11:12:13',
          checkedCount: 10),
      const Answer(
          id: 4,
          uuid: 'uuid',
          title: 'incorrect 1',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 2,
          specialCharacter: 1,
          creation: '2024-01-01 11:12:13',
          checkedCount: 5),
      const Answer(
          id: 5,
          uuid: 'uuid',
          title: 'incorrect 2',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 2,
          specialCharacter: 1,
          creation: '2024-01-01 11:12:13',
          checkedCount: 15),

      // difficult question answers
      const Answer(
          id: 6,
          uuid: 'uuid',
          title: 'correct',
          titleTranslation: 'titleTranslation',
          isCorrect: 1,
          parentQuestionId: 3,
          specialCharacter: 1,
          creation: '2024-01-01 11:12:13',
          checkedCount: 10),
      const Answer(
          id: 7,
          uuid: 'uuid',
          title: 'incorrect 1',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 3,
          specialCharacter: 1,
          creation: '2024-01-01 11:12:13',
          checkedCount: 15),
      const Answer(
          id: 8,
          uuid: 'uuid',
          title: 'incorrect 2',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 3,
          specialCharacter: 1,
          creation: '2024-01-01 11:12:13',
          checkedCount: 20)
    ]);
    TermsWithQuestionsFilteringEnabledService
        termsWithQuestionsFilteringEnabledService = Get.find();
    await termsWithQuestionsFilteringEnabledService
        .addTermsWithQuestionsFilteringEnabled([
      TermsWithQuestionsFilteringEnabledProperties(
          const TermsWithQuestionsFilteringEnabledData(termId: 1),
          deletedAt: const DeletedAt(null))
    ]);
  }

  setUp(() async {
    await initTests();
  });

  testWidgets('chips are rendered', (widgetTester) async {
    await seedQuestionsData();
    setDesktopDevice(widgetTester);
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(FilterChip, StringConstant.easyQuestions),
        findsOneWidget);
    expect(find.widgetWithText(FilterChip, StringConstant.mediumQuestions),
        findsOneWidget);
    expect(find.widgetWithText(FilterChip, StringConstant.difficultQuestions),
        findsOneWidget);

    expect(find.widgetWithText(QuestionTitle, 'easy'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'medium'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'hard'), findsOneWidget);
  });

  testWidgets('tapping chips sequently, filters questions accordingly',
      (widgetTester) async {
    await seedQuestionsData();
    setDesktopDevice(widgetTester);
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    // easy questions filtering
    await widgetTester
        .tap(find.widgetWithText(FilterChip, StringConstant.easyQuestions));
    await widgetTester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.easyQuestions),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.mediumQuestions),
        findsNothing);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.difficultQuestions),
        findsNothing);

    expect(find.widgetWithText(QuestionTitle, 'easy'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'medium'), findsNothing);
    expect(find.widgetWithText(QuestionTitle, 'hard'), findsNothing);

    // medium questions filtering
    await widgetTester
        .tap(find.widgetWithText(FilterChip, StringConstant.mediumQuestions));
    await widgetTester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.easyQuestions),
        findsNothing);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.mediumQuestions),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.difficultQuestions),
        findsNothing);

    expect(find.widgetWithText(QuestionTitle, 'easy'), findsNothing);
    expect(find.widgetWithText(QuestionTitle, 'medium'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'hard'), findsNothing);

    // hard questions filtering
    await widgetTester.tap(
        find.widgetWithText(FilterChip, StringConstant.difficultQuestions));
    await widgetTester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.easyQuestions),
        findsNothing);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.mediumQuestions),
        findsNothing);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.difficultQuestions),
        findsOneWidget);

    expect(find.widgetWithText(QuestionTitle, 'easy'), findsNothing);
    expect(find.widgetWithText(QuestionTitle, 'medium'), findsNothing);
    expect(find.widgetWithText(QuestionTitle, 'hard'), findsOneWidget);
  });

  testWidgets('tapping easy questions chip, unfilters easy questions',
      (widgetTester) async {
    await seedQuestionsData();
    setDesktopDevice(widgetTester);
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    // easy questions filtering
    await widgetTester
        .tap(find.widgetWithText(FilterChip, StringConstant.easyQuestions));
    await widgetTester.pumpAndSettle();

    // retapping easy questions
    await widgetTester
        .tap(find.widgetWithText(FilterChip, StringConstant.easyQuestions));
    await widgetTester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.easyQuestions),
        findsNothing);

    expect(find.widgetWithText(QuestionTitle, 'easy'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'medium'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'hard'), findsOneWidget);
  });

  testWidgets('tapping medium questions chip, unfilters medium questions',
      (widgetTester) async {
    await seedQuestionsData();
    setDesktopDevice(widgetTester);
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    // easy questions filtering
    await widgetTester
        .tap(find.widgetWithText(FilterChip, StringConstant.mediumQuestions));
    await widgetTester.pumpAndSettle();

    // retapping easy questions
    await widgetTester
        .tap(find.widgetWithText(FilterChip, StringConstant.mediumQuestions));
    await widgetTester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.mediumQuestions),
        findsNothing);

    expect(find.widgetWithText(QuestionTitle, 'easy'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'medium'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'hard'), findsOneWidget);
  });

  testWidgets('tapping difficult questions chip, unfilters difficult questions',
      (widgetTester) async {
    await seedQuestionsData();
    setDesktopDevice(widgetTester);
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    // easy questions filtering
    await widgetTester.tap(
        find.widgetWithText(FilterChip, StringConstant.difficultQuestions));
    await widgetTester.pumpAndSettle();

    // retapping easy questions
    await widgetTester.tap(
        find.widgetWithText(FilterChip, StringConstant.difficultQuestions));
    await widgetTester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is FilterChip &&
            widget.selected &&
            (widget.label as Text).data == StringConstant.difficultQuestions),
        findsNothing);

    expect(find.widgetWithText(QuestionTitle, 'easy'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'medium'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'hard'), findsOneWidget);
  });
}
