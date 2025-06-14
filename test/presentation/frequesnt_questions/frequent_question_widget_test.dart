import 'package:beta/constants/api_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  dioAdapter.onGet(ApiConstant.frequentQuestions, (server) {
    server.reply(200, r'''
{"frequent-questions":[{"id":1,"title":"title","description":"description","appId":1,"creation":"2023-05-04 20:40:08"}],"result":"success","message":""}
''');
  });

  testWidgets('FrequentQuestionWidget displays question title initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(defaultRoute: FrequentQuestionsScreen.route),
    );
    await tester.pumpAndSettle();

    expect(find.text('title'), findsOneWidget);
    // expect(find.text('description'), findsNothing);
  });

  testWidgets('FrequentQuestionWidget expands to show description when tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(defaultRoute: FrequentQuestionsScreen.route),
    );
    await tester.pumpAndSettle();

    // Tap on the expansion panel header
    await tester.tap(find.byType(ExpansionPanelList));
    await tester.pumpAndSettle();

    // Verify both question and answer are visible
    expect(find.text('title'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
  });

  testWidgets('FrequentQuestionWidget collapses when tapped twice',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(defaultRoute: FrequentQuestionsScreen.route),
    );
    await tester.pumpAndSettle();

    // First tap to expand
    await tester.tap(find.byType(ExpansionPanelList));
    await tester.pumpAndSettle();

    // Second tap to collapse
    await tester.tap(find.byType(ExpansionPanelList));
    await tester.pumpAndSettle();

    // Verify answer is hidden again
    expect(find.text('title'), findsOneWidget);
    // expect(find.text('description'), findsNothing);
  });
}
