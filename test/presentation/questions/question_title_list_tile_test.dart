import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/share_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/dialogues/report_question_dialogue.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:beta/presentation/questions/question_title_list_tile.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/widgets/widget_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/tests.dart';

class MockQuestionsController extends Mock implements QuestionsController {}

class MockQuestionData extends Mock implements QuestionData {}

class MockQuestion extends Mock implements Question {}

void main() {
  late MockQuestionsController mockController;

  QuestionData createQuestionData({String imageUrl = ''}) {
    return QuestionData(
        Question(
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
            imageUrl: imageUrl,
            creation: '2024-01-01 11:12:13',
            editionDate: ''),
        parentTermName: 'parent term name',
        numberOfMedias: 0,
        hasNote: false,
        indexInTerm: 0);
  }

  setUp(() async {
    await initTests();
    mockController = MockQuestionsController();
  });

  testWidgets('renders correctly with basic data', (tester) async {
    await tester.pumpWidget(MyApp(
      child: QuestionTitleListTile(
        questionData: createQuestionData(),
        questionsController: mockController,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(WidgetWrapper), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.byType(QuestionTitle), findsOneWidget);
  });

  testWidgets('shows image button when question has image', (tester) async {
    await tester.pumpWidget(MyApp(
      child: QuestionTitleListTile(
        questionData: createQuestionData(imageUrl: 'image url'),
        questionsController: mockController,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.image), findsOneWidget);
  });

  testWidgets('does not show image button when question has no image',
      (tester) async {
    await tester.pumpWidget(MyApp(
      child: QuestionTitleListTile(
        questionData: createQuestionData(imageUrl: ''),
        questionsController: mockController,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.image), findsNothing);
  });

  testWidgets('shows popup menu with correct options', (tester) async {
    await tester.pumpWidget(MyApp(
      child: QuestionTitleListTile(
        questionData: createQuestionData(),
        questionsController: mockController,
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pump();

    expect(find.text(StringConstant.reportQuestion), findsOneWidget);
    expect(find.text(StringConstant.shareQuestion), findsOneWidget);
  });

  testWidgets('triggers share when share option is selected', (tester) async {
    setDesktopDevice(tester);
    await tester.pumpWidget(MyApp(
      child: QuestionTitleListTile(
        questionData: createQuestionData(),
        questionsController: mockController,
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    // Tap share option
    await tester.tap(find.text(StringConstant.shareQuestion));
    await tester.pumpAndSettle();

    // Verify share was called with correct URL
    expect(Get.find<ShareService>().shared, isTrue);
  });

  testWidgets('opens report dialog when report option is selected',
      (tester) async {
    await tester.pumpWidget(MyApp(
      child: QuestionTitleListTile(
        questionData: createQuestionData(),
        questionsController: mockController,
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    // Tap report option
    await tester.tap(find.text(StringConstant.reportQuestion));
    await tester.pumpAndSettle();

    // Verify dialog would be shown
    expect(find.byType(ReportQuestionDialogue), findsOneWidget);
  });

  testWidgets('toggles image visibility when image button is pressed',
      (tester) async {
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
          imageUrl: 'image url',
          creation: '2024-01-01 11:12:13',
          editionDate: '')
    ]);

    await tester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TermWidget, 'name'));
    await tester.pumpAndSettle();

    expect(find.byType(CachedNetworkImage), findsNothing);

    await tester.tap(find.byIcon(Icons.image));
    await tester.pumpAndSettle();

    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
