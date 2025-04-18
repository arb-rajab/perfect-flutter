import 'package:beta/constants/arguments.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class MediaSliderController {
  State state;
  ScreenshotRepository screenshotRepository = Get.find();
  late MediaSliderScreenArgument mediaSlidersScreenArgument;
  int page = 0;

  MediaSliderController(this.state) {
    _preventScreenshot();
    mediaSlidersScreenArgument = Get.find();
  }

  void _preventScreenshot() => screenshotRepository.preventScreenshot();

  void _allowScreenshot() => screenshotRepository.allowScreenshot();

  void dispose() {
    _allowScreenshot();
  }

  // ignore: invalid_use_of_protected_member
  void onPageChanged(int page) => state.setState(() => this.page = page);
}
