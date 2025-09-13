import 'package:beta/common/date_time_converter.dart';
import 'package:test/test.dart';

void main() {
  const converter = DateTimeConverter();

  group('DateTimeConverter', () {
    test('fromJson converts ISO8601 string to DateTime (local)', () {
      const dateStr = '2025-09-13T12:00:00Z';
      final dateTime = converter.fromJson(dateStr);
      expect(dateTime.isUtc, isFalse);
      expect(dateTime.year, 2025);
      expect(dateTime.month, 9);
      expect(dateTime.day, 13);
    });

    test('toJson converts DateTime to local String', () {
      final dateTime = DateTime.utc(2025, 9, 13, 12, 0, 0);
      final jsonStr = converter.toJson(dateTime);
      final parsed = DateTime.parse(jsonStr);
      expect(parsed.isUtc, isFalse);
      expect(parsed.year, 2025);
      expect(parsed.month, 9);
      expect(parsed.day, 13);
    });
  });
}
