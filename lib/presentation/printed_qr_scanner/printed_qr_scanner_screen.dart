import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/printed_qr_scanner/control_buttons_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/gift_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_controller.dart';
import 'package:beta/presentation/printed_qr_scanner/qr_scanner_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/rectangle_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/instance_manager.dart';

//TODO apply test to check logic
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        title: PrintedQrScannerScreen.title,
        icon: PrintedQrScannerScreen.icon,
        child: _controller.barcode == null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  QrScannerWidget(),
                  if (_controller.started)
                    Positioned(
                        bottom: margin,
                        child: RectangleWidget(
                            child:
                                Text(StringConstant.placeQrInRectangle.tr()))),
                  if (_controller.started)
                    const Positioned(top: margin, child: ControlButtons()),
                  if (!_controller.started)
                    const Center(
                      child: AllowCameraPermissionInAppSettings(),
                    )
                ],
              )
            : GiftWidget(
                code: _controller.barcode!.rawValue!,
              ));
  }
}

//TODO apply testing
class AllowCameraPermissionInAppSettings extends StatelessWidget {
  const AllowCameraPermissionInAppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return RectangleWidget(
        child: Column(
      children: [
        Text(StringConstant.enableCameraPermission.tr()),
        const SizedBox(
          height: margin,
        ),
        GestureDetector(
          onTap: openAppSettings,
          child: Text(
            StringConstant.goToAppSettings.tr(),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    ));
  }
}
