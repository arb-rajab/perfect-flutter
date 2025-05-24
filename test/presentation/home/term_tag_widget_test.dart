import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_property_service.dart';
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
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/question_tag_widget.dart';
import 'package:beta/presentation/home/term_tag_widget.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  late DatabaseService databaseService;

  setUp(() async {
    await initTests();
    databaseService = Get.find();
  });

  tearDown(() async {
    await databaseService.deleteAllTables();
  });

  Future addTermWithNoTag() async {
    TermService termService = Get.find();
    TermsParentService termsParentService = Get.find();
    await termService.addTerms([
      TermData(
          const Term(
              id: 10000,
              uuid: 'uuid',
              name: 'term with no tag',
              type: 1,
              creation: '2023-01-01 11:12:13',
              enabled: 1,
              free: 1,
              ordering: 12,
              needsUpdate: 0,
              captureable: 0,
              textCulumn: '',
              outerNote: ''),
          deletedAt: const DeletedAt(null),
          visible: const Visible(1))
    ]);
    await termsParentService.addTermsParents([
      TermsParentData(
          const TermsParent(
              termId: 10000,
              parentTermId: 1,
              rootTermId: -1,
              creation: '2022-01-01 11:12:13'),
          deletedAt: const DeletedAt(null))
    ]);
  }

  Future enableQuestionsFiltering() async {
    TermsWithQuestionsFilteringEnabledService
        termsWithQuestionsFilteringEnabledService = Get.find();
    await termsWithQuestionsFilteringEnabledService
        .addTermsWithQuestionsFilteringEnabled([
      TermsWithQuestionsFilteringEnabledProperties(
          const TermsWithQuestionsFilteringEnabledData(termId: 1),
          deletedAt: const DeletedAt(null))
    ]);
  }

  Future addEasyMediumDifficultQuestions() async {
    QuestionService questionService = Get.find();
    AnswerService answerService = Get.find();
    await questionService.addQuestions([
      const Question(
          id: 1000,
          uuid: 'uuid',
          title: 'easy question',
          titleTranslation: 'titleTranslation',
          labelId: 1,
          note: 'note',
          noteTranslation: 'noteTranslation',
          parentTermId: 3,
          specialCharacter: 1,
          type: 1,
          edited: 0,
          imageUrl: '',
          creation: '2022-01-01 11:12:13',
          editionDate: ''),
      const Question(
          id: 1001,
          uuid: 'uuid',
          title: 'medium question',
          titleTranslation: 'titleTranslation',
          labelId: 1,
          note: 'note',
          noteTranslation: 'noteTranslation',
          parentTermId: 3,
          specialCharacter: 1,
          type: 1,
          edited: 0,
          imageUrl: '',
          creation: '2022-01-01 11:12:13',
          editionDate: ''),
      const Question(
          id: 1002,
          uuid: 'uuid',
          title: 'difficult question',
          titleTranslation: 'titleTranslation',
          labelId: 1,
          note: 'note',
          noteTranslation: 'noteTranslation',
          parentTermId: 3,
          specialCharacter: 1,
          type: 1,
          edited: 0,
          imageUrl: '',
          creation: '2022-01-01 11:12:13',
          editionDate: '')
    ]);

    await answerService.addAnswers([
      // question 1 answers
      const Answer(
          id: 1000,
          uuid: 'uuid',
          title: 'question 1 answer 1 correct',
          titleTranslation: 'titleTranslation',
          isCorrect: 1,
          parentQuestionId: 1000,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 200),
      const Answer(
          id: 1001,
          uuid: 'uuid',
          title: 'question 1 answer 2',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1000,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 10),
      const Answer(
          id: 1002,
          uuid: 'uuid',
          title: 'question 1 answer 3',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1000,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 20),
      const Answer(
          id: 1003,
          uuid: 'uuid',
          title: 'question 1 answer 4',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1000,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 30),

      // question 2 answers
      const Answer(
          id: 1004,
          uuid: 'uuid',
          title: 'question 2 answer 1',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1001,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 200),
      const Answer(
          id: 1005,
          uuid: 'uuid',
          title: 'question 2 answer 2',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1001,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 10),
      const Answer(
          id: 1006,
          uuid: 'uuid',
          title: 'question 2 answer 3 correct',
          titleTranslation: 'titleTranslation',
          isCorrect: 1,
          parentQuestionId: 1001,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 20),
      const Answer(
          id: 1007,
          uuid: 'uuid',
          title: 'question 2 answer 4',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1001,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 30),

      // question 3 answers
      const Answer(
          id: 1008,
          uuid: 'uuid',
          title: 'question 3 answer 1',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1002,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 200),
      const Answer(
          id: 1009,
          uuid: 'uuid',
          title: 'question 3 answer 2 correct',
          titleTranslation: 'titleTranslation',
          isCorrect: 1,
          parentQuestionId: 1002,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 10),
      const Answer(
          id: 1010,
          uuid: 'uuid',
          title: 'question 3 answer 3',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1002,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 20),
      const Answer(
          id: 1011,
          uuid: 'uuid',
          title: 'question 3 answer 4',
          titleTranslation: 'titleTranslation',
          isCorrect: 0,
          parentQuestionId: 1002,
          specialCharacter: 1,
          creation: '2022-01-01 11:12:13',
          checkedCount: 30),
    ]);
  }

  Future addTemplateTerm() async {
    TermService termService = Get.find();
    TermsParentService termsParentService = Get.find();
    await termService.addTerms([
      TermData(
          const Term(
              id: 1000,
              uuid: 'uuid',
              name: 'template term',
              type: 3,
              creation: '2024-01-01 12:12:13',
              enabled: 1,
              free: 1,
              ordering: 1000,
              needsUpdate: 1,
              captureable: 1,
              textCulumn: '',
              outerNote: ''),
          deletedAt: const DeletedAt(null),
          visible: const Visible(1))
    ]);
    await termsParentService.addTermsParents([
      TermsParentData(
          const TermsParent(
              creation: '2022-01-01 11:12:13',
              termId: 1000,
              parentTermId: 3,
              rootTermId: -1),
          deletedAt: const DeletedAt(null))
    ]);
  }

  group(('terms tags tests'), () {
    testWidgets('terms tag widget is rendered when reaching terms with tags',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TermTagWidget, 'tag name'), findsOneWidget);
      expect(find.widgetWithIcon(TermTagWidget, Icons.import_contacts),
          findsOneWidget);
    });

    testWidgets('terms tag tapping shows terms with the tag',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      // tap the term tag name
      await widgetTester.tap(find.widgetWithText(TermTagWidget, 'tag name'));
      await widgetTester.pumpAndSettle();

      // check that the child term is rendered
      expect(find.widgetWithText(TermWidget, 'child'), findsOneWidget);
    });
  });

  group(('terms with no tags tests'), () {
    testWidgets(
        'terms tag others widget is not rendered when there is no term that does not have a tag',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TermTagWidget, StringConstant.others),
          findsNothing);
    });

    testWidgets(
        'terms tag others widget is  rendered when there is a term that does not have a tag',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      await addTermWithNoTag();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(
              TermTagWidget, StringConstant.others, Icons.import_contacts),
          findsOneWidget);
    });

    testWidgets('terms tag others option tapping shows terms with no tag',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      await addTermWithNoTag();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      await widgetTester
          .tap(find.widgetWithText(TermTagWidget, StringConstant.others));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(TermWidget, 'term with no tag'), findsOneWidget);
    });
  });

  group('questions tags button tests', () {
    testWidgets('button is rendered', (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(
              TermTagWidget, StringConstant.questionTags, Icons.style_outlined),
          findsOneWidget);
    });

    testWidgets(
        'dialogue is shown when there are terms that needs to be downloaded',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      await addTermWithNoTag();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.questionTags, Icons.style_outlined));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(
              OKDialogue, StringConstant.pleaseDownloadAllTermsWithin),
          findsOneWidget);
      expect(find.byType(QuestionTagWidget), findsNothing);
    });

    testWidgets(
        'dialogue is shown when there are terms that needs to be updated',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      TermService termService = Get.find();
      TermsParentService termsParentService = Get.find();
      await termService.addTerms([
        TermData(
            const Term(
                id: 10000,
                uuid: 'uuid',
                name: 'term with no tag',
                type: 1,
                creation: '2023-01-01 11:12:13',
                enabled: 1,
                free: 1,
                ordering: 12,
                needsUpdate: 1,
                captureable: 0,
                textCulumn: '',
                outerNote: ''),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1))
      ]);
      await termsParentService.addTermsParents([
        TermsParentData(
            const TermsParent(
                termId: 10000,
                parentTermId: 1,
                rootTermId: -1,
                creation: '2022-01-01 11:12:13'),
            deletedAt: const DeletedAt(null))
      ]);

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.questionTags, Icons.style_outlined));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(
              OKDialogue, StringConstant.pleaseDownloadAllTermsWithin),
          findsOneWidget);
      expect(find.byType(QuestionTagWidget), findsNothing);
    });

    testWidgets(
        'dialogue is not shown when all terms are (up-to-date and downloaded) or not enabled',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      TermService termService = Get.find();
      TermsParentService termsParentService = Get.find();
      await termService.addTerms([
        TermData(
            const Term(
                id: 10000,
                uuid: 'uuid',
                name: 'term with no tag',
                type: 1,
                creation: '2023-01-01 11:12:13',
                enabled: 0,
                free: 1,
                ordering: 12,
                needsUpdate: 1,
                captureable: 0,
                textCulumn: '',
                outerNote: ''),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1))
      ]);
      await termsParentService.addTermsParents([
        TermsParentData(
            const TermsParent(
                termId: 10000,
                parentTermId: 1,
                rootTermId: -1,
                creation: '2022-01-01 11:12:13'),
            deletedAt: const DeletedAt(null))
      ]);

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.questionTags, Icons.style_outlined));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(
              OKDialogue, StringConstant.pleaseDownloadAllTermsWithin),
          findsNothing);
      expect(find.byType(QuestionTagWidget), findsAtLeast(1));
    });

    testWidgets(
        'dialogue is not shown when all terms are (up-to-date and downloaded) or not enabled',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.questionTags, Icons.style_outlined));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(
              OKDialogue, StringConstant.pleaseDownloadAllTermsWithin),
          findsNothing);
      expect(find.byType(QuestionTagWidget), findsAtLeast(1));
    });
  });

  group('search button tests', () {
    testWidgets('button is rendered', (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(
              TermTagWidget, StringConstant.search, Icons.search),
          findsOneWidget);
    });

    testWidgets('button tapping opens questions screen', (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      // tap the search button
      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.search, Icons.search));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.byType(QuestionTitle), findsNothing);
      expect(
          find.widgetWithText(AppBar, StringConstant.search), findsOneWidget);
    });
  });

  group('favorite button tests', () {
    testWidgets('button is rendered', (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(
              TermTagWidget, StringConstant.favorite, Icons.star),
          findsOneWidget);
    });

    testWidgets('button tapping opens favorite questions screen',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      QuestionService questionService = Get.find();
      QuestionPropertyService questionPropertyService = Get.find();
      await questionService.addQuestions([
        const Question(
            id: 1000,
            uuid: 'uuid',
            title: 'favorite question',
            titleTranslation: 'titleTranslation',
            labelId: 0,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 3,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2022-01-01 11:11:11',
            editionDate: ''),
        const Question(
            id: 1001,
            uuid: 'uuid',
            title: 'not favorite question',
            titleTranslation: 'titleTranslation',
            labelId: 0,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 3,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2022-01-01 11:11:11',
            editionDate: '')
      ]);
      await questionPropertyService.addQuestionToFavorite(1000);

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      // tap the search button
      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.favorite, Icons.star));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(
          find.widgetWithText(AppBar, StringConstant.favorite), findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'favorite question'),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'not favorite question'),
          findsNothing);
    });
  });

  group('edited button tests', () {
    testWidgets('button is rendered', (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(
              TermTagWidget, StringConstant.edited, Icons.rule),
          findsOneWidget);
    });

    testWidgets(
        'dialogue is shown when there are terms that needs to be downloaded',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      await addTermWithNoTag();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.edited, Icons.rule));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(
              OKDialogue, StringConstant.pleaseDownloadAllTermsWithin),
          findsOneWidget);
      expect(find.byType(QuestionsScreen), findsNothing);
    });

    testWidgets(
        'dialogue is shown when there are terms that needs to be updated',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      TermService termService = Get.find();
      TermsParentService termsParentService = Get.find();
      await termService.addTerms([
        TermData(
            const Term(
                id: 10000,
                uuid: 'uuid',
                name: 'term with no tag',
                type: 1,
                creation: '2023-01-01 11:12:13',
                enabled: 1,
                free: 1,
                ordering: 12,
                needsUpdate: 1,
                captureable: 0,
                textCulumn: '',
                outerNote: ''),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1))
      ]);
      await termsParentService.addTermsParents([
        TermsParentData(
            const TermsParent(
                termId: 10000,
                parentTermId: 1,
                rootTermId: -1,
                creation: '2022-01-01 11:12:13'),
            deletedAt: const DeletedAt(null))
      ]);

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.edited, Icons.rule));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(
              OKDialogue, StringConstant.pleaseDownloadAllTermsWithin),
          findsOneWidget);
      expect(find.byType(QuestionsScreen), findsNothing);
    });

    testWidgets(
        'dialogue is not shown when all terms are (up-to-date and downloaded) or not enabled',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      TermService termService = Get.find();
      TermsParentService termsParentService = Get.find();
      await termService.addTerms([
        TermData(
            const Term(
                id: 10000,
                uuid: 'uuid',
                name: 'term with no tag',
                type: 1,
                creation: '2023-01-01 11:12:13',
                enabled: 0,
                free: 1,
                ordering: 12,
                needsUpdate: 1,
                captureable: 0,
                textCulumn: '',
                outerNote: ''),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1))
      ]);
      await termsParentService.addTermsParents([
        TermsParentData(
            const TermsParent(
                termId: 10000,
                parentTermId: 1,
                rootTermId: -1,
                creation: '2022-01-01 11:12:13'),
            deletedAt: const DeletedAt(null))
      ]);

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.edited, Icons.rule));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(
              OKDialogue, StringConstant.pleaseDownloadAllTermsWithin),
          findsNothing);
      expect(find.byType(QuestionsScreen), findsOneWidget);
    });

    testWidgets(
        'dialogue is not shown when all terms are (up-to-date and downloaded) or not enabled',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.edited, Icons.rule));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(
              OKDialogue, StringConstant.pleaseDownloadAllTermsWithin),
          findsNothing);
      expect(find.byType(QuestionsScreen), findsOneWidget);
    });

    testWidgets('button tapping opens edited questions screen',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      QuestionService questionService = Get.find();
      await questionService.addQuestions([
        const Question(
            id: 1000,
            uuid: 'uuid',
            title: 'not edited question',
            titleTranslation: 'titleTranslation',
            labelId: 0,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 3,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2022-01-01 11:11:11',
            editionDate: ''),
        const Question(
            id: 1001,
            uuid: 'uuid',
            title: 'edited question',
            titleTranslation: 'titleTranslation',
            labelId: 0,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 3,
            specialCharacter: 1,
            type: 1,
            edited: 1,
            imageUrl: '',
            creation: '2022-01-01 11:11:11',
            editionDate: '2023-01-01 11:11:11')
      ]);

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      // tap the search button
      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.edited, Icons.rule));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(
          find.widgetWithText(AppBar, StringConstant.edited), findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'edited question'),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'not edited question'),
          findsNothing);
    });
  });

  group('easy/medium/difficult questions buttons tests', () {
    group('easy button tests', () {
      testWidgets('easy button is not renderd if not filtering enabled',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await addEasyMediumDifficultQuestions();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        expect(
            widgetWithTextAndIcon(
                TermTagWidget, StringConstant.easyQuestions, Icons.maximize),
            findsNothing);
      });

      testWidgets(
          'easy button is not renderd if filtering enabled but there is no easy questions',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await enableQuestionsFiltering();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        expect(
            widgetWithTextAndIcon(
                TermTagWidget, StringConstant.easyQuestions, Icons.maximize),
            findsNothing);
      });

      testWidgets(
          'easy button is renderd if filtering enabled and there is an easy question',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await enableQuestionsFiltering();
        await addEasyMediumDifficultQuestions();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        expect(
            widgetWithTextAndIcon(
                TermTagWidget, StringConstant.easyQuestions, Icons.maximize),
            findsOneWidget);
      });

      testWidgets('easy button tapping opens easy questions',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await enableQuestionsFiltering();
        await addEasyMediumDifficultQuestions();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        // tap the button
        await widgetTester.tap(widgetWithTextAndIcon(
            TermTagWidget, StringConstant.easyQuestions, Icons.maximize));
        await widgetTester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsOneWidget);
        expect(find.widgetWithText(AppBar, StringConstant.easyQuestions),
            findsOneWidget);
        expect(find.widgetWithText(QuestionTitle, 'easy question'),
            findsOneWidget);
        expect(find.widgetWithText(QuestionTitle, 'medium question'),
            findsNothing);
        expect(find.widgetWithText(QuestionTitle, 'difficult question'),
            findsNothing);
      });
    });

    group('medium button tests', () {
      testWidgets('button is not renderd if not filtering enabled',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await addEasyMediumDifficultQuestions();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        expect(
            widgetWithTextAndIcon(TermTagWidget, StringConstant.mediumQuestions,
                Icons.horizontal_rule),
            findsNothing);
      });

      testWidgets(
          'button is not renderd if filtering enabled but there is no medium questions',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await enableQuestionsFiltering();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        expect(
            widgetWithTextAndIcon(TermTagWidget, StringConstant.mediumQuestions,
                Icons.horizontal_rule),
            findsNothing);
      });

      testWidgets(
          'button is renderd if filtering enabled and there is a medium question',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await enableQuestionsFiltering();
        await addEasyMediumDifficultQuestions();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        expect(
            widgetWithTextAndIcon(TermTagWidget, StringConstant.mediumQuestions,
                Icons.horizontal_rule),
            findsOneWidget);
      });

      testWidgets('button tapping opens medium questions',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await enableQuestionsFiltering();
        await addEasyMediumDifficultQuestions();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        // tap the button
        await widgetTester.tap(widgetWithTextAndIcon(TermTagWidget,
            StringConstant.mediumQuestions, Icons.horizontal_rule));
        await widgetTester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsOneWidget);
        expect(find.widgetWithText(AppBar, StringConstant.mediumQuestions),
            findsOneWidget);
        expect(
            find.widgetWithText(QuestionTitle, 'easy question'), findsNothing);
        expect(find.widgetWithText(QuestionTitle, 'medium question'),
            findsOneWidget);
        expect(find.widgetWithText(QuestionTitle, 'difficult question'),
            findsNothing);
      });
    });

    group('difficut button tests', () {
      testWidgets('button is not renderd if not filtering enabled',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await addEasyMediumDifficultQuestions();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        expect(
            widgetWithTextAndIcon(TermTagWidget,
                StringConstant.difficultQuestions, Icons.minimize),
            findsNothing);
      });

      testWidgets(
          'button is not renderd if filtering enabled but there is no difficult questions',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await enableQuestionsFiltering();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        expect(
            widgetWithTextAndIcon(TermTagWidget,
                StringConstant.difficultQuestions, Icons.minimize),
            findsNothing);
      });

      testWidgets(
          'button is renderd if filtering enabled and there is a difficult question',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await enableQuestionsFiltering();
        await addEasyMediumDifficultQuestions();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        expect(
            widgetWithTextAndIcon(TermTagWidget,
                StringConstant.difficultQuestions, Icons.minimize),
            findsOneWidget);
      });

      testWidgets('button tapping opens difficult questions',
          (widgetTester) async {
        await databaseService.seedTermsData();
        await databaseService.seedQuestionsTagsData();
        await enableQuestionsFiltering();
        await addEasyMediumDifficultQuestions();

        await widgetTester.pumpWidget(const MyApp(
          defaultRoute: HomeScreen.route,
        ));
        await widgetTester.pumpAndSettle();

        // tap the parent term
        await widgetTester.tap(find.text('parent'));
        await widgetTester.pumpAndSettle();

        // tap the button
        await widgetTester.tap(widgetWithTextAndIcon(
            TermTagWidget, StringConstant.difficultQuestions, Icons.minimize));
        await widgetTester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsOneWidget);
        expect(find.widgetWithText(AppBar, StringConstant.difficultQuestions),
            findsOneWidget);
        expect(
            find.widgetWithText(QuestionTitle, 'easy question'), findsNothing);
        expect(find.widgetWithText(QuestionTitle, 'medium question'),
            findsNothing);
        expect(find.widgetWithText(QuestionTitle, 'difficult question'),
            findsOneWidget);
      });
    });
  });

  group('wrong button tests', () {
    testWidgets('button not rendered if there are no templates underneath',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(
              TermTagWidget, StringConstant.wrongQuestions, Icons.block),
          findsNothing);
    });

    testWidgets('button not rendered if there are no wrong answers underneath',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(
              TermTagWidget, StringConstant.wrongQuestions, Icons.block),
          findsNothing);
    });

    testWidgets(
        'button is rendered if there are templates and wrong answers underneath',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      await addTemplateTerm();

      QuestionService questionService = Get.find();
      AnswerService answerService = Get.find();
      AnswerPropertyService answerPropertyService = Get.find();
      await questionService.addQuestions([
        const Question(
            id: 1000,
            uuid: 'uuid',
            title: 'wrong question',
            titleTranslation: 'titleTranslation',
            labelId: 0,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 3,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2022-01-01 11:11:11',
            editionDate: ''),
      ]);
      await answerService.addAnswers([
        const Answer(
            id: 1000,
            uuid: 'uuid',
            title: 'correct',
            titleTranslation: 'titleTranslation',
            isCorrect: 1,
            parentQuestionId: 1000,
            specialCharacter: 1,
            creation: '2023-01-02 12:13:14',
            checkedCount: 10),
        const Answer(
            id: 1001,
            uuid: 'uuid 2',
            title: 'incorrect',
            titleTranslation: 'titleTranslation',
            isCorrect: 0,
            parentQuestionId: 1000,
            specialCharacter: 1,
            creation: '2023-01-02 12:13:14',
            checkedCount: 10)
      ]);
      await answerPropertyService.checkAnswer(1001);

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(
          widgetWithTextAndIcon(
              TermTagWidget, StringConstant.wrongQuestions, Icons.block),
          findsOneWidget);
    });

    testWidgets('button tapping opens wrong questions screen',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      await addTemplateTerm();

      QuestionService questionService = Get.find();
      AnswerService answerService = Get.find();
      AnswerPropertyService answerPropertyService = Get.find();
      await questionService.addQuestions([
        const Question(
            id: 1000,
            uuid: 'uuid',
            title: 'wrong question',
            titleTranslation: 'titleTranslation',
            labelId: 0,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 3,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2022-01-01 11:11:11',
            editionDate: ''),
        const Question(
            id: 1001,
            uuid: 'uuid',
            title: 'correct question',
            titleTranslation: 'titleTranslation',
            labelId: 0,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 3,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2022-01-01 11:11:11',
            editionDate: ''),
      ]);
      await answerService.addAnswers([
        // wrong question answers
        const Answer(
            id: 1000,
            uuid: 'uuid',
            title: 'correct answer 1',
            titleTranslation: 'titleTranslation',
            isCorrect: 1,
            parentQuestionId: 1000,
            specialCharacter: 1,
            creation: '2023-01-02 12:13:14',
            checkedCount: 10),
        const Answer(
            id: 1001,
            uuid: 'uuid 2',
            title: 'incorrect answer 1',
            titleTranslation: 'titleTranslation',
            isCorrect: 0,
            parentQuestionId: 1000,
            specialCharacter: 1,
            creation: '2023-01-02 12:13:14',
            checkedCount: 10),

        // correct question answers
        const Answer(
            id: 1002,
            uuid: 'uuid',
            title: 'correct answer 2',
            titleTranslation: 'titleTranslation',
            isCorrect: 1,
            parentQuestionId: 1001,
            specialCharacter: 1,
            creation: '2023-01-02 12:13:14',
            checkedCount: 10),
        const Answer(
            id: 1003,
            uuid: 'uuid 2',
            title: 'incorrect answer 2',
            titleTranslation: 'titleTranslation',
            isCorrect: 0,
            parentQuestionId: 1001,
            specialCharacter: 1,
            creation: '2023-01-02 12:13:14',
            checkedCount: 10)
      ]);
      await answerPropertyService.checkAnswer(1001);
      await answerPropertyService.checkAnswer(1002);

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      // tap the search button
      await widgetTester.tap(widgetWithTextAndIcon(
          TermTagWidget, StringConstant.wrongQuestions, Icons.block));
      await widgetTester.pumpAndSettle();

      expect(find.byType(QuestionsScreen), findsOneWidget);
      expect(find.widgetWithText(AppBar, StringConstant.wrongQuestions),
          findsOneWidget);
      expect(
          find.widgetWithText(QuestionTitle, 'wrong question'), findsOneWidget);
      expect(
          find.widgetWithText(QuestionTitle, 'correct question'), findsNothing);
    });
  });
}
