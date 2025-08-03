import 'package:marina/common/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _pref;

  Future<StorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool getAppFirstTime() {
    return _pref.getBool(Constants.STORAGE_USER_FIRST_TIME) ?? false;
  }

  bool isLoggedIn() {
    return _pref.getString(Constants.STORAGE_USER_ID) != null ? true : false;
  }
}
