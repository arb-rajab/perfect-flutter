// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerWidget extends StatelessWidget {
  QrScannerWidget({super.key});
  final PrintedQrScannerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      // fit: BoxFit.contain,
      controller: controller.mobileScannerController,
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        controller.state.setState(() {
          controller.barcode = barcodes.first;
        });
      },
      onScannerStarted: (_) => controller.setScannerStarted(),
    );
    // return QRView(
    //     key: GlobalKey(debugLabel: 'qr'),
    //     onQRViewCreated: onQRViewCreated,
    //     overlay: QrScannerOverlayShape(
    //         borderColor: Theme.of(context).primaryColor,
    //         borderRadius: borderRadius,
    //         borderLength: 20,
    //         borderWidth: borderWidth,
    //         cutOutSize: MediaQuery.of(context).size.width * 0.8));
  }

  // void onQRViewCreated(QRViewController p1) {
  //   PrintedQrScannerController controller = Get.find();
  //   controller.state.setState(() {
  //     controller.qrViewController = p1;
  //   });
  //   p1.scannedDataStream.listen((barcode) => controller.state.setState(() {
  //         controller.barcode = barcode;
  //       }));
  // }
}
