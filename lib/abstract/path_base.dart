abstract class PathBase {
  bool testFileInSupport = false;
  Future deleteFileFromSupport(String file);
  Future<bool> isFilePartsInSupport(List<String> parts);
  Future<String> getFileSupportPath(List<String> parts);
}
