import 'package:beta/main.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future<void> main() async {
  await initTests();

  testWidgets('notifications screen is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: NotificationsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.byType(NotificationsScreen), findsOneWidget);
    expect(find.text(NotificationsScreen.title), findsOneWidget);
    expect(find.byIcon(NotificationsScreen.icon), findsOneWidget);
  });
}
