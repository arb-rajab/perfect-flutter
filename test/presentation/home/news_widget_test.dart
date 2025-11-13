import 'package:beta/configs/app.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/news_tab.dart';
import 'package:beta/presentation/home/news_widget.dart';
import 'package:beta/presentation/news/news_screen.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('news widget displays news title and creation time initially',
      (WidgetTester tester) async {
    dioAdapter.onGet(ApiConstant.news, (server) {
      server.reply(200, r'''
{"news":[{"id":1,"title":"title","content":"<p>content</p>","appId":1,"created_at":"2023-05-04 20:40:08"}],"result":"success","message":""}
''');
    });
    await tester.pumpWidget(
      const MyApp(
        child: NewsTab(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(NewsWidget), findsAny);
    expect(find.text('title'), findsOneWidget);
    expect(
        find.text(
            DateFormat.yMMMMd().format(DateTime.parse('2023-05-04 20:40:08'))),
        findsOneWidget);
  });

  testWidgets('switching to news tab, removes the new badge',
      (WidgetTester tester) async {
    hasNews = true;
    KeyValue keyValue = Get.find();
    await keyValue.setBool(KeyValueConstant.newsRecieved, true);
    dioAdapter.onGet(ApiConstant.news, (server) {
      server.reply(200, r'''
{"news":[{"id":1,"title":"title","content":"<p>content</p>","appId":1,"created_at":"2023-05-04 20:40:08"}],"result":"success","message":""}
''');
    });
    await tester.pumpWidget(
      const MyApp(
        defaultRoute: HomeScreen.route,
      ),
    );
    await tester.pumpAndSettle();

    //navigate to the news page
    await tester.tap(find.text(StringConstant.news));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(Badge, CupertinoIcons.news), findsNothing);
  });

  testWidgets('tapping news widget navigates to the news screen',
      (WidgetTester tester) async {
    dioAdapter.onGet(ApiConstant.news, (server) {
      server.reply(200, r'''
{"news":[{"id":1,"title":"title","content":"<p>content</p>","appId":1,"created_at":"2023-05-04 20:40:08"}],"result":"success","message":""}
''');
    });
    hasNews = true;
    await tester.pumpWidget(
      const MyApp(
        defaultRoute: HomeScreen.route,
      ),
    );
    await tester.pumpAndSettle();

    //navigate to the news page
    await tester.tap(find.text(StringConstant.news));
    await tester.pumpAndSettle();

    // tap the news widget
    await tester.tap(find.byType(NewsWidget));
    await tester.pumpAndSettle();

    expect(find.byType(NewsScreen), findsOneWidget);
  });

  testWidgets('news widget shows loading when loading data',
      (WidgetTester tester) async {
    dioAdapter.onGet(ApiConstant.news, (server) {
      server.reply(200, r'''
{"news":[{"id":1,"title":"title","content":"<p>content</p>","appId":1,"created_at":"2023-05-04 20:40:08"}],"result":"success","message":""}
''');
    });
    await tester.pumpWidget(
      const MyApp(
        child: NewsTab(),
      ),
    );
    await tester.pump();
    expect(find.byType(LoadingWidget), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(LoadingWidget), findsNothing);
  });

  testWidgets('news widget displays nothing if data is empty',
      (WidgetTester tester) async {
    dioAdapter.onGet(ApiConstant.news, (server) {
      server.reply(200, r'''
{"news":[],"result":"success","message":""}
''');
    });
    await tester.pumpWidget(
      const MyApp(
        child: NewsTab(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(NewsWidget), findsNothing);
    expect(find.text(StringConstant.listEmpty), findsOneWidget);
  });

  testWidgets('news widget displays no connection when there is no connection',
      (WidgetTester tester) async {
    mockNoConnection(route: ApiConstant.news);
    await tester.pumpWidget(
      const MyApp(
        child: NewsTab(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(NewsWidget), findsNothing);
    expect(find.text(StringConstant.noConnection), findsOneWidget);
  });

  testWidgets('news widget displays a message when a message is recieved',
      (WidgetTester tester) async {
    mockMessageRecieved(route: ApiConstant.news);
    await tester.pumpWidget(
      const MyApp(
        child: NewsTab(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(NewsWidget), findsNothing);
    expect(find.text('a message recieved'), findsOneWidget);
  });
}
