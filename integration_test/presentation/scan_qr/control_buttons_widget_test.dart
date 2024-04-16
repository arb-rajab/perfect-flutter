// ignore_for_file: empty_catches

import 'package:beta/constants/route_constant.dart';
import 'package:beta/presentation/scan_qr/control_buttons_widget.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:patrol/patrol.dart';

void main() {
  group('torch tests', () {
    patrolTest('torch button has flash off icon by default',
        (widgetTester) async {
      await widgetTester.pumpWidgetAndSettle(MaterialApp(
        routes: routes,
        home: const ScanQrScreen(),
      ));
      ScanQrScreenController controller = Get.find();

      await widgetTester.native.grantPermissionOnlyThisTime();
      await widgetTester.pumpAndSettle(duration: Durations.extralong4);

      expect(find.byIcon(FlashIcon.flashOff), findsOneWidget);
      expect(find.byIcon(FlashIcon.flashOn), findsNothing);

      expect(
          controller.mobileScannerController.torchState.value, TorchState.off);
    });

    patrolTest('torch button turns torch on when clicked',
        (widgetTester) async {
      await widgetTester.pumpWidgetAndSettle(MaterialApp(
        routes: routes,
        home: const ScanQrScreen(),
      ));
      ScanQrScreenController controller = Get.find();

      await widgetTester.native.grantPermissionOnlyThisTime();
      await widgetTester.pumpAndSettle(duration: Durations.long1);
      if (controller.mobileScannerController.hasTorch) {
        await widgetTester.tap(find.byIcon(FlashIcon.flashOff));
        await widgetTester.pumpAndSettle();

        expect(find.byIcon(FlashIcon.flashOn), findsOneWidget);
        expect(find.byIcon(FlashIcon.flashOff), findsNothing);

        expect(
            controller.mobileScannerController.torchState.value, TorchState.on);
      }
    });

    patrolTest('torch button turns torch off when clicked after torch is on',
        (widgetTester) async {
      await widgetTester.pumpWidgetAndSettle(MaterialApp(
        routes: routes,
        home: const ScanQrScreen(),
      ));
      ScanQrScreenController controller = Get.find();

      await widgetTester.native.grantPermissionOnlyThisTime();
      await widgetTester.pumpAndSettle(duration: Durations.long1);

      if (controller.mobileScannerController.hasTorch) {
        await widgetTester.tap(find.byIcon(FlashIcon.flashOff));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byIcon(FlashIcon.flashOn));
        await widgetTester.pumpAndSettle();

        expect(find.byIcon(FlashIcon.flashOff), findsOneWidget);
        expect(find.byIcon(FlashIcon.flashOn), findsNothing);

        ScanQrScreenController controller = Get.find();
        expect(controller.mobileScannerController.torchState.value,
            TorchState.off);
      }
    });
  });

  group('camera tests', () {
    patrolTest('camera button has rear icon by default', (widgetTester) async {
      await widgetTester.pumpWidgetAndSettle(MaterialApp(
        routes: routes,
        home: const ScanQrScreen(),
      ));
      ScanQrScreenController controller = Get.find();

      await widgetTester.native.grantPermissionOnlyThisTime();
      await widgetTester.pumpAndSettle(duration: Durations.long1);

      expect(find.byIcon(CameraIcon.cameraRearIcon), findsOneWidget);
      expect(find.byIcon(CameraIcon.cameraFrontIcon), findsNothing);

      expect(controller.mobileScannerController.cameraFacingState.value,
          CameraFacing.back);
    });

    // patrolTest('camera button is front when clicked', (widgetTester) async {
    //   await widgetTester.pumpWidgetAndSettle(MaterialApp(
    //     routes: routes,
    //     home: const PrintedQrScannerScreen(),
    //   ));
    //   PrintedQrScannerController controller = Get.find();

    //   await widgetTester.native.grantPermissionOnlyThisTime();
    //   await widgetTester.pumpAndSettle(duration: Durations.long1);
    //   try {
    //     // if (controller.mobileScannerController.) {
    //     await widgetTester.tap(find.byIcon(CameraIcon.cameraRearIcon));
    //     await widgetTester.pumpAndSettle();

    //     expect(find.byIcon(CameraIcon.cameraFrontIcon), findsOneWidget);
    //     expect(find.byIcon(CameraIcon.cameraRearIcon), findsNothing);

    //     expect(controller.mobileScannerController.cameraFacingState.value,
    //         CameraFacing.front);
    //     // }
    //   } catch (mobileScannerException) {}
    // });

    // patrolTest('camera button turns to back when clicked after it was front',
    //     (widgetTester) async {
    //   await widgetTester.pumpWidgetAndSettle(MaterialApp(
    //     routes: routes,
    //     home: const PrintedQrScannerScreen(),
    //   ));
    //   PrintedQrScannerController controller = Get.find();

    //   await widgetTester.native.grantPermissionOnlyThisTime();
    //   await widgetTester.pumpAndSettle(duration: Durations.long1);
    //   try {
    //     // if (controller.mobileScannerController.hasTorch) {
    //     await widgetTester.tap(find.byIcon(CameraIcon.cameraRearIcon));
    //     await widgetTester.pumpAndSettle();

    //     await widgetTester.tap(find.byIcon(CameraIcon.cameraFrontIcon));
    //     await widgetTester.pumpAndSettle();

    //     expect(find.byIcon(CameraIcon.cameraRearIcon), findsOneWidget);
    //     expect(find.byIcon(CameraIcon.cameraFrontIcon), findsNothing);

    //     expect(controller.mobileScannerController.cameraFacingState.value,
    //         CameraFacing.back);
    //     // }
    //   } catch (mobileScannerException) {}
    // });
  });
}
