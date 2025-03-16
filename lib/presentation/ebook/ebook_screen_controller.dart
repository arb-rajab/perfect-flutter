import 'package:beta/constants/arguments.dart';
import 'package:beta/infrastructure/screenshot_repository.dart';
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

  String decryptEncryptionKey(String encryptionKey) {
    List<int> fibonacci = [];
    fibonacci.add(1);
    fibonacci.add(2);
    String password = "";
    if (encryptionKey.isNotEmpty) {
      while (fibonacci[fibonacci.length - 1] < encryptionKey.length - 1) {
        fibonacci.add(
            fibonacci[fibonacci.length - 1] + fibonacci[fibonacci.length - 2]);
      }
      for (int c = 0; c < fibonacci.length; c++) {
        password = "$password${encryptionKey[fibonacci[c]]}";
      }
    }
    return password;
  }
}
