import 'package:beta/constants/string_constant.dart';
import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? empty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringConstant.pleaseFillThisField.tr();
    }
    return null;
  }

  static String? multiValidators(
      List<String? Function(String?)> validators, String? value) {
    String response = '';
    for (var validator in validators) {
      if (validator(value) != null) response += "${validator(value)!}\n";
    }
    if (response.endsWith('\n')) {
      response = response.substring(0, response.length - 1);
    }
    if (response.isNotEmpty) return response;
    return null;
  }

  static String? isMD5(String? value) {
    RegExp regExp = RegExp(
        r'^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$');
    if (value != null) if (regExp.hasMatch(value)) return null;
    return StringConstant.notValidMD5Format.tr();
  }
}
