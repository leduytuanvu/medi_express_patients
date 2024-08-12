import 'package:medi_express_patients/core/storage/local_storage.dart';

/// Data source for handling local authentication data.
class HomeLocalDatasource {
  final LocalStorage localStorage;

  HomeLocalDatasource(this.localStorage);

  /// Generic method to save a value with a given key.
  Future<void> save(String key, String value) async {
    await localStorage.save(key, value);
  }

  /// Generic method to retrieve a value with a given key.
  Future<String?> get(String key) async {
    return await localStorage.get(key);
  }

  /// Generic method to clear a value with a given key.
  Future<void> clear(String key) async {
    await localStorage.clear(key);
  }

  /// Method to clear all stored values.
  Future<void> clearAll() async {
    await localStorage.clearAll();
  }
}
