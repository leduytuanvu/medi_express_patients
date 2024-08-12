import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  late SharedPreferences _prefs;
  bool _initialized = false;

  LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  Future<void> save(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<String?> get(String key) async {
    return _prefs.getString(key);
  }

  Future<void> clear(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
