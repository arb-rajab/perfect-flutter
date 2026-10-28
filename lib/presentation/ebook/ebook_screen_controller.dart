import 'package:beta/constants/arguments.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
import 'package:get/instance_manager.dart';

class EbookScreenController {
  EbookScreenArgument ebookScreenArgument = Get.find();
  ScreenshotRepository screenshotRepository = Get.find();

  EbookScreenController() {
    _configureScreenshots();
  }

  void dispose() => screenshotRepository.releaseScreenshotPolicy(this);

  void _configureScreenshots() {
    screenshotRepository.setScreenshotPolicy(this,
        prevent: ebookScreenArgument.term.term.captureable == 0);
  }

}
