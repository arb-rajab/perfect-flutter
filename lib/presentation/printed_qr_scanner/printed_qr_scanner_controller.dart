// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PrintedQrScannerController {
  State<StatefulWidget> state;

  PrintedQrScannerController(this.state);

  MobileScannerController mobileScannerController = MobileScannerController();

  bool started = false;

  Barcode? barcode;

  void setScannerStarted() {
    state.setState(() {
      started = true;
    });
  }
}
