import 'dart:io';

import 'package:beta/abstract/path_base.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PathService implements PathBase {
  @override
  Future deleteFileFromSupport(String path) async {
    File file = File(join((await getApplicationSupportDirectory()).path, path));
    if (await file.exists()) await file.delete();
  }

  @override
  Future<bool> isFileInSupport(String path) async {
    Directory supportDirectory = await getApplicationSupportDirectory();
    File file = File(join(supportDirectory.path, path));
    return file.exists();
  }

  @override
  Future<bool> saveFile(
      {required String fileName, required String content}) async {
    File file =
        File('${(await getApplicationCacheDirectory()).path}${separator}temp');
    await file.writeAsString(content);
    String? outputFile = await FlutterFileDialog.saveFile(
        params: SaveFileDialogParams(
            sourceFilePath: file.path, fileName: fileName));
    return Future.value(outputFile != null);
  }

  @override
  Future<bool> isFilePartsInSupport(List<String> parts) async {
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
    String path = (await getApplicationSupportDirectory()).path;
    for (String part in parts) {
      path = join(path, part);
    }
    return Future.value(path);
  }
  
  @override
  Future deleteFileFromCache(String fileName) async {
    File file = File(
        '${(await getApplicationCacheDirectory()).path}$separator$fileName');
    return file.delete();
  }
}
