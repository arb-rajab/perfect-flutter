import 'dart:math';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/questions/question_title_list_tile.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/constants/arguments.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/tests.dart';

class MockQuestionService extends Mock implements QuestionService {}

class MockTermService extends Mock implements TermService {}

void main() {
  setUpAll(() {
    registerFallbackValue(const Id(null));
  });
  setUp(() async {
    await initTests();
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
  });

  QuestionData createTestQuestionData({
    int id = 1,
    int parentTermId = 1,
    int labelId = 1,
    String imageUrl = '',
    String parentTermName = 'Parent Term',
    int numberOfMedias = 0,
    bool hasNote = false,
    int indexInTerm = 0,
    bool imageVisible = false,
  }) {
    final question = Question(
      id: id,
      uuid: 'test-uuid',
      title: 'Test Question',
      titleTranslation: '',
      labelId: labelId,
      note: '',
      noteTranslation: '',
      parentTermId: parentTermId,
      specialCharacter: 0,
      type: 0,
      edited: 0,
      imageUrl: imageUrl,
      creation: '2023-01-01',
      editionDate: '2023-01-01',
    );

    final questionData = QuestionData(
      question,
      parentTermName: parentTermName,
      numberOfMedias: numberOfMedias,
      hasNote: hasNote,
      indexInTerm: indexInTerm,
    )..imageVisible = imageVisible;

    return questionData;
  }

  testWidgets('renders correctly with basic question data',
      (WidgetTester tester) async {
    final questionData = createTestQuestionData();
    String query = 'query';
    Get.put(QuestionsScreenArgument(
      query: query,
      source: QuestionScreenSource.search,
      sourceId: const Id(1),
      resourceTermId: const Id(2),
      title: const t.Title('Test Title'),
    ));

    MockQuestionService mockQuestionService = MockQuestionService();
    Get.delete<QuestionService>();
    Get.put<QuestionService>(mockQuestionService);

    when(() => mockQuestionService.getQuestionsFromQuery(any()))
        .thenAnswer((_) => Future.value([questionData]));

    await tester.pumpWidget(
      const MyApp(
        defaultRoute: QuestionsScreen.route,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(QuestionTitleListTile), findsOneWidget);
  });

  group('term name tests', () {
    testWidgets('term name is not show for terms type source',
        (WidgetTester tester) async {
      final questionData = createTestQuestionData();
      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource.term,
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      await tester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.widgetWithText(QuestionHeader, questionData.parentTermName),
          findsNothing);
    });

    for (QuestionScreenSource questionScreenSource
        in QuestionScreenSource.values) {
      if (questionScreenSource == QuestionScreenSource.term) continue;
      testWidgets('term name is  show for source ${questionScreenSource.name}',
          (WidgetTester tester) async {
        final questionData = createTestQuestionData();
        Get.put(QuestionsScreenArgument(
          query: 'query',
          source: questionScreenSource,
          sourceId: const Id(1),
          resourceTermId: const Id(2),
          title: const t.Title('Test Title'),
        ));

        MockQuestionService mockQuestionService = MockQuestionService();
        Get.delete<QuestionService>();
        Get.put<QuestionService>(mockQuestionService);

        when(() => mockQuestionService.getQuestionsFromQuery(any()))
            .thenAnswer((_) => Future.value([questionData]));

        await tester.pumpWidget(
          const MyApp(
            defaultRoute: QuestionsScreen.route,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.widgetWithText(QuestionHeader, questionData.parentTermName),
            findsOneWidget);
      });

      testWidgets(
          'term name is  show once for continious questions with the same parent term',
          (WidgetTester tester) async {
        QuestionData questionData = createTestQuestionData();
        QuestionData questionData2 = createTestQuestionData(id: 2);

        Get.put(QuestionsScreenArgument(
          query: 'query',
          source: questionScreenSource,
          sourceId: const Id(1),
          resourceTermId: const Id(2),
          title: const t.Title('Test Title'),
        ));

        MockQuestionService mockQuestionService = MockQuestionService();
        Get.delete<QuestionService>();
        Get.put<QuestionService>(mockQuestionService);

        when(() => mockQuestionService.getQuestionsFromQuery(any()))
            .thenAnswer((_) => Future.value([questionData, questionData2]));

        await tester.pumpWidget(
          const MyApp(
            defaultRoute: QuestionsScreen.route,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.widgetWithText(QuestionHeader, questionData.parentTermName),
            findsOneWidget);
      });

      testWidgets(
          'term name is  show once for each question data if not the same as the previous',
          (WidgetTester tester) async {
        QuestionData questionData = createTestQuestionData();
        QuestionData questionData2 = createTestQuestionData(
            id: 2, parentTermName: 'parent term 2', parentTermId: 2);

        Get.put(QuestionsScreenArgument(
          query: 'query',
          source: questionScreenSource,
          sourceId: const Id(1),
          resourceTermId: const Id(2),
          title: const t.Title('Test Title'),
        ));

        MockQuestionService mockQuestionService = MockQuestionService();
        Get.delete<QuestionService>();
        Get.put<QuestionService>(mockQuestionService);

        when(() => mockQuestionService.getQuestionsFromQuery(any()))
            .thenAnswer((_) => Future.value([questionData, questionData2]));

        await tester.pumpWidget(
          const MyApp(
            defaultRoute: QuestionsScreen.route,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.widgetWithText(QuestionHeader, questionData.parentTermName),
            findsOneWidget);
        expect(
            find.widgetWithText(QuestionHeader, questionData2.parentTermName),
            findsOneWidget);
      });

      testWidgets('term name tapping shows confirmation dialogue',
          (WidgetTester tester) async {
        QuestionData questionData = createTestQuestionData();

        Get.put(QuestionsScreenArgument(
          query: 'query',
          source: questionScreenSource,
          sourceId: const Id(1),
          resourceTermId: const Id(2),
          title: const t.Title('Test Title'),
        ));

        MockQuestionService mockQuestionService = MockQuestionService();
        Get.delete<QuestionService>();
        Get.put<QuestionService>(mockQuestionService);

        when(() => mockQuestionService.getQuestionsFromQuery(any()))
            .thenAnswer((_) => Future.value([questionData]));

        await tester.pumpWidget(
          const MyApp(
            defaultRoute: QuestionsScreen.route,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text(questionData.parentTermName));
        await tester.pumpAndSettle();

        expect(
            find.widgetWithText(
                ConfirmDialogue, StringConstant.aboutToMoveToTerm),
            findsOneWidget);
      });

      testWidgets(
          'term name tapping shows confirmation dialogue, then confirming shows term questions screen',
          (WidgetTester tester) async {
        QuestionData questionData = createTestQuestionData();

        Get.put(QuestionsScreenArgument(
          query: 'query',
          source: questionScreenSource,
          sourceId: const Id(1),
          resourceTermId: const Id(2),
          title: const t.Title('Test Title'),
        ));

        MockQuestionService mockQuestionService = MockQuestionService();
        Get.delete<QuestionService>();
        Get.put<QuestionService>(mockQuestionService);

        when(() => mockQuestionService.getQuestionsFromQuery(any()))
            .thenAnswer((_) => Future.value([questionData]));

        await tester.pumpWidget(
          const MyApp(
            defaultRoute: QuestionsScreen.route,
          ),
        );
        await tester.pumpAndSettle();

        // tap the term name
        await tester.tap(find.text(questionData.parentTermName));
        await tester.pumpAndSettle();

        // tap ok
        await tester.tap(find.text(StringConstant.ok));
        await tester.pumpAndSettle();

        expect(find.byType(QuestionsScreen), findsOneWidget);
        expect(find.widgetWithText(AppBar, questionData.parentTermName),
            findsOneWidget);
      });
    }
  });

  group('question label tests', () {
    testWidgets('choose right answer label is shown',
        (WidgetTester tester) async {
      final questionData = createTestQuestionData(labelId: 1);
      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource
            .values[Random().nextInt(QuestionScreenSource.values.length)],
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      await tester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.widgetWithText(QuestionHeader, StringConstant.chooseRightAnswer),
          findsOneWidget);
    });

    testWidgets('choose correct answer label is shown',
        (WidgetTester tester) async {
      final questionData = createTestQuestionData(labelId: 2);
      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource
            .values[Random().nextInt(QuestionScreenSource.values.length)],
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      await tester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.widgetWithText(
              QuestionHeader, StringConstant.chooseCorrectAnswer),
          findsOneWidget);
    });

    testWidgets('choose wrong answer label is shown',
        (WidgetTester tester) async {
      final questionData = createTestQuestionData(labelId: 3);
      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource
            .values[Random().nextInt(QuestionScreenSource.values.length)],
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      await tester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.widgetWithText(QuestionHeader, StringConstant.chooseWrongAnswer),
          findsOneWidget);
    });

    testWidgets('choose different answer label is shown',
        (WidgetTester tester) async {
      final questionData = createTestQuestionData(labelId: 4);
      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource
            .values[Random().nextInt(QuestionScreenSource.values.length)],
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      await tester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.widgetWithText(
              QuestionHeader, StringConstant.chooseDifferentAnswer),
          findsOneWidget);
    });

    testWidgets('choose key answer label is shown',
        (WidgetTester tester) async {
      final questionData = createTestQuestionData(labelId: 5);
      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource
            .values[Random().nextInt(QuestionScreenSource.values.length)],
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData]));

      await tester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.widgetWithText(QuestionHeader, StringConstant.chooseKeyAnswer),
          findsOneWidget);
    });

    testWidgets(
        'label is  show once for continious questions with the same label',
        (WidgetTester tester) async {
      QuestionData questionData = createTestQuestionData();
      QuestionData questionData2 = createTestQuestionData(id: 2);

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource
            .values[Random().nextInt(QuestionScreenSource.values.length)],
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData, questionData2]));

      await tester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.widgetWithText(QuestionHeader, StringConstant.chooseRightAnswer),
          findsOneWidget);
    });

    testWidgets(
        'label show once for each question data if not the same as the previous',
        (WidgetTester tester) async {
      QuestionData questionData = createTestQuestionData(labelId: 1);
      QuestionData questionData2 = createTestQuestionData(id: 2, labelId: 2);

      Get.put(QuestionsScreenArgument(
        query: 'query',
        source: QuestionScreenSource
            .values[Random().nextInt(QuestionScreenSource.values.length)],
        sourceId: const Id(1),
        resourceTermId: const Id(2),
        title: const t.Title('Test Title'),
      ));

      MockQuestionService mockQuestionService = MockQuestionService();
      Get.delete<QuestionService>();
      Get.put<QuestionService>(mockQuestionService);

      when(() => mockQuestionService.getQuestionsFromQuery(any()))
          .thenAnswer((_) => Future.value([questionData, questionData2]));

      await tester.pumpWidget(
        const MyApp(
          defaultRoute: QuestionsScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.widgetWithText(QuestionHeader, StringConstant.chooseRightAnswer),
          findsOneWidget);
      expect(
          find.widgetWithText(
              QuestionHeader, StringConstant.chooseCorrectAnswer),
          findsOneWidget);
    });
  });

  testWidgets('question image is visible of already invoked',
      (WidgetTester tester) async {
    QuestionData questionData = createTestQuestionData(imageVisible: true);

    Get.put(QuestionsScreenArgument(
      query: 'query',
      source: QuestionScreenSource
          .values[Random().nextInt(QuestionScreenSource.values.length)],
      sourceId: const Id(1),
      resourceTermId: const Id(2),
      title: const t.Title('Test Title'),
    ));

    MockQuestionService mockQuestionService = MockQuestionService();
    Get.delete<QuestionService>();
    Get.put<QuestionService>(mockQuestionService);

    when(() => mockQuestionService.getQuestionsFromQuery(any()))
        .thenAnswer((_) => Future.value([questionData]));

    await tester.pumpWidget(
      const MyApp(
        defaultRoute: QuestionsScreen.route,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('question image is hidden of not invoked',
      (WidgetTester tester) async {
    QuestionData questionData = createTestQuestionData(imageVisible: false);

    Get.put(QuestionsScreenArgument(
      query: 'query',
      source: QuestionScreenSource
          .values[Random().nextInt(QuestionScreenSource.values.length)],
      sourceId: const Id(1),
      resourceTermId: const Id(2),
      title: const t.Title('Test Title'),
    ));

    MockQuestionService mockQuestionService = MockQuestionService();
    Get.delete<QuestionService>();
    Get.put<QuestionService>(mockQuestionService);

    when(() => mockQuestionService.getQuestionsFromQuery(any()))
        .thenAnswer((_) => Future.value([questionData]));

    await tester.pumpWidget(
      const MyApp(
        defaultRoute: QuestionsScreen.route,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CachedNetworkImage), findsNothing);
  });
}
