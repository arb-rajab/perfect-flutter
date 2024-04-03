import 'package:beta/main_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValue {
  late SharedPreferences _pref;

  Future<KeyValue> initialise() async {
    if (MainController.testing) {
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues({});
    }
    _pref = await SharedPreferences.getInstance();
    return Future(() => this);
  }

  String? getString(String key, [String? defaultValue]) =>
      _pref.getString(key) ?? defaultValue;

  Future setString(String key, String value) => _pref.setString(key, value);

  double? getDouble(String key, [double? defaultValue]) =>
      _pref.getDouble(key) ?? defaultValue;

  Future setDouble(String key, double value) => _pref.setDouble(key, value);
}
