import 'package:beta/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanQrScreenController {
  final State<StatefulWidget> state;
  ScanQrScreenController(this.state) {
    mobileScannerController.addListener(() {
      if (mobileScannerController.value.isRunning) {
        setScannerStarted();
      }
    });
  }
  MobileScannerController mobileScannerController = MobileScannerController();

  bool started = false;
  bool poped = false;
  bool appSettingsOpened = false;

  String? barcode;

  void setScannerStarted() {
    // ignore: invalid_use_of_protected_member
    state.setState(() {
      started = true;
    });
  }

  void onDetect(BarcodeCapture capture) {
    if (barcode != null) return;
  
    final String? scanned = capture.barcodes
        .where((b) => b.rawValue != null)
        .firstOrNull
        ?.rawValue;

    if (scanned == null) return;

    barcode = scanned;
    if (MainController.testing) {
      poped = true;
    } else {
      state.context.pop(barcode);
    }
  }

  void openSettings() {
    if (MainController.testing) {
      appSettingsOpened = true;
    } else {
      openAppSettings();
    }
  }

  void toggleTorch() => mobileScannerController.toggleTorch();

  void switchCamera() => mobileScannerController.switchCamera();
}
