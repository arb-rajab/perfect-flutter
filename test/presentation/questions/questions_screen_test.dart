import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_linked_to_tag_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/yes_no_dialogue.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_list.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/questions_report/questions_report_screen.dart';
import 'package:beta/presentation/widgets/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  setUp(() async {
    await initTests();
  });

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
      const Answer(
          id: 1,
          uuid: 'uuid',
          title: 'correct answer',
          titleTranslation: 'titleTranslation',
          isCorrect: 1,
          parentQuestionId: 1,
          specialCharacter: 1,
          creation: '2025-04-04 11:12:13',
          checkedCount: 100),
      const Answer(
          id: 2,
          uuid: 'uuid',
          title: 'wrong answer',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1,
          specialCharacter: 1,
          creation: '2025-04-04 11:12:13',
          checkedCount: 100),
      const Answer(
          id: 3,
          uuid: 'uuid',
          title: 'wrong answer 2',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1,
          specialCharacter: 1,
          creation: '2025-04-04 11:12:13',
          checkedCount: 100)
    ]);
  }

  Future seedTemplateData() async {
    TermService termService = Get.find();
    await termService.addTerms([
      TermData(
          const Term(
              id: 1,
              uuid: 'uuid',
              name: 'name',
              type: TermType.template,
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
    QuestionTagService questionTagService = Get.find();
    await questionTagService.addQuestionTags([
      const QuestionTag(
          id: 1,
          name: 'name',
          parentTagId: 0,
          hasInformation: 0,
          creation: '2024-01-01 11:12:13')
    ]);
    QuestionLinkedToTagService questionLinkedToTagService = Get.find();
    await questionLinkedToTagService.addQuestionsLinkdeToTags(
        [const QuestionsLinkedToTag(questionId: 1, tagId: 1)]);
  }

  group('popping tests', () {
    testWidgets('screen is popped successfully if type is questions',
        (widgetTester) async {
      await seedQuestionsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);

      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsNothing);
    });

    testWidgets('a dialogue is shown, when trying to pop template type term',
        (widgetTester) async {
      await seedTemplateData();
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      // dismiss timed test dialogue
      await widgetTester.tap(find.text(StringConstant.ok));
      await widgetTester.pumpAndSettle();

      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsOneWidget);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsOneWidget);
    });

    testWidgets(
        'a dialogue is shown, when trying to pop template type term, then tapping no, dismisses the dialogue',
        (widgetTester) async {
      await seedTemplateData();
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);

      // dismiss timed test dialogue
      await widgetTester.tap(find.text(StringConstant.ok));
      await widgetTester.pumpAndSettle();

      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsOneWidget);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsOneWidget);

      await widgetTester.tap(find.text(StringConstant.no));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsNothing);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsNothing);
    });

    testWidgets(
        'a dialogue is shown, when trying to pop template type term, then tapping no, dismisses the dialogue, then going back, shows the dialogue again',
        (widgetTester) async {
      await seedTemplateData();
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      // dismiss timed test dialogue
      await widgetTester.tap(find.text(StringConstant.ok));
      await widgetTester.pumpAndSettle();

      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsOneWidget);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsOneWidget);

      await widgetTester.tap(find.text(StringConstant.no));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsNothing);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsNothing);

      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsOneWidget);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsOneWidget);
    });

    testWidgets(
        'a dialogue is shown, when trying to pop template type term, then tapping yes, dismisses the dialogue, and shows results screen',
        (widgetTester) async {
      await seedTemplateData();
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);

      // dismiss timed test dialogue
      await widgetTester.tap(find.text(StringConstant.ok));
      await widgetTester.pumpAndSettle();

      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsOneWidget);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsOneWidget);

      await widgetTester.tap(find.text(StringConstant.yes));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsNothing);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsNothing);
      expect(find.byType(QuestionsReportScreen), findsOneWidget);
    });

    testWidgets(
        'a dialogue is shown, when trying to pop template type term, then tapping yes, dismisses the dialogue, and shows results screen, then trying to pop, pops the screen',
        (widgetTester) async {
      await seedTemplateData();
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);

      // dismiss timed test dialogue
      await widgetTester.tap(find.text(StringConstant.ok));
      await widgetTester.pumpAndSettle();

      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsOneWidget);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsOneWidget);

      await widgetTester.tap(find.text(StringConstant.yes));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(YesNoDialogue, StringConstant.confirmExist),
          findsNothing);
      expect(
          find.widgetWithText(
              YesNoDialogue, StringConstant.confirmTemplateExistExplanation),
          findsNothing);
      expect(find.byType(QuestionsReportScreen), findsOneWidget);

      // back to questions screen
      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle();
      expect(find.byType(QuestionsScreen), findsOneWidget);

      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle();
      expect(find.byType(QuestionsScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });

  group('search icon tests', () {
    testWidgets('search icon is rendered', (widgetTester) async {
      await seedQuestionsData();
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.widgetWithText(TextFormField, StringConstant.search),
          findsNothing);
    });

    testWidgets('tapping the icon, hides it and shows the input field',
        (widgetTester) async {
      await seedQuestionsData();
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.search));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsNothing);
      expect(find.widgetWithText(TextFormField, StringConstant.search),
          findsOneWidget);
    });

    testWidgets(
        'tapping the icon, hides it and shows the input field, then searching the text shows relevant data',
        (widgetTester) async {
      await seedQuestionsData();
      QuestionService questionService = Get.find();
      questionService.addQuestions([
        const Question(
            id: 2,
            uuid: 'uuid',
            title: 'query',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 1,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:12:15',
            editionDate: ''),
        const Question(
            id: 3,
            uuid: 'uuid',
            title: 'duery',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 1,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:12:15',
            editionDate: ''),
        const Question(
            id: 4,
            uuid: 'uuid',
            title: 'euery',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 4,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:12:15',
            editionDate: ''),
        const Question(
            id: 5,
            uuid: 'uuid',
            title: 'fuery',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 1,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:12:15',
            editionDate: '')
      ]);
      AnswerService answerService = Get.find();
      await answerService.addAnswers([
        const Answer(
            id: 1,
            uuid: 'uuid',
            title: 'query',
            titleTranslation: 'titleTranslation',
            isCorrect: 1,
            parentQuestionId: 5,
            specialCharacter: 1,
            creation: '2024-01-01 11:12:13',
            checkedCount: 0)
      ]);
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.search));
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(
          find.widgetWithText(TextFormField, StringConstant.search), 'query');
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, 'name'), findsNothing);
      expect(find.widgetWithText(QuestionTitle, 'query'), findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'duery'), findsNothing);
      expect(find.widgetWithText(QuestionTitle, 'euery'), findsNothing);
      expect(find.widgetWithText(QuestionTitle, 'fuery'), findsOneWidget);
    });

    testWidgets('clear search icon clears the text, and hides the search',
        (widgetTester) async {
      await seedQuestionsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.search));
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(
          find.widgetWithText(TextFormField, StringConstant.search), 'query');
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.clear));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.widgetWithText(TextFormField, StringConstant.search),
          findsNothing);

      await widgetTester.tap(find.byIcon(Icons.search));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TextFormField, 'query'), findsNothing);
    });

    testWidgets('tapping search icon hides the title', (widgetTester) async {
      await seedQuestionsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      expect(find.text('name'), findsOneWidget);

      await widgetTester.tap(find.byIcon(Icons.search));
      await widgetTester.pumpAndSettle();

      expect(find.text('name'), findsNothing);
    });
  });

  testWidgets('title is rendered', (widgetTester) async {
    await seedQuestionsData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.text('name'), findsOneWidget);
  });

  group('speed dial tests', () {
    testWidgets('speed dial is rendered', (widgetTester) async {
      await seedQuestionsData();

      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(SpeedDial), findsOneWidget);
      expect(find.widgetWithIcon(SpeedDial, Icons.playlist_add_check),
          findsNothing);
      expect(find.widgetWithIcon(SpeedDial, Icons.spellcheck), findsNothing);
      expect(find.widgetWithIcon(SpeedDial, Icons.subject), findsNothing);
      expect(find.widgetWithIcon(SpeedDial, Icons.timer), findsNothing);
    });

    group('solve questions tests', () {
      testWidgets('solve questions button is rendered', (widgetTester) async {
        await seedQuestionsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        expect(find.byIcon(Icons.playlist_add_check), findsOneWidget);
        expect(find.text(StringConstant.solveQuestions), findsOneWidget);
      });

      testWidgets('solve questions button solves the question if not solved',
          (widgetTester) async {
        await seedQuestionsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'correct answer' &&
                widget.checked == false),
            findsOneWidget);

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'wrong answer' &&
                widget.checked == false),
            findsOneWidget);

        // tap the speed dial button
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        // tap solve questions button
        await widgetTester.tap(find.text(StringConstant.solveQuestions));
        await widgetTester.pumpAndSettle();

        QuestionsController controller =
            Get.find(tag: "q.parentTermId= '1' ORDER BY q.id asc");

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'correct answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context)
                        .textTheme
                        .bodyMedium!
                        .color &&
                widget.checked == true),
            findsOneWidget);

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'wrong answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context)
                        .textTheme
                        .bodyMedium!
                        .color &&
                widget.checked == false),
            findsOneWidget);
      });

      testWidgets(
          'solve questions button changes the question wrong answer to the correct answer if wrongly solved',
          (widgetTester) async {
        await seedQuestionsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        // tap the wrong answer
        await widgetTester.tap(find.text('wrong answer'));
        await widgetTester.pumpAndSettle();

        // tap the speed dial button
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        // tap solve questions button
        await widgetTester.tap(find.text(StringConstant.solveQuestions));
        await widgetTester.pumpAndSettle();

        QuestionsController controller =
            Get.find(tag: "q.parentTermId= '1' ORDER BY q.id asc");

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'correct answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context)
                        .textTheme
                        .bodyMedium!
                        .color &&
                widget.checked == true),
            findsOneWidget);

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'wrong answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context)
                        .textTheme
                        .bodyMedium!
                        .color &&
                widget.checked == false),
            findsOneWidget);
      });

      testWidgets(
          'solve questions button keeps the correct answer checked if correctly answering',
          (widgetTester) async {
        await seedQuestionsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        // tap the correct answer
        await widgetTester.tap(find.text('correct answer'));
        await widgetTester.pumpAndSettle();

        // tap the speed dial button
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        // tap solve questions button
        await widgetTester.tap(find.text(StringConstant.solveQuestions));
        await widgetTester.pumpAndSettle();

        QuestionsController controller =
            Get.find(tag: "q.parentTermId= '1' ORDER BY q.id asc");

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'correct answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context)
                        .textTheme
                        .bodyMedium!
                        .color &&
                widget.checked == true),
            findsOneWidget);

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'wrong answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context)
                        .textTheme
                        .bodyMedium!
                        .color &&
                widget.checked == false),
            findsOneWidget);
      });
    });

    group('correct questions tests', () {
      testWidgets('correct questions button is rendered for questions type',
          (widgetTester) async {
        await seedQuestionsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        // tap the speed dial
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        expect(find.byIcon(Icons.spellcheck), findsOneWidget);
        expect(find.text(StringConstant.correctQuestions), findsOneWidget);
      });

      testWidgets('correct questions button not rendered for template type',
          (widgetTester) async {
        await seedTemplateData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.text(StringConstant.ok));
        await widgetTester.pumpAndSettle();

        // tap the speed dial
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        expect(find.byIcon(Icons.spellcheck), findsNothing);
      });
      testWidgets(
          'correct questions button correct questions with suitable colors',
          (widgetTester) async {
        await seedQuestionsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.text('wrong answer'));
        await widgetTester.pumpAndSettle();

        // tap the speed dial
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.text(StringConstant.correctQuestions));
        await widgetTester.pumpAndSettle();

        QuestionsController controller =
            Get.find(tag: "q.parentTermId= '1' ORDER BY q.id asc");

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'correct answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context).primaryColor),
            findsOneWidget);

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'wrong answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context).colorScheme.error &&
                widget.checked == true),
            findsOneWidget);

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'wrong answer 2' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context).disabledColor &&
                widget.checked == false),
            findsOneWidget);
      });
    });

    group('reset questions tests', () {
      testWidgets('reset questions button is rendered', (widgetTester) async {
        await seedQuestionsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        // tap the speed dial
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        expect(find.byIcon(Icons.subject), findsOneWidget);
        expect(find.text(StringConstant.resetQuestions), findsOneWidget);
      });

      testWidgets('reset questions button resets all questions',
          (widgetTester) async {
        await seedQuestionsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        // tap the correct answer
        await widgetTester.tap(find.text('correct answer'));
        await widgetTester.pumpAndSettle();

        // tap the speed dial button
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        // tap reset questions button
        await widgetTester.tap(find.text(StringConstant.resetQuestions));
        await widgetTester.pumpAndSettle();

        QuestionsController controller =
            Get.find(tag: "q.parentTermId= '1' ORDER BY q.id asc");

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'correct answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context)
                        .textTheme
                        .bodyMedium!
                        .color &&
                widget.checked == false),
            findsOneWidget);

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'wrong answer' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context)
                        .textTheme
                        .bodyMedium!
                        .color &&
                widget.checked == false),
            findsOneWidget);

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomCheckbox &&
                widget.labelWidget is Text &&
                (widget.labelWidget! as Text).data == 'wrong answer 2' &&
                (widget.labelWidget! as Text).style!.color ==
                    Theme.of(controller.state.context)
                        .textTheme
                        .bodyMedium!
                        .color &&
                widget.checked == false),
            findsOneWidget);
      });
    });

    group('timer tests', () {
      testWidgets('timer button is not rendered for questions type',
          (widgetTester) async {
        await seedQuestionsData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        // tap the speed dial
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        expect(find.byIcon(Icons.timer), findsNothing);
        expect(find.text(StringConstant.timer), findsNothing);
      });

      testWidgets('timer button is rendered for template type',
          (widgetTester) async {
        await seedTemplateData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.text(StringConstant.ok));
        await widgetTester.pumpAndSettle();

        // tap the speed dial
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        expect(find.byIcon(Icons.timer), findsOneWidget);
        expect(find.text(StringConstant.timer), findsOneWidget);
      });
      testWidgets('timer button shows the remaining timer',
          (widgetTester) async {
        await seedTemplateData();

        await widgetTester
            .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
        await widgetTester.pumpAndSettle();

        // tap ok button
        await widgetTester.tap(find.text(StringConstant.ok));
        await widgetTester.pumpAndSettle();

        // tap the speed dial
        await widgetTester.tap(find.byType(SpeedDial));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.text(StringConstant.timer));
        await widgetTester.pump();

        expect(find.text(StringConstant.remainingTime), findsOneWidget);

        await widgetTester.pumpAndSettle();
      });
    });
  });

  // testWidgets('loading widget is rendered', (widgetTester) async {
  //   await seedQuestionsData();

  //   await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
  //   await widgetTester.pumpAndSettle();

  //   await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
  //   await widgetTester.pum();

  //   expect(find.byType(LoadingWidget), findsOneWidget);
  //   await widgetTester.pumpAndSettle();
  // });

  testWidgets('questions list is rendered', (widgetTester) async {
    await seedQuestionsData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.byType(QuestionsList), findsOneWidget);
  });
}
