abstract class PathBase {
  Future deleteFileFromSupport(String file);
  Future<bool> isFileInSupport(String file);
  Future<bool> saveFile({required String fileName, required String content});
}
