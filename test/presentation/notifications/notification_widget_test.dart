import 'package:beta/constants/api_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  dioAdapter.onGet(ApiConstant.notifications, (server) {
    server.reply(200, r'''
{"notifications":[{"id":10001520,"title":"title","text":"text","data":null,"topic":"","userToken":"","deviceId":0,"senderId":113,"appId":1,"creation":"2024-10-16T09:58:07.000000Z","onUpdate":"2024-10-16T09:58:07.000000Z","seen":null}],"result":"success","message":""}
''');
  });

  testWidgets('creation date is rendered', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(defaultRoute: NotificationsScreen.route),
    );
    await tester.pumpAndSettle();

    expect(find.text('2024/10/16'), findsOneWidget);
  });

  testWidgets('title is rendered', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(defaultRoute: NotificationsScreen.route),
    );
    await tester.pumpAndSettle();

    expect(find.text('title'), findsOneWidget);
  });

  testWidgets('text is rendered', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(defaultRoute: NotificationsScreen.route),
    );
    await tester.pumpAndSettle();

    expect(find.text('text'), findsOneWidget);
  });
}
