import 'package:beta/main.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();

  testWidgets('mobile scanner', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: ScanQrScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    expect(find.byType(MobileScanner), findsOneWidget);
  });

  testWidgets(
      'mobile scanner ignores multiple code scans and only takes the first value',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: ScanQrScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    ScanQrScreenController scanQrScreenController = Get.find();
    scanQrScreenController.barcode = 'random barcode';
    scanQrScreenController.onDetect(BarcodeCapture(barcodes: [
      const Barcode(rawValue: 'barcode 1'),
      const Barcode(rawValue: 'barcode 2')
    ]));
    expect(scanQrScreenController.barcode, 'random barcode');
    expect(find.byType(ScanQrScreen), findsOneWidget);
  });

  testWidgets('mobile scanner pops when scaning qr', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp(
      defaultRoute: ScanQrScreen.route,
    ));
    await widgetTester.pumpAndSettle();
    ScanQrScreenController scanQrScreenController = Get.find();
    scanQrScreenController.onDetect(
        BarcodeCapture(barcodes: [const Barcode(rawValue: 'random barcode')]));
    await widgetTester.pumpAndSettle();
    expect(scanQrScreenController.poped, true);
  });
}
