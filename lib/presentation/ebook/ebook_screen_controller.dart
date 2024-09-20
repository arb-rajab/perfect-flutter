import 'dart:io';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/infrastructure/screenshot_repository.dart';
import 'package:flutter/widgets.dart';

import 'package:get/instance_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:pdftron_flutter/pdftron_flutter.dart';

class EbookScreenController {
//   EbookScreenArgument ebookScreenArgument = Get.find();
//   ScreenshotRepository screenshotRepository = Get.find();
//   late File file;
//   bool fileLoaded = false;
//   // PdfViewerController pdfViewerController = PdfViewerController();
//   TermLastAccessService termLastAccessService = Get.find();

//   State<StatefulWidget> state;
//   // late PdfDocumentLoadedDetails details;
//   bool modified = false;

//   EbookScreenController(this.state) {
//     _configureScreenshots();
//     _configureFile();
//   }

//   void dispose() async {
//     screenshotRepository.allowScreenshot();
//     termLastAccessService.addTermLastAccessed(
//         Id(ebookScreenArgument.term.term.id),
//         Id(pdfViewerController.pageNumber));
//   }

//   _configureScreenshots() {
//     if (ebookScreenArgument.term.term.captureable == 0) {
//       screenshotRepository.preventScreenshot();
//     } else {
//       screenshotRepository.allowScreenshot();
//     }
//   }

//   String decryptEncryptionKey() {
//     String encryptionKey = ebookScreenArgument.ebook.encryptionKey;
//     List<int> fibonacci = [];
//     fibonacci.add(1);
//     fibonacci.add(2);
//     String password = "";
//     if (encryptionKey.isNotEmpty) {
//       while (fibonacci[fibonacci.length - 1] < encryptionKey.length - 1) {
//         fibonacci.add(
//             fibonacci[fibonacci.length - 1] + fibonacci[fibonacci.length - 2]);
//       }
//       for (int c = 0; c < fibonacci.length; c++) {
//         password = "$password${encryptionKey[fibonacci[c]]}";
//       }
//     }
//     return password;
//   }

//   // Future<void> onCreated(DocumentViewController controller) async {
//   //   controller.openDocument(file.path,
//   //       password:
//   //           _decryptEncryptionKey(ebookScreenArgument.ebook.encryptionKey),
//   //       config: Config()
//   //         ..disabledElements = [
//   //           Buttons.shareButton,
//   //           Buttons.printButton,
//   //           Buttons.saveCopyButton,
//   //           Buttons.editPagesButton
//   //         ]
//   //         ..multiTabEnabled = false
//   //         ..hideViewModeItems = [
//   //           ViewModePickerItem.VerticalScrolling,
//   //           ViewModePickerItem.ColorMode
//   //         ]
//   //         ..openSavedCopyInNewTab = false);
//   // }

//   _configurePageNumber() async {
//     TermsLastAccess? termLastAccess = await termLastAccessService
//         .getTermLastAccess(ebookScreenArgument.term.term.id);
//     if (termLastAccess != null) {
//       pdfViewerController.jumpToPage(termLastAccess.childId);
//     }
//   }

//   Future _configureFile() async {
//     file = File(join((await getApplicationSupportDirectory()).path,
//         'term$separator${ebookScreenArgument.ebook.parentTermId}'));
//     state.setState(() => fileLoaded = true);
//     _configurePageNumber();
//   }

//   // Future saveChanges() async {
//   //   // if (modified) return pdfViewerController.saveDocument();
//   //   if (modified) {
//   //     List<int> bytes = await pdfViewerController.saveDocument();
//   //     return file.writeAsBytes(bytes);
//   //   }
//   // }

//   // void onDocumentLoaded(PdfDocumentLoadedDetails details) {
//   //   this.details = details;
//   // }

//   // void onAnnotationAdded(Annotation annotation) {
//   //   modified = true;
//   // }

//   // void onAnnotationEdited(Annotation annotation) {
//   //   modified = true;
//   // }

//   // void onAnnotationRemoved(Annotation annotation) {
//   //   modified = true;
//   // }
}
