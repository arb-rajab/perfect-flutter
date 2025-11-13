import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
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

    await tester.tap(find.byType(ExpansionPanelList));
    await tester.pumpAndSettle();

    expect(find.text('title'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
  });

  testWidgets('FrequentQuestionWidget collapses when tapped twice',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(defaultRoute: FrequentQuestionsScreen.route),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ExpansionPanelList));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ExpansionPanelList));
    await tester.pumpAndSettle();

    expect(find.text('title'), findsOneWidget);
    // expect(find.text('description'), findsNothing);
  });

  testWidgets('FrequentQuestionWidget shows loading when loading data',
      (WidgetTester tester) async {
    dioAdapter.onGet(ApiConstant.frequentQuestions, (server) {
      server.reply(200, r'''
{"frequent-questions":[{"id":1,"title":"title","description":"description","appId":1,"creation":"2023-05-04 20:40:08"}],"result":"success","message":""}
''');
    });
    await tester.pumpWidget(
      const MyApp(defaultRoute: FrequentQuestionsScreen.route),
    );
    await tester.pump();
    expect(find.byType(LoadingWidget), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(LoadingWidget), findsNothing);
  });

  testWidgets('FrequentQuestionWidget displays nothing if data is empty',
      (WidgetTester tester) async {
    dioAdapter.onGet(ApiConstant.frequentQuestions, (server) {
      server.reply(200, r'''
{"frequent-questions":[],"result":"success","message":""}
''');
    });
    await tester.pumpWidget(
      const MyApp(defaultRoute: FrequentQuestionsScreen.route),
    );
    await tester.pumpAndSettle();

    expect(find.text(StringConstant.listEmpty), findsOneWidget);
    expect(find.byType(ExpansionPanelList), findsNothing);
  });

  testWidgets(
      'FrequentQuestionWidget displays no connection when there is no connection',
      (WidgetTester tester) async {
    mockNoConnection(route: ApiConstant.frequentQuestions);
    await tester.pumpWidget(
      const MyApp(defaultRoute: FrequentQuestionsScreen.route),
    );
    await tester.pumpAndSettle();

    expect(find.text(StringConstant.noConnection), findsOneWidget);
    expect(find.byType(ExpansionPanelList), findsNothing);
  });

  testWidgets(
      'FrequentQuestionWidget displays a message when a message is received',
      (WidgetTester tester) async {
    mockMessageRecieved(route: ApiConstant.frequentQuestions);
    await tester.pumpWidget(
      const MyApp(defaultRoute: FrequentQuestionsScreen.route),
    );
    await tester.pumpAndSettle();

    expect(find.text('a message recieved'), findsOneWidget);
    expect(find.byType(ExpansionPanelList), findsNothing);
  });
}
