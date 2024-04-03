import 'dart:io';

class UnsupportedPlatformException implements Exception {
  UnsupportedPlatformException();

  @override
  String toString() => "${Platform.operatingSystem} is not yet supported";
}

class UnsupportedValueException implements Exception {
  String value;
  UnsupportedValueException(this.value);

  @override
  String toString() => "$value is not supported";
}
