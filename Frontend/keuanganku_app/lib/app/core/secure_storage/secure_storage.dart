import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:keuanganku_app/app/core/exceptions/exception.dart';

class SecureStorage {
  final FlutterSecureStorage _flutterSecureStorage;

  SecureStorage(this._flutterSecureStorage);

  Future<void> write({required String key, required String value}) async {
    try {
      await _flutterSecureStorage.write(key: key, value: value);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<String?> read({required String key}) async {
    try {
      return await _flutterSecureStorage.read(key: key);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> delete({required String key}) async {
    try {
      await _flutterSecureStorage.delete(key: key);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> deleteAll() async {
    try {
      await _flutterSecureStorage.deleteAll();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
