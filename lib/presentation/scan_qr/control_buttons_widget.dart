import 'package:beta/presentation/scan_qr/rectangle_widget_with_opacity.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return RectangleWidgetWithOpacity(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [FlashIcon(), CameraIcon()],
      ),
    );
  }
}

class FlashIcon extends StatelessWidget {
  FlashIcon({super.key});
  static const IconData flashOff = Icons.flash_off;
  static const IconData flashOn = Icons.flash_on;
  final ScanQrScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: controller.toggleTorch,
      icon: ValueListenableBuilder(
        valueListenable: controller.mobileScannerController,
        builder: (context, state, child) {
          switch (state.torchState) {
            case TorchState.off:
            case TorchState.unavailable:
              return const Icon(flashOff);
            case TorchState.on:
            case TorchState.auto:
              return const Icon(flashOn);
          }
        },
      ),
    );
  }
}

class CameraIcon extends StatelessWidget {
  static const cameraFrontIcon = Icons.camera_front;
  static const cameraRearIcon = Icons.camera_rear;
  CameraIcon({super.key});
  final ScanQrScreenController controller = Get.find();

  @override
Widget build(BuildContext context) {
    return IconButton(
      onPressed: controller.switchCamera,
      icon: ValueListenableBuilder(
        valueListenable: controller.mobileScannerController,
        builder: (context, state, child) {
          switch (state.cameraDirection) {
            case CameraFacing.front:
              return const Icon(cameraFrontIcon);
            case CameraFacing.back:
            case CameraFacing.external:
            case CameraFacing.unknown:
              return const Icon(cameraRearIcon);
          }
        },
      ),
    );
  }
}
