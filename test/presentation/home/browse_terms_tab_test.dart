import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_linked_to_tag_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/browse_terms_tab_controller.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/path_widget.dart';
import 'package:beta/presentation/home/question_tag_path_widget.dart';
import 'package:beta/presentation/home/question_tag_widget.dart';
import 'package:beta/presentation/home/term_tag_widget.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() async {

  setUp(() async {
    await initTests();
    databaseService = Get.find();
  });

  tearDown(() async {
    await databaseService.deleteAllTables();
  });

  group('popping tests', () {
    testWidgets('can not go back in first layer', (widgetTester) async {
      await databaseService.seedTermsData();
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text('parent'), findsOneWidget);
      BrowseTermsTabController browseTermsTabController = Get.find();
      expect(browseTermsTabController.canTabPop(), true);
    });

    testWidgets('can go back in other layer than first layer',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(find.text('child'), findsOneWidget);
      BrowseTermsTabController browseTermsTabController = Get.find();
      expect(browseTermsTabController.canTabPop(), false);

      browseTermsTabController.onTabPopInvoked(false, null);
      await widgetTester.pumpAndSettle();

      expect(browseTermsTabController.canTabPop(), true);
      expect(find.text('parent'), findsOneWidget);
      expect(find.text('child'), findsNothing);
    });

    testWidgets('can go back between question tags', (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      BrowseTermsTabController browseTermsTabController = Get.find();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      // tap the questions tags in order to move to the
      await widgetTester.tap(find.text(StringConstant.questionTags));
      await widgetTester.pumpAndSettle();

      //tap the parent tag
      await widgetTester.tap(find.text('parent tag'));
      await widgetTester.pumpAndSettle();

      // return back
      expect(browseTermsTabController.canTabPop(), false);
      browseTermsTabController.onTabPopInvoked(false, null);
      await widgetTester.pumpAndSettle();

      expect(find.text('parent tag'), findsOneWidget);
    });

    testWidgets('can go back from questions tags to terms tags',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      BrowseTermsTabController browseTermsTabController = Get.find();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      // tap the questions tags in order to move to the
      await widgetTester.tap(find.text(StringConstant.questionTags));
      await widgetTester.pumpAndSettle();

      //tap the parent tag
      await widgetTester.tap(find.text('parent tag'));
      await widgetTester.pumpAndSettle();

      // return back
      expect(browseTermsTabController.canTabPop(), false);
      browseTermsTabController.onTabPopInvoked(false, null);
      await widgetTester.pumpAndSettle();

      // return back again
      expect(browseTermsTabController.canTabPop(), false);
      browseTermsTabController.onTabPopInvoked(false, null);
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.questionTags), findsOneWidget);
    });

    testWidgets('can go back from term to terms tags', (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      BrowseTermsTabController browseTermsTabController = Get.find();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      // tap the term tag
      expect(find.widgetWithText(TermTagWidget, 'tag name'), findsOneWidget);
      await widgetTester.tap(find.text('tag name'));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TermWidget, 'child'), findsOneWidget);
      expect(browseTermsTabController.canTabPop(), false);
      // return back
      browseTermsTabController.onTabPopInvoked(false, null);
      await widgetTester.pumpAndSettle();

      // check that returned back successfully
      expect(find.widgetWithText(TermTagWidget, 'tag name'), findsOneWidget);
    });

    testWidgets('can go back from term tag to term', (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();

      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: HomeScreen.route,
      ));
      await widgetTester.pumpAndSettle();

      BrowseTermsTabController browseTermsTabController = Get.find();

      // tap the parent term
      await widgetTester.tap(find.text('parent'));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(TermTagWidget, 'tag name'), findsOneWidget);

      // return back
      expect(browseTermsTabController.canTabPop(), false);
      browseTermsTabController.onTabPopInvoked(false, null);
      await widgetTester.pumpAndSettle();

      // check that returned back successfully
      expect(find.widgetWithText(TermWidget, 'parent'), findsOneWidget);
    });
  });

  group('questions tags tests', () {
    testWidgets(
        'questions tags path widget is rendered when navigating between question tags',
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

      expect(find.byType(QuestionTagPathWidget), findsOneWidget);
    });

    testWidgets(
        'questions tags shows only questions tags for layer 0 questions tags',
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

      expect(find.byType(QuestionTagWidget), findsNWidgets(2));
      expect(find.widgetWithText(QuestionTagWidget, StringConstant.showAll),
          findsNothing);
      expect(find.widgetWithText(QuestionTagWidget, StringConstant.others),
          findsNothing);
    });

    testWidgets(
        'questions tags shows questions tags and show all option for non-zero question tags layer',
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

      expect(find.byType(QuestionTagWidget), findsNWidgets(3));
      expect(find.widgetWithText(QuestionTagWidget, StringConstant.showAll),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTagWidget, StringConstant.others),
          findsNothing);
    });

    testWidgets(
        'questions tags shows questions tags and show all and show others option for non-zero question tags layer',
        (widgetTester) async {
      await databaseService.seedTermsData();
      await databaseService.seedQuestionsTagsData();
      QuestionService questionService = Get.find();
      QuestionLinkedToTagService questionLinkedToTagService = Get.find();
      await questionService.addQuestions([
        const Question(
            id: 1000,
            uuid: 'kjnaksa',
            title: 'random question title',
            titleTranslation: 'random question title translation',
            labelId: 1,
            note: '',
            noteTranslation: 'noteTranslation',
            parentTermId: 2,
            specialCharacter: 1,
            type: 1,
            edited: 0,
            imageUrl: '',
            creation: '2022-01-01 11:12:13',
            editionDate: '')
      ]);
      await questionLinkedToTagService.addQuestionsLinkdeToTags(
          [const QuestionsLinkedToTag(questionId: 1000, tagId: 1)]);

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

      expect(find.byType(QuestionTagWidget), findsNWidgets(4));
      expect(find.widgetWithText(QuestionTagWidget, StringConstant.showAll),
          findsOneWidget);
      expect(find.widgetWithText(QuestionTagWidget, StringConstant.others),
          findsOneWidget);
    });
  });

  testWidgets('terms path widget is rendered when navigating between terms',
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

    expect(find.byType(PathWidget), findsOneWidget);
  });

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
  });

  testWidgets('term widget is rendered', (widgetTester) async {
    await databaseService.seedTermsData();
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: HomeScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.widgetWithText(TermWidget, 'parent'), findsOneWidget);
  });
}
