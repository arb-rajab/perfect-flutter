import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/dialogues/user_note_dialogue.dart';
import 'package:beta/presentation/media_slider/media_slider_screen.dart';
import 'package:beta/presentation/questions/math_widget.dart';
import 'package:beta/presentation/questions/question_body.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/footer_icons.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart'
    show Mock, when, registerFallbackValue, any, verify;

import '../../common/tests.dart';

class MockQuestionService extends Mock implements QuestionService {}

class MockQuestionPropertyService extends Mock
    implements QuestionPropertyService {}

void main() {
  late QuestionData questionData;

  setUp(() async {
    await initTests();
  });

  setUpAll(() {
    registerFallbackValue(const Id(1));
  });

  void createQuestionData() {
    questionData = QuestionData(
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
        parentTermName: 'parent term name',
        numberOfMedias: 0,
        hasNote: false,
        indexInTerm: 0)
      ..questionProperties = [];
  }

  group('check icon tests', () {
    testWidgets('check icon is visible for non-template term',
        (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('check icon is not visible for template term',
        (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      questionsController.term = const Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: TermType.template,
          creation: '2024-01-01 11:12:13',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote');
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('check icon tapping corrects the question',
        (widgetTester) async {
      createQuestionData();
      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource.easy,
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      await widgetTester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await widgetTester.pumpAndSettle();

      // tap the check icon
      await widgetTester.tap(find.byIcon(Icons.check));
      await widgetTester.pumpAndSettle();

      expect(questionData.corrected, isTrue);
    });
  });

  group('favorite icons tests', () {
    testWidgets('favorite icon is renderd outlined if not favorite',
        (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.star_outline), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNothing);
    });

    testWidgets('favorite icon is renderd filled if favorite',
        (widgetTester) async {
      createQuestionData();
      questionData.questionProperties = [
        QuestionProperty(
            questionId: questionData.question.id,
            name: 'favorite',
            value: 'true')
      ];
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.star_outline), findsNothing);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets(
        'favorite icon tapping changes question from not favorite to favorite',
        (widgetTester) async {
      Get.delete<QuestionPropertyService>();
      final mockQuestionPropertyService =
          Get.put<QuestionPropertyService>(MockQuestionPropertyService());
      // Stub the method to return a Future
      when(() => mockQuestionPropertyService.addQuestionToFavorite(1))
          .thenAnswer((_) => Future.value());

      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      // Stub the method to return a Future
      when(() => mockQuestionPropertyService.getQuestionProperties(any()))
          .thenAnswer((_) => Future.value([
                const QuestionProperty(
                    questionId: 1, name: 'favorite', value: 'true')
              ]));

      await widgetTester.tap(find.byIcon(Icons.star_outline));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.star_outline), findsNothing);
      expect(find.byIcon(Icons.star), findsOneWidget);

      verify(() => mockQuestionPropertyService.addQuestionToFavorite(1))
          .called(1);
    });

    testWidgets(
        'favorite icon tapping changes question from not favorite to favorite',
        (widgetTester) async {
      Get.delete<QuestionPropertyService>();
      final mockQuestionPropertyService =
          Get.put<QuestionPropertyService>(MockQuestionPropertyService());
      // Stub the method to return a Future
      when(() => mockQuestionPropertyService.removeQuestionFromFavorite(1))
          .thenAnswer((_) => Future.value());

      createQuestionData();
      questionData.questionProperties = [
        QuestionProperty(
            questionId: questionData.question.id,
            name: 'favorite',
            value: 'true')
      ];
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      // Stub the method to return a Future
      when(() => mockQuestionPropertyService.getQuestionProperties(any()))
          .thenAnswer((_) => Future.value([
                const QuestionProperty(
                    questionId: 1, name: 'favorite', value: 'false')
              ]));

      await widgetTester.tap(find.byIcon(Icons.star));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.star_outline), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNothing);

      verify(() => mockQuestionPropertyService.removeQuestionFromFavorite(1))
          .called(1);
    });
  });

  group('user note icons tests', () {
    testWidgets('user note icon is renderd outlined if there is no note',
        (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.note_outlined), findsOneWidget);
      expect(find.byIcon(Icons.note), findsNothing);
    });

    testWidgets('user note icon is renderd filled if there is a note',
        (widgetTester) async {
      createQuestionData();
      questionData.questionProperties = [
        QuestionProperty(
            questionId: questionData.question.id,
            name: 'userNote',
            value: 'random note')
      ];
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.note_outlined), findsNothing);
      expect(find.byIcon(Icons.note), findsOneWidget);
    });

    testWidgets('user note icon tapping shows user note dialogue',
        (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.note_outlined));
      await widgetTester.pumpAndSettle();

      expect(find.byType(UserNoteDialogue), findsOneWidget);
    });

    testWidgets(
        'user note icon tapping shows user note dialogue, then dismissing makes no change',
        (widgetTester) async {
      createQuestionData();
      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource.easy,
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      await widgetTester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.note_outlined));
      await widgetTester.pumpAndSettle();

      Navigator.of(widgetTester.element(find.byType(UserNoteDialogue))).pop();
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.note_outlined), findsOneWidget);
      expect(find.byIcon(Icons.note), findsNothing);
    });

    testWidgets(
        'user note icon tapping shows user note dialogue, then saving a note changes the icon',
        (widgetTester) async {
      createQuestionData();
      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource.easy,
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      await widgetTester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.note_outlined));
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(find.byType(InputWidget), 'text');

      await widgetTester.tap(find.text(StringConstant.save));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.note_outlined), findsNothing);
      expect(find.byIcon(Icons.note), findsOneWidget);
    });

    testWidgets(
        'user note icon tapping shows user note dialogue, then entering an empty note deletes the note',
        (widgetTester) async {
      createQuestionData();
      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      QuestionPropertyService questionPropertyService = Get.find();
      await questionPropertyService.setUserNote(1, 'note');

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource.easy,
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      await widgetTester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.note));
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(find.byType(InputWidget), '');

      await widgetTester.tap(find.text(StringConstant.save));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.note_outlined), findsOneWidget);
      expect(find.byIcon(Icons.note), findsNothing);
    });

    testWidgets(
        'user note icon tapping shows user note dialogue, then tapping delete deletes the note',
        (widgetTester) async {
      createQuestionData();
      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      QuestionPropertyService questionPropertyService = Get.find();
      await questionPropertyService.setUserNote(1, 'note');

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource.easy,
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      await widgetTester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.note));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.text(StringConstant.delete));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.note_outlined), findsOneWidget);
      expect(find.byIcon(Icons.note), findsNothing);
    });
  });

  group('question note tests', () {
    testWidgets('question note icon is not rendered if there is no note',
        (widgetTester) async {
      createQuestionData();
      questionData.question =
          questionData.question.copyWith(note: '', noteTranslation: '');
      questionData.hasNote = false;
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.info), findsNothing);
    });

    testWidgets(
        'question note icon is not rendered if there is a note and the term is a template term and not corrected',
        (widgetTester) async {
      createQuestionData();
      questionData.hasNote = true;
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      questionsController.term = const Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: TermType.template,
          creation: '2024-01-01 11:12:13',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote');
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.info), findsNothing);
    });

    testWidgets(
        'question note icon is rendered if there is a note and the term is a template term and is corrected',
        (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      questionData.hasNote = true;
      questionsController.term = const Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: TermType.template,
          creation: '2024-01-01 11:12:13',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote');
      questionData.corrected = true;
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.info), findsOneWidget);
    });
    testWidgets(
        'question note icon is rendered if there is a note and the term is not a template term',
        (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      questionData.hasNote = true;
      questionsController.term = const Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: TermType.questions,
          creation: '2024-01-01 11:12:13',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote');
      questionData.corrected = true;
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('note icon tapping, shows question note', (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      questionData.hasNote = true;
      questionsController.term = const Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: TermType.questions,
          creation: '2024-01-01 11:12:13',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote');
      questionData.corrected = true;
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.info));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(OKDialogue, questionData.question.note),
          findsOneWidget);
    });

    testWidgets(
        'note icon tapping, shows question note translation if translated',
        (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      questionData.hasNote = true;
      questionData.translatable = true;
      questionData.translated = true;
      questionsController.term = const Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: TermType.questions,
          creation: '2024-01-01 11:12:13',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote');
      questionData.corrected = true;
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.info));
      await widgetTester.pumpAndSettle();

      expect(
          find.widgetWithText(
              OKDialogue, questionData.question.noteTranslation),
          findsOneWidget);
    });

    testWidgets(
        'note icon tapping, shows question note math widget if question is math type',
        (widgetTester) async {
      createQuestionData();
      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      questionData.question = questionData.question
          .copyWith(specialCharacter: SpecialCharacter.math);
      questionData.hasNote = true;
      questionsController.term = const Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: TermType.questions,
          creation: '2024-01-01 11:12:13',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 1,
          captureable: 1,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote');
      questionData.corrected = true;
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.info));
      await widgetTester.pumpAndSettle();

      expect(find.byType(MathWidget), findsOneWidget);
    });
  });

  group('edited question tests', () {
    testWidgets('question edit icon is not rendered if question is not edited',
        (widgetTester) async {
      createQuestionData();
      questionData.question = questionData.question.copyWith(edited: 0);

      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.rule), findsNothing);
    });

    testWidgets('question edit icon is rendered if question is edited',
        (widgetTester) async {
      createQuestionData();
      questionData.question = questionData.question.copyWith(edited: 1);

      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.rule), findsOneWidget);
    });

    testWidgets('question edit icon tapping, shows edition data',
        (widgetTester) async {
      createQuestionData();
      questionData.question = questionData.question
          .copyWith(edited: 1, editionDate: '2024-01-01 11:12:13');

      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.rule));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(OKDialogue, StringConstant.edittedOn),
          findsOneWidget);
    });
  });

  group('question medias tests', () {
    testWidgets('attachment icon is not rendered if there is no media',
        (widgetTester) async {
      createQuestionData();
      questionData.numberOfMedias = 0;

      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.attachment), findsNothing);
    });

    testWidgets('attachment icon is not rendered if there is no media',
        (widgetTester) async {
      createQuestionData();
      questionData.numberOfMedias = 3;

      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.attachment), findsOneWidget);
    });

    testWidgets('attachment icon tapping opens media screen',
        (widgetTester) async {
      createQuestionData();
      questionData.numberOfMedias = 4;
      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource.easy,
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      await widgetTester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.attachment));
      await widgetTester.pumpAndSettle();

      expect(find.byType(MediaSliderScreen), findsOneWidget);
    });
  });

  group('translate icons tests', () {
    testWidgets('translate icon is not rendered if there is no translation',
        (widgetTester) async {
      createQuestionData();
      questionData.question = questionData.question
          .copyWith(titleTranslation: '', noteTranslation: '');
      // questionData.translatable = false;

      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.translate), findsNothing);
    });

    testWidgets('translate icon is rendered if there is a translation',
        (widgetTester) async {
      createQuestionData();
      questionData.translatable = true;

      QuestionsController questionsController =
          QuestionsController(QuestionsScreenState());
      await widgetTester.pumpWidget(MyApp(
        child: FooterIcons(
            questionData: questionData,
            questionsController: questionsController),
      ));
      await widgetTester.pumpAndSettle();

      expect(find.byIcon(Icons.translate), findsOneWidget);
    });

    testWidgets('translate icon tapping shows translation',
        (widgetTester) async {
      createQuestionData();

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      AnswerService answerService = Get.find();
      answerService.addAnswers([
        const Answer(
            id: 1,
            uuid: 'uuid',
            title: 'title',
            titleTranslation: 'titleTranslation',
            isCorrect: 1,
            parentQuestionId: 1,
            specialCharacter: 1,
            creation: '2025-04-07 13:15:17',
            checkedCount: 10)
      ]);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource.easy,
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      await widgetTester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, questionData.question.title),
          findsOneWidget);
      expect(
          find.widgetWithText(
              QuestionTitle, questionData.question.titleTranslation),
          findsNothing);

      expect(find.widgetWithText(QuestionBody, 'title'), findsOneWidget);
      expect(
          find.widgetWithText(QuestionBody, 'titleTranslation'), findsNothing);

      await widgetTester.tap(find.byIcon(Icons.translate));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, questionData.question.title),
          findsNothing);
      expect(
          find.widgetWithText(
              QuestionTitle, questionData.question.titleTranslation),
          findsOneWidget);

      expect(find.widgetWithText(QuestionBody, 'title'), findsNothing);
      expect(find.widgetWithText(QuestionBody, 'titleTranslation'),
          findsOneWidget);
    });

    testWidgets('translate icon double tapping hides translation',
        (widgetTester) async {
      createQuestionData();

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      AnswerService answerService = Get.find();
      answerService.addAnswers([
        const Answer(
            id: 1,
            uuid: 'uuid',
            title: 'title',
            titleTranslation: 'titleTranslation',
            isCorrect: 1,
            parentQuestionId: 1,
            specialCharacter: 1,
            creation: '2025-04-07 13:15:17',
            checkedCount: 10)
      ]);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource.easy,
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      await widgetTester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, questionData.question.title),
          findsOneWidget);
      expect(
          find.widgetWithText(
              QuestionTitle, questionData.question.titleTranslation),
          findsNothing);

      expect(find.widgetWithText(QuestionBody, 'title'), findsOneWidget);
      expect(
          find.widgetWithText(QuestionBody, 'titleTranslation'), findsNothing);

      await widgetTester.tap(find.byIcon(Icons.translate));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.translate));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(QuestionTitle, questionData.question.title),
          findsOneWidget);
      expect(
          find.widgetWithText(
              QuestionTitle, questionData.question.titleTranslation),
          findsNothing);

      expect(find.widgetWithText(QuestionBody, 'title'), findsOneWidget);
      expect(
          find.widgetWithText(QuestionBody, 'titleTranslation'), findsNothing);
    });
  });
}
