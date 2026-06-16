import 'package:beta/presentation/scan_qr/control_buttons_widget.dart';
import 'package:beta/presentation/scan_qr/rectangle_widget_with_opacity.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../common/tests.dart';

class MockMobileScannerController extends MobileScannerController {
  bool toggleTorchCalled = false;
  bool switchCameraCalled = false;

  @override
  Future<void> toggleTorch() async {
    toggleTorchCalled = !toggleTorchCalled;
  }

  @override
  Future<void> switchCamera([
    SwitchCameraOption option = const ToggleDirection(),
  ]) async {
    switchCameraCalled = !switchCameraCalled;
  }
}

void main() {
  setUp(() async {
    await initTests();
    // Put the mock controller before building the widget
    Get.delete<ScanQrScreenController>();
    Get.put(ScanQrScreenController(_MockState()));
  });

  group('ControlButtons', () {
    testWidgets(
      'renders RectangleWidgetWithOpacity with Row containing two icons',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: ControlButtons()));
        await tester.pumpAndSettle();

        expect(find.byType(RectangleWidgetWithOpacity), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(FlashIcon), findsOneWidget);
        expect(find.byType(CameraIcon), findsOneWidget);
      },
    );

    testWidgets('contains two IconButton widgets', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ControlButtons()));
      await tester.pumpAndSettle();

      expect(find.byType(IconButton), findsNWidgets(2));
    });

    testWidgets('tap on flash icon triggers toggleTorch', (tester) async {
      final mockController = MockMobileScannerController();

      final controller = Get.find<ScanQrScreenController>();
      controller.mobileScannerController = mockController;

      await tester.pumpWidget(const MaterialApp(home: ControlButtons()));
      await tester.pumpAndSettle();

      expect(mockController.toggleTorchCalled, false);

      await tester.tap(find.byType(IconButton).first);
      await tester.pump();

      expect(mockController.toggleTorchCalled, true);
    });

    testWidgets('tap on camera icon triggers switchCamera', (tester) async {
      final mockController = MockMobileScannerController();

      final controller = Get.find<ScanQrScreenController>();
      controller.mobileScannerController = mockController;

      await tester.pumpWidget(const MaterialApp(home: ControlButtons()));
      await tester.pumpAndSettle();

      expect(mockController.switchCameraCalled, false);

      await tester.tap(find.byType(IconButton).last);
      await tester.pump();

      expect(mockController.switchCameraCalled, true);
    });

    testWidgets('retap on flash icon triggers toggleTorch', (tester) async {
      final mockController = MockMobileScannerController();

      final controller = Get.find<ScanQrScreenController>();
      controller.mobileScannerController = mockController;

      await tester.pumpWidget(const MaterialApp(home: ControlButtons()));
      await tester.pumpAndSettle();

      expect(mockController.toggleTorchCalled, false);

      await tester.tap(find.byType(IconButton).first);
      await tester.pump();

      expect(mockController.toggleTorchCalled, true);

      await tester.tap(find.byType(IconButton).first);
      await tester.pump();

      expect(mockController.toggleTorchCalled, false);
    });

    testWidgets('retap on camera icon triggers switchCamera', (tester) async {
      final mockController = MockMobileScannerController();

      final controller = Get.find<ScanQrScreenController>();
      controller.mobileScannerController = mockController;

      await tester.pumpWidget(const MaterialApp(home: ControlButtons()));
      await tester.pumpAndSettle();

      expect(mockController.switchCameraCalled, false);

      await tester.tap(find.byType(IconButton).last);
      await tester.pump();

      expect(mockController.switchCameraCalled, true);

      await tester.tap(find.byType(IconButton).last);
      await tester.pump();

      expect(mockController.switchCameraCalled, false);
    });
  });
}

class _MockState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) => const SizedBox();

  @override
  void setState(VoidCallback fn) {
    fn();
  }
}
