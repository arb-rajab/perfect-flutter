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
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/questions/level_group.dart';
import 'package:beta/presentation/questions/question_tags_choice.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_header.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() {
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
          editionDate: ''),
      const Question(
          id: 2,
          uuid: 'uuid',
          title: 'favorite question',
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
          title: 'not favorite question',
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
    ]);
    QuestionPropertyService questionPropertyService = Get.find();
    await questionPropertyService.addQuestionToFavorite(2);
  }

  testWidgets('components are rendered', (widgetTester) async {
    QuestionsController questionsController =
        Get.put(QuestionsController(QuestionsScreenState()));

    await widgetTester.pumpWidget(MyApp(
      child: QuestionsHeader(
        questionsController: questionsController,
      ),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byType(NumberOfQuestions), findsOneWidget);
    expect(find.byType(ShowFavoriteOnly), findsOneWidget);
    expect(find.byType(ShowEditedOnly), findsOneWidget);
  });

  testWidgets('number of questions text is rendered', (widgetTester) async {
    QuestionsController questionsController =
        Get.put(QuestionsController(QuestionsScreenState()));

    await widgetTester.pumpWidget(MyApp(
      child: NumberOfQuestions(
        questionsController: questionsController,
      ),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.numberOfQuestions), findsOneWidget);
  });

  group('show favorite only tests', () {
    testWidgets('show favorite only text is rendered', (widgetTester) async {
      QuestionsController questionsController =
          Get.put(QuestionsController(QuestionsScreenState()));

      await widgetTester.pumpWidget(MyApp(
        child: ShowFavoriteOnly(
          questionsController: questionsController,
        ),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.text(StringConstant.showFavoriteOnly), findsOneWidget);
    });

    testWidgets('show favorite questions shows only favorite questiosn',
        (widgetTester) async {
      await seedQuestionsData();
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, 'title'), findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'favorite question'),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'not favorite question'),
          findsOneWidget);

      // tap favorite only
      await widgetTester.tap(find.byType(ShowFavoriteOnly));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, 'title'), findsNothing);
      expect(find.widgetWithText(QuestionTitle, 'favorite question'),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'not favorite question'),
          findsNothing);
    });

    testWidgets(
        'show favorite questions shows only favorite questiosn, then tapping it again shows all questions',
        (widgetTester) async {
      await seedQuestionsData();
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      // tap favorite only
      await widgetTester.tap(find.byType(ShowFavoriteOnly));
      await widgetTester.pumpAndSettle();

      // tap favorite only
      await widgetTester.tap(find.byType(ShowFavoriteOnly));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, 'title'), findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'favorite question'),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'not favorite question'),
          findsOneWidget);
    });
  });

  group('show edited only tests', () {
    testWidgets('show edited only text is rendered', (widgetTester) async {
      QuestionsController questionsController =
          Get.put(QuestionsController(QuestionsScreenState()));

      await widgetTester.pumpWidget(MyApp(
        child: ShowEditedOnly(
          questionsController: questionsController,
        ),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.text(StringConstant.showEditedOnly), findsOneWidget);
    });

    testWidgets('show edited questions shows only edited questiosn',
        (widgetTester) async {
      await seedQuestionsData();
      QuestionService questionService = Get.find();
      await questionService.addQuestions([
        const Question(
            id: 2,
            uuid: 'uuid',
            title: 'edited question',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 1,
            specialCharacter: 1,
            type: 1,
            edited: 1,
            imageUrl: '',
            creation: '2024-01-01 11:12:13',
            editionDate: '2025-01-01 11:12:13'),
        const Question(
            id: 3,
            uuid: 'uuid',
            title: 'not edited question',
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
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, 'title'), findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'edited question'),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'not edited question'),
          findsOneWidget);

      // tap favorite only
      await widgetTester.tap(find.byType(ShowEditedOnly));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, 'title'), findsNothing);
      expect(find.widgetWithText(QuestionTitle, 'edited question'),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'not edited question'),
          findsNothing);
    });

    testWidgets(
        'show edited questions shows only edited questiosn, then tapping it again shows all questions',
        (widgetTester) async {
      await seedQuestionsData();
      QuestionService questionService = Get.find();
      await questionService.addQuestions([
        const Question(
            id: 2,
            uuid: 'uuid',
            title: 'edited question',
            titleTranslation: 'titleTranslation',
            labelId: 1,
            note: 'note',
            noteTranslation: 'noteTranslation',
            parentTermId: 1,
            specialCharacter: 1,
            type: 1,
            edited: 1,
            imageUrl: '',
            creation: '2024-01-01 11:12:13',
            editionDate: '2025-01-01 11:12:13'),
        const Question(
            id: 3,
            uuid: 'uuid',
            title: 'not edited question',
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
      await widgetTester
          .pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
      await widgetTester.pumpAndSettle();

      // tap favorite only
      await widgetTester.tap(find.byType(ShowEditedOnly));
      await widgetTester.pumpAndSettle();

      // tap favorite only
      await widgetTester.tap(find.byType(ShowEditedOnly));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, 'title'), findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'edited question'),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTitle, 'not edited question'),
          findsOneWidget);
    });
  });

  testWidgets('question tag choice is rendered if deep linked',
      (widgetTester) async {
    QuestionsController questionsController =
        Get.put(QuestionsController(QuestionsScreenState()))..deepLinked = true;

    await widgetTester.pumpWidget(MyApp(
      child: QuestionsHeader(
        questionsController: questionsController,
      ),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byType(QuestionTagsChoice), findsOneWidget);
  });

  testWidgets('question tag choice is not rendered if template',
      (widgetTester) async {
    await seedQuestionsData();
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

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.byType(QuestionTagsChoice), findsNothing);
  });

  testWidgets('question leveling is rendered if filtering enabled',
      (widgetTester) async {
    await seedQuestionsData();
    TermsWithQuestionsFilteringEnabledService
        termsWithQuestionsFilteringEnabledService = Get.find();
    await termsWithQuestionsFilteringEnabledService
        .addTermsWithQuestionsFilteringEnabled([
      TermsWithQuestionsFilteringEnabledProperties(
          const TermsWithQuestionsFilteringEnabledData(termId: 1),
          deletedAt: const DeletedAt(null))
    ]);

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.byType(LevelGroup), findsOneWidget);
  });

  testWidgets('question leveling is not rendered if filtering not enabled',
      (widgetTester) async {
    await seedQuestionsData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.byType(LevelGroup), findsNothing);
  });
}
