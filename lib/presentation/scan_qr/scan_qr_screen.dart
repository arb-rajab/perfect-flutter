import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/scan_qr/control_buttons_widget.dart';
import 'package:beta/presentation/scan_qr/qr_scanner_widget.dart';
import 'package:beta/presentation/scan_qr/rectangle_widget_with_opacity.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen_controller.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanQrScreen extends StatefulWidget {
  static const String route = '/scan-qr';
  static const IconData icon = Icons.qr_code_scanner;
  static String title = StringConstant.scanQr.tr();
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  late ScanQrScreenController _controller;
  @override
  void initState() {
    Get.delete<ScanQrScreenController>();
    _controller = Get.put(ScanQrScreenController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        child: Stack(
      alignment: Alignment.center,
      children: [
        QrScannerWidget(),
        if (_controller.started)
          Positioned(
              bottom: margin,
              child: RectangleWidgetWithOpacity(
                  child: Text(StringConstant.placeQrInRectangle.tr()))),
        if (_controller.started)
          const Positioned(top: margin, child: ControlButtons()),
        if (!_controller.started)
          const Center(
            child: AllowCameraPermissionInAppSettings(),
          )
      ],
    ));
  }
}

class AllowCameraPermissionInAppSettings extends StatelessWidget {
  const AllowCameraPermissionInAppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return RectangleWidgetWithOpacity(
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
