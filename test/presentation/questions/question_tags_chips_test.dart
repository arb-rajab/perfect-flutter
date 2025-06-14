import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/web/web_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/tests.dart';

class MockTermService extends Mock implements TermService {}

class MockQuestionService extends Mock implements QuestionService {}

class MockQuestionTagService extends Mock implements QuestionTagService {}

void main() {
  setUp(() async {
    await initTests();
  });

  late QuestionData questionData;
  late QuestionsScreenArgument questionsScreenArgument;
  late QuestionsController questionsController;

  setUpAll(() {
    registerFallbackValue(const Id(1));
  });

  void createTestData(
      {argumentSource = QuestionScreenSource.term, Id sourceId = const Id(1)}) {
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
            specialCharacter: SpecialCharacter.none,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2024-01-01 11:12:13',
            editionDate: ''),
        parentTermName: 'parent term name',
        numberOfMedias: 0,
        hasNote: false,
        indexInTerm: 0)
      ..questionTags = [
        const QuestionTag(
            id: 1,
            name: 'tag 1',
            parentTagId: 0,
            hasInformation: 0,
            creation: '2024-01-01 11:13:15'),
        const QuestionTag(
            id: 2,
            name: 'tag 2',
            parentTagId: 0,
            hasInformation: 0,
            creation: '2024-01-01 11:13:15')
      ];

    questionsScreenArgument = QuestionsScreenArgument(
      query: 'test query',
      source: argumentSource,
      sourceId: sourceId,
      resourceTermId: const Id(1),
      title: const t.Title('Test Title'),
    );

    questionsController = QuestionsController(QuestionsScreenState());
    questionsController.questionsScreenArgument = questionsScreenArgument;

    MockTermService mockTermService = MockTermService();
    Get.delete<TermService>();
    Get.put<TermService>(mockTermService);
    when(() => mockTermService.getTermById(any<Id>())).thenAnswer((_) =>
        Future.value(const Term(
            id: 1,
            uuid: 'uuid',
            name: 'Parent Term',
            type: TermType.questions,
            creation: '2024-01-01 11:12:13',
            enabled: 1,
            free: 1,
            ordering: 1,
            needsUpdate: 0,
            captureable: 1,
            textCulumn: 'textCulumn',
            outerNote: 'outerNote')));

    MockQuestionService mockQuestionService = MockQuestionService();
    Get.delete<QuestionService>();
    Get.put<QuestionService>(mockQuestionService);

    when(() => mockQuestionService.getQuestionsFromQuery(any()))
        .thenAnswer((_) => Future.value([questionData]));

    MockQuestionTagService mockQuestionTagService = MockQuestionTagService();
    Get.delete<QuestionTagService>();
    Get.put<QuestionTagService>(mockQuestionTagService);

    when(() => mockQuestionTagService.getQuestionTags(any<Id>()))
        .thenAnswer((_) => Future.value(questionData.questionTags));
  }

  Future createWidgetUnderTest(WidgetTester widgetTester) async {
    Get.put(questionsScreenArgument);
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: QuestionsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
  }

  testWidgets('displays all question tags as chips', (tester) async {
    createTestData();
    await createWidgetUnderTest(tester);

    expect(find.text('tag 1'), findsOneWidget);
    expect(find.text('tag 2'), findsOneWidget);
    expect(find.byType(Chip), findsNWidgets(2));
  });

  testWidgets('shows confirmation dialog when tapping a chip', (tester) async {
    createTestData();
    await createWidgetUnderTest(tester);

    await tester.tap(find.text('tag 1'));
    await tester.pumpAndSettle();

    expect(
        find.widgetWithText(
            ConfirmDialogue, StringConstant.aboutToMoveToQuestionTag),
        findsOneWidget);
  });

  testWidgets(
      'shows confirmation dialog when tapping a chip, then confirming navigates to the tag questions screen',
      (tester) async {
    createTestData();
    await createWidgetUnderTest(tester);

    await tester.tap(find.text('tag 1'));
    await tester.pumpAndSettle();

    expect(
        find.widgetWithText(
            ConfirmDialogue, StringConstant.aboutToMoveToQuestionTag),
        findsOneWidget);

    await tester.tap(find.text(StringConstant.ok));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'tag 1'), findsOneWidget);
  });

  testWidgets(
      'shows confirmation dialog when tapping a chip, then cancelling dismisses the dialogue',
      (tester) async {
    createTestData();
    await createWidgetUnderTest(tester);

    await tester.tap(find.text('tag 1'));
    await tester.pumpAndSettle();

    expect(
        find.widgetWithText(
            ConfirmDialogue, StringConstant.aboutToMoveToQuestionTag),
        findsOneWidget);

    await tester.tap(find.text(StringConstant.cancel));
    await tester.pumpAndSettle();

    expect(
        find.widgetWithText(
            ConfirmDialogue, StringConstant.aboutToMoveToQuestionTag),
        findsNothing);
  });

  testWidgets(
      'does not show dialog when tapping current tag from question tag questions screen',
      (tester) async {
    createTestData(
        argumentSource: QuestionScreenSource.questionTag,
        sourceId: const Id(1));
    await createWidgetUnderTest(tester);

    await tester.tap(find.text('tag 1'));
    await tester.pumpAndSettle();

    expect(
        find.widgetWithText(
            ConfirmDialogue, StringConstant.aboutToMoveToQuestionTag),
        findsNothing);
  });

  testWidgets(
      'shows dialog when tapping another tag from question tag questions screen',
      (tester) async {
    createTestData(
        argumentSource: QuestionScreenSource.questionTag,
        sourceId: const Id(1));
    await createWidgetUnderTest(tester);

    await tester.tap(find.text('tag 2'));
    await tester.pumpAndSettle();

    expect(
        find.widgetWithText(
            ConfirmDialogue, StringConstant.aboutToMoveToQuestionTag),
        findsOneWidget);
  });

  testWidgets('shows web screen when delete icon is tapped', (tester) async {
    createTestData();
    await createWidgetUnderTest(tester);
    Get.delete<QuestionTagService>();
    Get.put(QuestionTagService(databaseService: databaseService));

    // Find the first delete icon and tap it
    await tester.tap(find.byIcon(Icons.article).first);
    await tester.pumpAndSettle();

    expect(find.byType(WebScreen), findsOneWidget);
  });
}
