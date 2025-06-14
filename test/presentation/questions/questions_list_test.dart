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
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/questions/question_body.dart';
import 'package:beta/presentation/questions/question_footer.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions_report/questions_report_screen.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
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

  testWidgets('question header is rendered', (widgetTester) async {
    await seedQuestionsData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.byType(QuestionHeader), findsOneWidget);
  });

  testWidgets('correct questions button is not rendered for quesions term type',
      (widgetTester) async {
    await seedQuestionsData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(SubmitButton, StringConstant.correctQuestions),
        findsNothing);
  });

  testWidgets('correct questions button is rendered for template term type',
      (widgetTester) async {
    await seedTemplateData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(SubmitButton, StringConstant.correctQuestions),
        findsOneWidget);
  });

  testWidgets('correct questions button tapping opens questions report screen',
      (widgetTester) async {
    await seedTemplateData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(StringConstant.ok));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(
        find.widgetWithText(SubmitButton, StringConstant.correctQuestions));
    await widgetTester.pumpAndSettle();

    expect(find.byType(QuestionsReportScreen), findsOneWidget);
  });

  testWidgets('question header is rendered', (widgetTester) async {
    await seedQuestionsData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(QuestionHeader, 'title'), findsOneWidget);
  });

  testWidgets('question body is rendered', (widgetTester) async {
    await seedQuestionsData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(QuestionBody, 'correct answer'), findsOneWidget);
    expect(find.widgetWithText(QuestionBody, 'wrong answer'), findsOneWidget);
    expect(find.widgetWithText(QuestionBody, 'wrong answer 2'), findsOneWidget);
  });

  testWidgets('question footer is rendered', (widgetTester) async {
    await seedQuestionsData();

    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(find.byType(QuestionFooter), findsAny);
  });
}
