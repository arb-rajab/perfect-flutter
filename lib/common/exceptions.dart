import 'dart:io';

class UnsupportedPlatformException implements Exception {
  UnsupportedPlatformException();

  @override
  String toString() => "${Platform.operatingSystem} is not yet supported";
}
