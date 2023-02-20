import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPrefs {
  Future<SharedPreferences> _init() {
    return SharedPreferences.getInstance();
  }

  Future<bool> writeKey(String key, String? data) async {
    bool result = false;

    if(data != null) {
      await _init().then((sharedPrefs) async {
        await sharedPrefs.setString(key, data).then((_) {
          result = true;
        });
      });
    }

    return result;
  }

  Future<String?> readKey(String key) async {
    String? result;

    await _init().then((sharedPrefs) {
      result = sharedPrefs.getString(key);
    });

    return result;
  }

  Future<bool> removeAllKey() async {
    bool result = false;

      await _init().then((sharedPrefs) async {
        await sharedPrefs.clear().then((_) {
          result = true;
        });
      });

    return result;
  }
}