import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_linked_to_tag_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/term_linked_to_tag_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_linked_to_tag_data.dart';
import 'package:beta/domain/term_tag_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/question_tag_widget.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:beta/presentation/questions/question_tags_chips.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/web/web_screen.dart';
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
    await databaseService.close();
  });

  testWidgets('show all option, shows all questions related to a question tag',
      (widgetTester) async {
    await databaseService.seedTermsData();
    await databaseService.seedQuestionsTagsData();
    QuestionService questionService = Get.find();
    QuestionLinkedToTagService questionLinkedToTagService = Get.find();
    await questionService.addQuestions(List.generate(
        5,
        (index) => Question(
            id: index + 1000,
            uuid: '$index',
            title: 'question $index',
            titleTranslation: 'question $index translation',
            labelId: 1,
            note: '',
            noteTranslation: '',
            parentTermId: 2,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2023-01-01 13:13:13',
            editionDate: '')));
    await questionLinkedToTagService.addQuestionsLinkdeToTags(List.generate(5,
        (index) => QuestionsLinkedToTag(questionId: index + 1000, tagId: 1)));

    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();

    // tap the parent term
    await widgetTester.tap(find.text('parent'));
    await widgetTester.pumpAndSettle();

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    //tap the parent tag
    await widgetTester.tap(find.text('parent tag'));
    await widgetTester.pumpAndSettle();

    await widgetTester
        .tap(find.widgetWithText(QuestionTagWidget, StringConstant.showAll));
    await widgetTester.pumpAndSettle();

    expect(find.byType(QuestionsScreen), findsOneWidget);
    expect(find.byType(QuestionHeader, skipOffstage: false), findsNWidgets(6));
    expect(
        find.widgetWithText(QuestionTagsChips, 'parent tag',
            skipOffstage: false),
        findsNWidgets(6));
  });

  testWidgets(
      'show others option, shows all questions that do not belong to any child tag of a question tag',
      (widgetTester) async {
    await databaseService.seedTermsData();
    await databaseService.seedQuestionsTagsData();
    QuestionService questionService = Get.find();
    QuestionLinkedToTagService questionLinkedToTagService = Get.find();
    await questionService.addQuestions(List.generate(
        5,
        (index) => Question(
            id: index + 1000,
            uuid: '$index',
            title: 'question $index',
            titleTranslation: 'question $index translation',
            labelId: 1,
            note: '',
            noteTranslation: '',
            parentTermId: 2,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2023-01-01 13:13:13',
            editionDate: '')));
    await questionLinkedToTagService.addQuestionsLinkdeToTags(List.generate(5,
        (index) => QuestionsLinkedToTag(questionId: index + 1000, tagId: 1)));

    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();

    // tap the parent term
    await widgetTester.tap(find.text('parent'));
    await widgetTester.pumpAndSettle();

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    //tap the parent tag
    await widgetTester.tap(find.text('parent tag'));
    await widgetTester.pumpAndSettle();

    await widgetTester
        .tap(find.widgetWithText(QuestionTagWidget, StringConstant.others));
    await widgetTester.pumpAndSettle();

    expect(find.byType(QuestionsScreen), findsOneWidget);
    expect(find.byType(QuestionHeader, skipOffstage: false), findsNWidgets(5));
    expect(
        find.widgetWithText(QuestionTagsChips, 'parent tag',
            skipOffstage: false),
        findsNWidgets(5));
  });

  testWidgets(
      'taping a questions tag invokes showing its questions if it does not have a child tag',
      (widgetTester) async {
    await databaseService.seedTermsData();
    QuestionService questionService = Get.find();
    QuestionTagService questionTagService = Get.find();
    QuestionLinkedToTagService questionLinkedToTagService = Get.find();
    TermTagService termTagService = Get.find();
    TermLinkedToTagService termLinkedToTagService = Get.find();
    await questionService.addQuestions(List.generate(
        5,
        (index) => Question(
            id: index + 1000,
            uuid: '$index',
            title: 'question $index',
            titleTranslation: 'question $index translation',
            labelId: 1,
            note: '',
            noteTranslation: '',
            parentTermId: 2,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2023-01-01 13:13:13',
            editionDate: '')));
    await questionTagService.addQuestionTags([
      const QuestionTag(
          id: 1,
          name: 'tag',
          parentTagId: 0,
          hasInformation: 0,
          creation: '2022-01-01 11:11:11')
    ]);
    await questionLinkedToTagService.addQuestionsLinkdeToTags(List.generate(5,
        (index) => QuestionsLinkedToTag(questionId: index + 1000, tagId: 1)));
    await termTagService.addTermTags([
      TermTagData(const TermTag(id: 1, name: 'term tag', ordering: 1),
          deletedAt: const DeletedAt(null))
    ]);
    await termLinkedToTagService.addTermsLinkedToTags([
      TermLinkedToTagData(const TermsLinkedToTag(termId: 2, tagId: 1),
          deletedAt: const DeletedAt(null))
    ]);

    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();

    // tap the parent term
    await widgetTester.tap(find.text('parent'));
    await widgetTester.pumpAndSettle();

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    //tap the parent tag
    await widgetTester.tap(find.text('tag'));
    await widgetTester.pumpAndSettle();

    expect(find.byType(QuestionsScreen), findsOneWidget);
    expect(find.byType(QuestionHeader, skipOffstage: false), findsNWidgets(5));
    expect(find.widgetWithText(QuestionTagsChips, 'tag', skipOffstage: false),
        findsNWidgets(5));
  });

  testWidgets('question tag title is rendered', (widgetTester) async {
    await databaseService.seedTermsData();
    await databaseService.seedQuestionsTagsData();

    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();

    // tap the parent term
    await widgetTester.tap(find.text('parent'));
    await widgetTester.pumpAndSettle();

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    expect(
        find.widgetWithText(QuestionTagWidget, 'parent tag'), findsOneWidget);
  });

  testWidgets('question tag number of child tag is rendered',
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

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key('parent tag 2-child')), findsOneWidget);
  });

  testWidgets('question tag number of questions is rendered',
      (widgetTester) async {
    await databaseService.seedTermsData();
    await databaseService.seedQuestionsTagsData();
    QuestionService questionService = Get.find();
    QuestionLinkedToTagService questionLinkedToTagService = Get.find();

    await questionService.addQuestions(List.generate(
        5,
        (index) => Question(
            id: index + 1000,
            uuid: '$index',
            title: 'question $index',
            titleTranslation: 'question $index translation',
            labelId: 1,
            note: '',
            noteTranslation: '',
            parentTermId: 2,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2023-01-01 13:13:13',
            editionDate: '')));
    await questionLinkedToTagService.addQuestionsLinkdeToTags(List.generate(5,
        (index) => QuestionsLinkedToTag(questionId: index + 1000, tagId: 1)));

    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();

    // tap the parent term
    await widgetTester.tap(find.text('parent'));
    await widgetTester.pumpAndSettle();

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key('parent tag 6-question')), findsOneWidget);
  });

  testWidgets(
      'question tag number of child tag is not rendered if there are no child tags',
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

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    expect(
        find.widgetWithText(QuestionTagWidget, 'parent tag 2'), findsOneWidget);
    expect(find.byKey(const Key('parent tag 2 0-child')), findsNothing);
  });

  testWidgets('show all option, does not have information icon',
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

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    //tap the parent tag
    await widgetTester.tap(find.text('parent tag'));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.showAll), findsOneWidget);

    final targetFinder = find.byWidgetPredicate((widget) {
      // Check ONLY within this widget's subtree
      final textInWidget = find
          .descendant(
            of: find.byWidget(widget),
            matching: find.text(StringConstant.showAll),
          )
          .evaluate()
          .isNotEmpty;

      final iconInWidget = find
          .descendant(
            of: find.byWidget(widget),
            matching: find.byIcon(Icons.article),
          )
          .evaluate()
          .isNotEmpty;

      return textInWidget && iconInWidget && widget is QuestionTagWidget;
    });

    expect(targetFinder, findsNothing);
  });

  testWidgets('show others option, does not have information icon',
      (widgetTester) async {
    await databaseService.seedTermsData();
    await databaseService.seedQuestionsTagsData();
    QuestionService questionService = Get.find();
    QuestionLinkedToTagService questionLinkedToTagService = Get.find();
    await questionService.addQuestions(List.generate(
        5,
        (index) => Question(
            id: index + 1000,
            uuid: '$index',
            title: 'question $index',
            titleTranslation: 'question $index translation',
            labelId: 1,
            note: '',
            noteTranslation: '',
            parentTermId: 2,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2023-01-01 13:13:13',
            editionDate: '')));
    await questionLinkedToTagService.addQuestionsLinkdeToTags(List.generate(5,
        (index) => QuestionsLinkedToTag(questionId: index + 1000, tagId: 1)));

    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();

    // tap the parent term
    await widgetTester.tap(find.text('parent'));
    await widgetTester.pumpAndSettle();

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    //tap the parent tag
    await widgetTester.tap(find.text('parent tag'));
    await widgetTester.pumpAndSettle();

    expect(find.text(StringConstant.others), findsOneWidget);

    final targetFinder = find.byWidgetPredicate((widget) {
      // Check ONLY within this widget's subtree
      final textInWidget = find
          .descendant(
            of: find.byWidget(widget),
            matching: find.text(StringConstant.others),
          )
          .evaluate()
          .isNotEmpty;

      final iconInWidget = find
          .descendant(
            of: find.byWidget(widget),
            matching: find.byIcon(Icons.article),
          )
          .evaluate()
          .isNotEmpty;

      return textInWidget && iconInWidget && widget is QuestionTagWidget;
    });

    expect(targetFinder, findsNothing);
  });

  testWidgets(
      'question tag with no information, does not have information icon',
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

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    expect(find.text('parent tag'), findsOneWidget);
    expect(find.byIcon(Icons.article), findsAtLeast(1));

    final targetFinder = find.byWidgetPredicate((widget) {
      // Check ONLY within this widget's subtree
      final textInWidget = find
          .descendant(
            of: find.byWidget(widget),
            matching: find.text('parent tag'),
          )
          .evaluate()
          .isNotEmpty;

      final iconInWidget = find
          .descendant(
            of: find.byWidget(widget),
            matching: find.byIcon(Icons.article),
          )
          .evaluate()
          .isNotEmpty;

      return textInWidget && iconInWidget && widget is QuestionTagWidget;
    });

    expect(targetFinder, findsNothing);
  });

  testWidgets('question tag with information, has information icon',
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

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    expect(find.text('parent tag 2'), findsOneWidget);
    expect(
        find.widgetWithIcon(QuestionTagWidget, Icons.article), findsOneWidget);
    final targetFinder = find.byWidgetPredicate((widget) {
      // Check ONLY within this widget's subtree
      final textInWidget = find
          .descendant(
            of: find.byWidget(widget),
            matching: find.text('parent tag 2'),
          )
          .evaluate()
          .isNotEmpty;

      final iconInWidget = find
          .descendant(
            of: find.byWidget(widget),
            matching: find.byIcon(Icons.article),
          )
          .evaluate()
          .isNotEmpty;

      return textInWidget && iconInWidget && widget is QuestionTagWidget;
    });

    expect(targetFinder, findsOneWidget);
  });

  testWidgets('tapping question tag with information, opens web page',
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

    // tap the questions tags in order to move to the
    await widgetTester.tap(find.text(StringConstant.questionTags));
    await widgetTester.pumpAndSettle();

    //tap the article icon
    await widgetTester.tap(find.byKey(const Key('information')).first);
    await widgetTester.pumpAndSettle();

    expect(find.byType(WebScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'parent tag 2'), findsOneWidget);
  });
}
