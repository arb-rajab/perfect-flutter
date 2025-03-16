// unsupported.dart

import 'package:beta/abstract/path_base.dart';

class PathService implements PathBase {
  @override
  Future deleteFileFromSupport(String file) => throw UnimplementedError();

  @override
  Future<bool> isFileInSupport(String file) => throw UnimplementedError();

  @override
  Future<bool> saveFile({required String fileName, required String content}) =>
      throw UnimplementedError();
      
  @override
  Future<bool> isFilePartsInSupport(List<String> parts) =>
      throw UnimplementedError();

  @override
  Future<String> getFileSupportPath(List<String> parts) =>
      throw UnimplementedError();
      
  @override
  Future deleteFileFromCache(String fileName) => throw UnimplementedError();
  
}
