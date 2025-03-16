import 'package:beta/abstract/path_base.dart';

class PathService implements PathBase {
  @override
  Future deleteFileFromSupport(String file) {
    // TODO: implement deleteFileFromSupport
    throw UnimplementedError();
  }

  @override
  Future<bool> isFileInSupport(String file) {
    // TODO: implement isFileInSupport
    throw UnimplementedError();
  }

  @override
  Future<bool> saveFile({required String fileName, required String content}) {
    // TODO: implement saveFile
    throw UnimplementedError();
  }
  
  @override
  Future<bool> isFilePartsInSupport(List<String> parts) {
    // TODO: implement isFilePartsInSupport
    throw UnimplementedError();
  }

  @override
  Future<String> getFileSupportPath(List<String> parts) {
    // TODO: implement getFileSupportPath
    throw UnimplementedError();
  }
}
