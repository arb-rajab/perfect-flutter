import 'package:beta/common/boolean_converter.dart';
import 'package:test/test.dart';

void main() {
  const converter = BooleanConverter();

  group('BooleanConverter', () {
    test('fromJson converts 1 to true', () {
      expect(converter.fromJson(1), isTrue);
    });

    test('fromJson converts 0 to false', () {
      expect(converter.fromJson(0), isFalse);
    });

    test('toJson converts true to 1', () {
      expect(converter.toJson(true), equals(1));
    });

    test('toJson converts false to 0', () {
      expect(converter.toJson(false), equals(0));
    });
  });
}
