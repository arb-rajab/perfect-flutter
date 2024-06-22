import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrScreenController {
  final State<StatefulWidget> state;
  ScanQrScreenController(this.state);
  MobileScannerController mobileScannerController = MobileScannerController();

  bool started = false;

  String? barcode;

  void setScannerStarted() {
    // ignore: invalid_use_of_protected_member
    state.setState(() {
      started = true;
    });
  }

  void onDetect(BarcodeCapture capture) {
    if (barcode != null) return;
    final List<Barcode> barcodes = capture.barcodes;
    barcode = barcodes.first.rawValue!;
    state.context.pop(barcode);
  }
}
