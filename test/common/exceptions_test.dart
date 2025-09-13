import 'package:beta/common/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('UnsupportedValueException', () {
    test('toString returns correct message', () {
      final exception = UnsupportedValueException('testValue');
      expect(exception.toString(), equals('testValue is not supported'));
    });

    test('value property stores the passed value', () {
      final exception = UnsupportedValueException('someValue');
      expect(exception.value, equals('someValue'));
    });
  });
}
