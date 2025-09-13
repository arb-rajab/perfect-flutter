import 'package:beta/helper/encryption.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Encryption.decryptEncryptionKey', () {
    test('returns empty string if input is empty', () {
      expect(Encryption.decryptEncryptionKey(''), '');
    });

    test('correctly decrypts with valid fibonacci indices', () {
      // fibonacci sequence for index: 1,2,3,5,8 (for length > 8)
      // For encryptionKey = "abcdefghijklmno"
      // indexes: 1:'b', 2:'c', 3:'d', 5:'f', 8:'i'
      expect(Encryption.decryptEncryptionKey('abcdefghijklmn'), 'bcdfin');
    });

    test('returns correct password for short input', () {
      expect(Encryption.decryptEncryptionKey('abcd'), 'bcd');
    });
  });
}
