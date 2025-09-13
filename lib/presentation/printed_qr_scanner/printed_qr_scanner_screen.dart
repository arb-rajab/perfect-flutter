import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/printed_qr_scanner/gift_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_controller.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class PrintedQrScannerScreen extends StatefulWidget {
  static const route = '/printed-qr-scanner-screen';
  static String title = StringConstant.scanPrintedQr.tr();
  static const icon = Icons.qr_code_scanner;
  const PrintedQrScannerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PrintedQrScannerScreen();
}

class _PrintedQrScannerScreen extends State<PrintedQrScannerScreen> {
  late PrintedQrScannerController _controller;

  @override
  void initState() {
    Get.delete<PrintedQrScannerController>();
    _controller = Get.put(PrintedQrScannerController(this));
    Future.delayed(Duration.zero, () async {
      // ignore: use_build_context_synchronously
      var result = await context.push(ScanQrScreen.route);
      if (result is String) {
        setState(() {
          _controller.barcode = result;
        });
      } else {
        // ignore: use_build_context_synchronously
        context.pop();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        titleText: PrintedQrScannerScreen.title,
        icon: PrintedQrScannerScreen.icon,
        child: _controller.barcode == null
            ? const SizedBox()
            : GiftWidget(
                code: _controller.barcode!,
              ));
  }
}
