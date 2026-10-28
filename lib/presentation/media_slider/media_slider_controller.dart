import 'package:beta/constants/arguments.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class MediaSliderController {
  State state;
  ScreenshotRepository screenshotRepository = Get.find();
  late MediaSliderScreenArgument mediaSlidersScreenArgument;
  PageController pageController = PageController();
  int page = 0;

  MediaSliderController(this.state) {
    _preventScreenshot();
    mediaSlidersScreenArgument = Get.find();
  }

  void _preventScreenshot() =>
      screenshotRepository.setScreenshotPolicy(this, prevent: true);

  void _releaseScreenshot() =>
      screenshotRepository.releaseScreenshotPolicy(this);

  void dispose() {
    _releaseScreenshot();
  }

  // ignore: invalid_use_of_protected_member
  void onPageChanged(int page) => state.setState(() => this.page = page);

  void _goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToPreviousPage() {
    if (previousButtonEnabled()) {
      _goToPage(page - 1);
    }
  }

  void goToNextPage() {
    if (nextButtonEnabled()) {
      _goToPage(page + 1);
    }
  }

  bool previousButtonEnabled() => page > 0;

  bool nextButtonEnabled() =>
      page < mediaSlidersScreenArgument.mediaUrls.length - 1;
}
