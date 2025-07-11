import 'package:beta/constants/arguments.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
import 'package:get/instance_manager.dart';

class EbookScreenController {
  EbookScreenArgument ebookScreenArgument = Get.find();
  ScreenshotRepository screenshotRepository = Get.find();

  EbookScreenController() {
    _configureScreenshots();
  }

  void dispose() => screenshotRepository.allowScreenshot();

  void _configureScreenshots() {
    if (ebookScreenArgument.term.term.captureable == 0) {
      screenshotRepository.preventScreenshot();
    } else {
      screenshotRepository.allowScreenshot();
    }
  }

}
