import 'package:beta/constants/string_constant.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/scan_qr/control_buttons_widget.dart';
import 'package:beta/presentation/scan_qr/qr_scanner_widget.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  group('rendering widgets tests', () {
    testWidgets('QrScannerWidget is rendered if not ready',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(QrScannerWidget), findsOneWidget);
    });

    testWidgets('QrScannerWidget is rendered if ready', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      expect(find.byType(QrScannerWidget), findsOneWidget);
    });

    testWidgets('control buttons are rendered once ready',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      expect(find.byType(ControlButtons), findsOneWidget);
    });

    testWidgets('control buttons not rendered if not ready',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ControlButtons), findsNothing);
    });

    testWidgets('place in rectangle is rendered once ready',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.placeQrInRectangle), findsOneWidget);
    });

    testWidgets('place in rectangle is not rendered if not ready',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.placeQrInRectangle), findsNothing);
    });

    testWidgets('allow camera permission is rendered if not ready',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(AllowCameraPermissionInAppSettings), findsOneWidget);
    });

    testWidgets('allow camera permission is not rendered if ready',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.byType(AllowCameraPermissionInAppSettings), findsOneWidget);
    });
  });

  group('allow camera permissions tests', () {
    testWidgets('enable camera permission text is rendered',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.enableCameraPermission), findsOneWidget);
    });

    testWidgets('go to app settings text is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      await widgetTester.pumpAndSettle();
      expect(find.text(StringConstant.goToAppSettings), findsOneWidget);
    });

    testWidgets('go to app settings tap opens app settings screen',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      ScanQrScreenController scanQrScreenController = Get.find();
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text(StringConstant.goToAppSettings));
      await widgetTester.pumpAndSettle();
      expect(scanQrScreenController.appSettingsOpened, true);
    });
  });
}
