class UnsupportedValueException implements Exception {
  String value;
  UnsupportedValueException(this.value);

  @override
  String toString() => "$value is not supported";
}
