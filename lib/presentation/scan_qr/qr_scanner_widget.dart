// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/presentation/scan_qr/scan_qr_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerWidget extends StatelessWidget {
  QrScannerWidget({super.key});
  final ScanQrScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      // fit: BoxFit.contain,
      controller: controller.mobileScannerController,
      onDetect: controller.onDetect,
      onScannerStarted: (_) => controller.setScannerStarted(),
    );
  }
}
