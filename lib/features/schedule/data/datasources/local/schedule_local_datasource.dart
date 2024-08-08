import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Data source for handling local authentication data.
class ScheduleLocalDatasource {
  final FlutterSecureStorage secureStorage;

  ScheduleLocalDatasource(this.secureStorage);

  /// Generic method to save a value with a given key.
  Future<void> save(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  /// Generic method to retrieve a value with a given key.
  Future<String?> get(String key) async {
    return await secureStorage.read(key: key);
  }

  /// Generic method to clear a value with a given key.
  Future<void> clear(String key) async {
    await secureStorage.delete(key: key);
  }

  /// Method to clear all stored values.
  Future<void> clearAll() async {
    await secureStorage.deleteAll();
  }
}
