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
import 'package:beta/presentation/questions/question_tags_choice.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:flutter/material.dart';
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
          title: 'tag 1',
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
          title: 'tag 2',
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
          name: 'tag 1',
          parentTagId: 0,
          hasInformation: 0,
          creation: '2024-01-01 11:13:15'),
      const QuestionTag(
          id: 2,
          name: 'tag 2',
          parentTagId: 0,
          hasInformation: 0,
          creation: '2024-01-01 11:13:15'),
      const QuestionTag(
          id: 3,
          name: 'tag 3',
          parentTagId: 0,
          hasInformation: 0,
          creation: '2024-01-01 11:13:15'),
      const QuestionTag(
          id: 4,
          name: 'tag 4',
          parentTagId: 0,
          hasInformation: 0,
          creation: '2024-01-01 11:13:15'),
    ]);
    QuestionLinkedToTagService qlinkedToTagService = Get.find();
    await qlinkedToTagService.addQuestionsLinkdeToTags([
      const QuestionsLinkedToTag(questionId: 1, tagId: 1),
      const QuestionsLinkedToTag(questionId: 2, tagId: 2),
      const QuestionsLinkedToTag(questionId: 1, tagId: 3),
      const QuestionsLinkedToTag(questionId: 2, tagId: 3)
    ]);
  }

  testWidgets('question tag choice widget text is rendered',
      (widgetTester) async {
    await seedQuestionsData();
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    expect(
        find.widgetWithText(
            QuestionTagsChoice, StringConstant.filterByQuestionTag),
        findsOneWidget);
  });

  testWidgets('question tag choice widget tapping shows relevant tags',
      (widgetTester) async {
    await seedQuestionsData();
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(QuestionTagsChoice));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(ChoiceChip, 'tag 1'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'tag 2'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'tag 3'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'tag 4'), findsNothing);
  });

  testWidgets(
      'question tag choice widget tapping shows relevant tags, then filters according to tags',
      (widgetTester) async {
    await seedQuestionsData();
    await widgetTester.pumpWidget(const MyApp(defaultRoute: HomeScreen.route));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.widgetWithText(TermWidget, 'name'));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(QuestionTagsChoice));
    await widgetTester.pumpAndSettle();

    // filter by tag 1
    await widgetTester.tap(find.widgetWithText(ChoiceChip, 'tag 1'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(QuestionTitle, 'tag 1'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'tag 2'), findsNothing);

    // filter by tag 2 in addition to tag 1
    await widgetTester.tap(find.widgetWithText(ChoiceChip, 'tag 2'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(QuestionTitle, 'tag 1'), findsNothing);
    expect(find.widgetWithText(QuestionTitle, 'tag 2'), findsNothing);

    // unfilter tag 2 and tag 1
    await widgetTester.tap(find.widgetWithText(ChoiceChip, 'tag 2'));
    await widgetTester.tap(find.widgetWithText(ChoiceChip, 'tag 1'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(QuestionTitle, 'tag 1'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'tag 2'), findsOneWidget);

    // filter by tag 3
    await widgetTester.tap(find.widgetWithText(ChoiceChip, 'tag 3'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(QuestionTitle, 'tag 1'), findsOneWidget);
    expect(find.widgetWithText(QuestionTitle, 'tag 2'), findsOneWidget);
  });
}
