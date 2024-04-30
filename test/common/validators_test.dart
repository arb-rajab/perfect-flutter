import 'package:beta/common/validators.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('empty', () {
    test('empty validator returns error when string is null', () {
      String? response = Validator.empty(null);
      expect(response, StringConstant.pleaseFillThisField.tr());
    });

    test('empty validator returns error when string is empty', () {
      String? response = Validator.empty('');
      expect(response, StringConstant.pleaseFillThisField.tr());
    });

    test('empty validator returns error when string is only spaces', () {
      String? response = Validator.empty('   ');
      expect(response, StringConstant.pleaseFillThisField.tr());
    });

    test('empty validator returns null when string is valid', () {
      String? response = Validator.empty('valid string');
      expect(response, null);
    });
  });

  group('isMD5', () {
    test('md5 validator returns error when string is not md5', () {
      String? response = Validator.isMD5('normal string');
      expect(response, StringConstant.notValidMD5Format.tr());
    });

    test('md5 validator returns null when string is md5', () {
      String? response =
          Validator.isMD5('f6bebb75-6e29-3721-7dd4-12d90b38e6b9');
      expect(response, null);
    });
  });
}
