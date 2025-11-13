import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/news/news_screen.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets(
      'news widget displays news title,content and creation time initially',
      (WidgetTester tester) async {
    dioAdapter.onGet(ApiConstant.newss.replaceFirst('(NEWS_ID)', '1'),
        (server) {
      server.reply(200, r'''
{"news":{"id":1,"title":"title","content":"<p>content</p>","appId":1,"created_at":"2023-05-04 20:40:08"},"result":"success","message":""}
''');
    });
    await tester.pumpWidget(
      MyApp(
        defaultRoute: NewsScreen.route.replaceFirst(':newsId', '1'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('title'), findsOneWidget);
    expect(find.text('content'), findsOneWidget);
    expect(
        find.text(
            DateFormat.yMMMMd().format(DateTime.parse('2023-05-04 20:40:08'))),
        findsOneWidget);
  });
  testWidgets('news widget shows loading when loading data',
      (WidgetTester tester) async {
    dioAdapter.onGet(ApiConstant.newss.replaceFirst('(NEWS_ID)', '1'),
        (server) {
      server.reply(200, r'''
{"news":{"id":1,"title":"title","content":"<p>content</p>","appId":1,"created_at":"2023-05-04 20:40:08"},"result":"success","message":""}
''');
    });
    await tester.pumpWidget(
      MyApp(
        defaultRoute: NewsScreen.route.replaceFirst(':newsId', '1'),
      ),
    );
    await tester.pump();
    expect(find.byType(LoadingWidget), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(LoadingWidget), findsNothing);
  });

  testWidgets('news widget displays no connection when there is no connection',
      (WidgetTester tester) async {
    mockNoConnection(route: ApiConstant.newss.replaceFirst('(NEWS_ID)', '1'));
    await tester.pumpWidget(
      MyApp(
        defaultRoute: NewsScreen.route.replaceFirst(':newsId', '1'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(StringConstant.noConnection), findsOneWidget);
  });

  testWidgets('news widget displays a message when a message is recieved',
      (WidgetTester tester) async {
    mockMessageRecieved(
        route: ApiConstant.newss.replaceFirst('(NEWS_ID)', '1'));
    await tester.pumpWidget(
      MyApp(
        defaultRoute: NewsScreen.route.replaceFirst(':newsId', '1'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('a message recieved'), findsOneWidget);
  });
}
