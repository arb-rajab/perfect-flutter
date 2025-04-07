abstract class PathBase {
  Future deleteFileFromSupport(String file);
  Future<bool> isFileInSupport(String file);
  Future<bool> isFilePartsInSupport(List<String> parts);
  Future<String> getFileSupportPath(List<String> parts);
}
