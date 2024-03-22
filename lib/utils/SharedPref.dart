
import 'package:obscured_preferences/obscured_preferences.dart';

class SharedPref {

  static final SharedPref _instance = SharedPref._ctor();
  factory SharedPref() {
    return _instance;
  }

  SharedPref._ctor();

  ObscuredPrefs  _prefs;

  init() async {
    _prefs = await ObscuredPrefs .getInstance();
  }

  Future setString(String key,String value) {
    return _prefs.setString(key, value);
  }
  Future setBool(String key,bool value) {
    return _prefs.setBool(key, value);
  }

  Future setStringList(String key,List<String> value) {
    return _prefs.setStringList(key, value);
  }
  String getString(String key)  {
    return  _prefs.getString(key);
  }
  bool getBool(String key)  {
    return  _prefs.getBool(key);
  }
  Future setJwtToken(String value) {
    return _prefs.setString('jwtToken', value);
  }

  List<String> getStringList(String key) {
    return _prefs.getStringList(key);

  }
  Future<bool> remove(String key) {
    return _prefs.remove(key);

  }
}