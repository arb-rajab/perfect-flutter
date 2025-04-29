import 'package:beta/main.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future<void> main() async {
  await initTests();
  // DatabaseService databaseService = Get.find();
  // tearDownAll(databaseService.close);
  // tearDown(() async {
  //   await databaseService.coupons.deleteAll();
  // });

  testWidgets('coupons screen is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: CouponsScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.byType(CouponsScreen), findsOneWidget);
    expect(find.text(CouponsScreen.title), findsOneWidget);
    expect(find.byIcon(CouponsScreen.icon), findsOneWidget);
  });
}
