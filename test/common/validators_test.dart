import 'package:beta/common/validators.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validator', () {
    test('empty returns error message for null or empty', () {
      expect(Validator.empty(null), StringConstant.pleaseFillThisField);
      expect(Validator.empty(''), StringConstant.pleaseFillThisField);
      expect(Validator.empty('   '), StringConstant.pleaseFillThisField);
      expect(Validator.empty('valid'), null);
    });

    test('multiValidators concatenates multiple errors', () {
      String? validator1(String? v) => v == 'fail' ? 'error1' : null;
      String? validator2(String? v) => v == 'fail' ? 'error2' : null;

      expect(Validator.multiValidators([validator1, validator2], 'fail'),
          'error1\nerror2');

      expect(Validator.multiValidators([validator1, validator2], 'pass'), null);
    });

    test('isMD5 validates correct MD5 format', () {
      expect(Validator.isMD5('123e4567-e89b-12d3-a456-426614174000'), null);
      expect(Validator.isMD5('invalid-md5'), StringConstant.notValidMD5Format);
      expect(Validator.isMD5(null), StringConstant.notValidMD5Format);
    });
  });
}
