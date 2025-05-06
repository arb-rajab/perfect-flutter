import 'package:beta/main.dart';
import 'package:beta/presentation/splash/shimmering_logo.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:beta/presentation/splash/splash_screen_notifier.dart';
import 'package:beta/presentation/splash/version_name.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

void main() async {
  await initTests();

  testWidgets('splash screen renders the shimmering effect',
      (widgetTester) async {
    await widgetTester
        .pumpWidget(const MyApp(defaultRoute: SplashScreen.route));
    await widgetTester.pumpAndSettle();
    expect(find.byType(ShimmeringLogo), findsOneWidget);
  });

  testWidgets('splash screen renders the version name', (widgetTester) async {
    await widgetTester
        .pumpWidget(const MyApp(defaultRoute: SplashScreen.route));
    await widgetTester.pumpAndSettle();
    expect(find.byType(VersionName), findsOneWidget);
  });

  testWidgets('splash screen dismissed after certain period',
      (widgetTester) async {
    await widgetTester
        .pumpWidget(const MyApp(defaultRoute: SplashScreen.route));
    SplashScreenController screenController = Get.find();
    await widgetTester.pump();
    expect(screenController.poped, false);
    await widgetTester.pumpAndSettle();
    expect(screenController.poped, true);
  });
}
