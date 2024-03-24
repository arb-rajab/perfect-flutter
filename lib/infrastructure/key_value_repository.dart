import 'package:shared_preferences/shared_preferences.dart';

class KeyValue {
  late SharedPreferences _pref;

  Future<KeyValue> initialise() async {
    _pref = await SharedPreferences.getInstance();
    return Future(() => this);
  }

  String? getString(String key) => _pref.getString(key);

  Future setString(String key, String value) => _pref.setString(key, value);
}
