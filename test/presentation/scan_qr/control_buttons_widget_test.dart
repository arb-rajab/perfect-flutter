import 'package:beta/main.dart';
import 'package:beta/presentation/scan_qr/control_buttons_widget.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  group('render tests', () {
    testWidgets('flash icon is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      expect(find.byType(FlashIcon), findsOneWidget);
    });

    testWidgets('camera icon is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      expect(find.byType(CameraIcon), findsOneWidget);
    });
  });

  group('flash icon tests', () {
    testWidgets('torsh off icon is rendered by default', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      expect(find.byIcon(FlashIcon.flashOn), findsNothing);
      expect(find.byIcon(FlashIcon.flashOff), findsOneWidget);
    });

    testWidgets('torsh on icon is visible once torch invoked',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byIcon(FlashIcon.flashOff));
      await widgetTester.pumpAndSettle();
      expect(find.byIcon(FlashIcon.flashOn), findsOneWidget);
      expect(find.byIcon(FlashIcon.flashOff), findsNothing);
    });

    testWidgets('torsh off icon is visible once torch is revoked',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byIcon(FlashIcon.flashOff));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byIcon(FlashIcon.flashOn));
      await widgetTester.pumpAndSettle();
      expect(find.byIcon(FlashIcon.flashOff), findsOneWidget);
      expect(find.byIcon(FlashIcon.flashOn), findsNothing);
    });
  });

  group('camera icon tests', () {
    testWidgets('camera icon is rear by default', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      expect(find.byIcon(CameraIcon.cameraFrontIcon), findsNothing);
      expect(find.byIcon(CameraIcon.cameraRearIcon), findsOneWidget);
    });

    testWidgets('front camera is visible once invoked', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byIcon(CameraIcon.cameraRearIcon));
      await widgetTester.pumpAndSettle();
      expect(find.byIcon(CameraIcon.cameraFrontIcon), findsOneWidget);
      expect(find.byIcon(CameraIcon.cameraRearIcon), findsNothing);
    });

    testWidgets('rear camera is visible once invoked back',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(
        defaultRoute: ScanQrScreen.route,
      ));
      ScanQrScreenController scanQrScreenController = Get.find();
      scanQrScreenController.setScannerStarted();
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byIcon(CameraIcon.cameraRearIcon));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byIcon(CameraIcon.cameraFrontIcon));
      await widgetTester.pumpAndSettle();
      expect(find.byIcon(CameraIcon.cameraFrontIcon), findsNothing);
      expect(find.byIcon(CameraIcon.cameraRearIcon), findsOneWidget);
    });
  });
}
