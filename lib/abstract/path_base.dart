abstract class PathBase {
  Future deleteFileFromSupport(String file);
  Future<bool> isFileInSupport(String file);
  Future<bool> isFilePartsInSupport(List<String> parts);
  Future<bool> saveFile({required String fileName, required String content});
  Future<String> getFileSupportPath(List<String> parts);
  Future deleteFileFromCache(String fileName);
}
