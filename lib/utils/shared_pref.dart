import 'package:shared_preferences/shared_preferences.dart';

final preferences = SharedPrefsUtils();

class SharedPrefsUtils{
  SharedPreferences? _sharedPreferences;

  init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> save({
    required String key,
    required dynamic data,
  }) async {
    if (_sharedPreferences != null) {
      if (data is String) {
        await _sharedPreferences?.setString(key, data);
      } else if (data is int) {
        await _sharedPreferences?.setInt(key, data);
      } else if (data is double) {
        await _sharedPreferences?.setDouble(key, data);
      } else if (data is bool) {
        await _sharedPreferences?.setBool(key, data);
      }
    }
    return;
  }

  String getString({required String key, String defaultVal = ""}) {
    return _sharedPreferences != null
        ? _sharedPreferences!.getString(key) ?? defaultVal
        : defaultVal;
  }

  int getInt({required String key}) {
    return _sharedPreferences != null
        ? _sharedPreferences!.getInt(key) ?? 0
        : 0;
  }

  double getDouble({required String key}) {
    return _sharedPreferences != null
        ? _sharedPreferences!.getDouble(key) ?? 0.0
        : 0.0;
  }

}

class SharedKeys {
  static const userName = 'UserName';
}


