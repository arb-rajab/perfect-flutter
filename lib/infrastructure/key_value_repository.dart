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

  /// Re-reads the values, e.g. ones another Flutter engine wrote.
  Future<void> reload() => _pref.reload();

  String? getString(String key, [String? defaultValue]) =>
      _pref.getString(key) ?? defaultValue;

  Future setString(String key, String value) => _pref.setString(key, value);

  double? getDouble(String key, [double? defaultValue]) =>
      _pref.getDouble(key) ?? defaultValue;

  Future setDouble(String key, double value) => _pref.setDouble(key, value);

  List<String>? getStringList(String key) => _pref.getStringList(key);

  Future setStringList(String key, List<String> value) =>
      _pref.setStringList(key, value);

  bool? getBool(String key, [bool? defaultValue]) =>
      _pref.getBool(key) ?? defaultValue;

  Future setBool(String key, bool value) => _pref.setBool(key, value);
}
