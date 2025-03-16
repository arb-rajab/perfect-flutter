import 'dart:io';

import 'package:beta/presentation/ebook/ebook_screen_controller.dart';
import 'package:beta/presentation/ebook/ebook_widget.dart';
import 'package:flutter/widgets.dart';

import 'package:get/instance_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

class EbookWidgetState extends State<EbookWidget> {
  bool fileLoaded = false;
  EbookScreenController ebookScreenController = Get.find();

  late File file;

  Future _configureFile() async {
    file = File(join((await getApplicationSupportDirectory()).path,
        'term$separator${ebookScreenController.ebookScreenArgument.ebook.parentTermId}'));
    setState(() => fileLoaded = true);
  }

  Future<void> onCreated(DocumentViewController controller) async {
    controller.openDocument(file.path,
        password: ebookScreenController.decryptEncryptionKey(
            ebookScreenController.ebookScreenArgument.ebook.encryptionKey),
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
          ..openSavedCopyInNewTab = false
          ..thumbnailViewEditingEnabled = false);
  }

  @override
  void initState() {
    _configureFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!fileLoaded) return const Center();
    return DocumentView(onCreated: onCreated);
  }
}
