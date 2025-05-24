import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/question_tag_path_widget.dart';
import 'package:beta/presentation/home/question_tag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  DatabaseService databaseService = Get.find();

  tearDown(() async {
    await databaseService.deleteAllTables();
  });

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

    //tap the child tag
    await widgetTester.tap(find.text('child tag'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(QuestionTagPathWidget, 'parent tag'),
        findsOneWidget);
    expect(find.widgetWithText(QuestionTagPathWidget, 'child tag'),
        findsOneWidget);
    expect(find.widgetWithText(QuestionTagWidget, 'parent tag'), findsNothing);
    expect(find.widgetWithText(QuestionTagWidget, 'child tag'), findsNothing);

    expect(find.byIcon(Icons.navigate_next), findsNWidgets(2));
  });

  testWidgets('questions tags path widget is navigating to path item',
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

    //tap the child tag
    await widgetTester.tap(find.text('child tag'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(QuestionTagPathWidget, 'parent tag'),
        findsOneWidget);
    expect(find.widgetWithText(QuestionTagPathWidget, 'child tag'),
        findsOneWidget);
    expect(find.widgetWithText(QuestionTagWidget,'grand child tag'), findsOneWidget);

    //tap the parent tag listing item
    await widgetTester.tap(find.text('parent tag'));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(QuestionTagPathWidget, 'parent tag'),
        findsOneWidget);
        expect(find.widgetWithText(QuestionTagPathWidget, 'child tag'),
        findsNothing);
    expect(find.widgetWithText(QuestionTagWidget, 'child tag'),
        findsOneWidget);
    expect(find.widgetWithText(QuestionTagWidget, 'grand child tag'), findsNothing);
  });
}
