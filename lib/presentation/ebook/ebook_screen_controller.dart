import 'dart:io';

import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/infrastructure/screenshot_repository.dart';
import 'package:flutter/widgets.dart';

import 'package:get/instance_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

class EbookScreenController {
  EbookScreenArgument ebookScreenArgument = Get.find();
  ScreenshotRepository screenshotRepository = Get.find();
  late File file;
  bool fileLoaded = false;
  TermLastAccessService termLastAccessService = Get.find();

  State<StatefulWidget> state;
  bool modified = false;

  EbookScreenController(this.state) {
    _configureScreenshots();
    _configureFile();
  }

  void dispose() => screenshotRepository.allowScreenshot();

  _configureScreenshots() {
    if (ebookScreenArgument.term.term.captureable == 0) {
      screenshotRepository.preventScreenshot();
    } else {
      screenshotRepository.allowScreenshot();
    }
  }

  String _decryptEncryptionKey(String encryptionKey) {
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

  Future<void> onCreated(DocumentViewController controller) async {
    controller.openDocument(file.path,
        password:
            _decryptEncryptionKey(ebookScreenArgument.ebook.encryptionKey),
        config: Config()
          ..disabledElements = [
            Buttons.shareButton,
            Buttons.printButton,
            Buttons.saveCopyButton,
            Buttons.editPagesButton
          ]
          ..multiTabEnabled = false
          ..layoutMode = LayoutModes.single
          ..hideViewModeItems = [ViewModePickerItem.VerticalScrolling]
          ..openSavedCopyInNewTab = false);
  }

  Future _configureFile() async {
    file = File(join((await getApplicationSupportDirectory()).path,
        'term$separator${ebookScreenArgument.ebook.parentTermId}'));
    state.setState(() => fileLoaded = true);
  }
}
