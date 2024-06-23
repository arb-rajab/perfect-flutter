import 'package:beta/infrastructure/screenshot_repository.dart';
import 'package:beta/presentation/question_medias/question_medias_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class QuestionMediaController {
  State state;
  ScreenshotRepository screenshotRepository = Get.find();
  late QuestionMediasScreenArgument questionMediasScreenArgument;
  int page = 0;

  QuestionMediaController(this.state) {
    _preventScreenshot;
    questionMediasScreenArgument = Get.find();
  }

  void _preventScreenshot() => screenshotRepository.preventScreenshot;

  void _allowScreenshot() => screenshotRepository.allowScreenshot;

  void dispose() {
    _allowScreenshot;
  }

  // ignore: invalid_use_of_protected_member
  void onPageChanged(int page) => state.setState(() => this.page = page);
}
