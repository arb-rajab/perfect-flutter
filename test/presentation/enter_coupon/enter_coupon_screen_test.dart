import 'package:beta/main.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/enter_coupon/submit_form.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future<void> main() async {
  await initTests();
  final testSizes = {
    'small': const Size(300, 600), // Small mobile
    'medium': const Size(600, 800), // Tablet portrait
    'large': const Size(800, 600), // Tablet landscape
    'desktop': const Size(1200, 800), // Desktop
  };

  group('scan qr fab tests', () {
    testWidgets('scan qr fab is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(ScanQrScreen.title), findsOneWidget);
    });

    testWidgets('scan qr fab navigates to scan qr screen',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.tap(find.text(ScanQrScreen.title));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ScanQrScreen), findsOneWidget);
    });
  });

  group('submit form tests', () {
    testWidgets('submit form is visible for small devices',
        (widgetTester) async {
      widgetTester.view.physicalSize = testSizes['small']!;
      widgetTester.view.devicePixelRatio = 1;
      addTearDown(widgetTester.view.resetPhysicalSize);
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SubmitForm), findsOneWidget);
    });

    testWidgets('submit form is visible for desktop devices',
        (widgetTester) async {
      widgetTester.view.physicalSize = testSizes['desktop']!;
      widgetTester.view.devicePixelRatio = 1;
      addTearDown(widgetTester.view.resetPhysicalSize);
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SubmitForm), findsOneWidget);
    });
  });

  group('logo tests', () {
    testWidgets('logo is visible for small devices', (widgetTester) async {
      widgetTester.view.physicalSize = testSizes['small']!;
      widgetTester.view.devicePixelRatio = 1;
      addTearDown(widgetTester.view.resetPhysicalSize);
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(NoBackgroundLogo), findsOneWidget);
    });

    testWidgets('logo is visible for desktop devices', (widgetTester) async {
      widgetTester.view.physicalSize = testSizes['desktop']!;
      widgetTester.view.devicePixelRatio = 1;
      addTearDown(widgetTester.view.resetPhysicalSize);
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: EnterCouponScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(NoBackgroundLogo), findsOneWidget);
    });
  });
}
