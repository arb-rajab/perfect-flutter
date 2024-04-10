import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_controller.dart';
import 'package:beta/presentation/printed_qr_scanner/rectangle_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const RectangleWidget(
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
  const FlashIcon({super.key});
  static const IconData flashOff = Icons.flash_off;
  static const IconData flashOn = Icons.flash_on;

  @override
  Widget build(BuildContext context) {
    PrintedQrScannerController controller = Get.find();
    return IconButton(
        onPressed: () async {
          await controller.mobileScannerController.toggleTorch();
        },
        icon: ValueListenableBuilder(
            valueListenable: controller.mobileScannerController.torchState,
            builder: (context, state, child) {
              switch (state) {
                case TorchState.off:
                  return const Icon(flashOff);
                case TorchState.on:
                  return const Icon(flashOn);
              }
            }));
  }
}

class CameraIcon extends StatelessWidget {
  static const cameraFrontIcon = Icons.camera_front;
  static const cameraRearIcon = Icons.camera_rear;
  const CameraIcon({super.key});

  @override
  Widget build(BuildContext context) {
    PrintedQrScannerController controller = Get.find();
    return IconButton(
      onPressed: () async {
        await controller.mobileScannerController.switchCamera();
      },
      icon: ValueListenableBuilder(
        valueListenable: controller.mobileScannerController.cameraFacingState,
        builder: (context, state, child) {
          switch (state) {
            case CameraFacing.front:
              return const Icon(cameraFrontIcon);
            case CameraFacing.back:
              return const Icon(cameraRearIcon);
          }
        },
      ),
    );
  }
}
