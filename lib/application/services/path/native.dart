import 'dart:io';

import 'package:beta/abstract/path_base.dart';
import 'package:beta/main_controller.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PathService implements PathBase {
  @override
  Future deleteFileFromSupport(String path) async {
    if (MainController.testing) {
      testFileInSupport = false;
      return;
    }
    File file = File(join((await getApplicationSupportDirectory()).path, path));
    if (await file.exists()) await file.delete();
  }

  @override
  Future<bool> isFilePartsInSupport(List<String> parts) async {
    if (MainController.testing) return Future.value(testFileInSupport);
    if (parts.isEmpty) return Future.value(true);
    String path = (await getApplicationSupportDirectory()).path;
    for (String part in parts) {
      path = join(path, part);
    }
    File file = File(path);
    return file.exists();
  }

  @override
  Future<String> getFileSupportPath(List<String> parts) async {
    String path = 'test path';
    if (!MainController.testing) {
      path = (await getApplicationSupportDirectory()).path;
    }
    for (String part in parts) {
      path = join(path, part);
    }
    return Future.value(path);
  }

  @override
  bool testFileInSupport = false;
}
