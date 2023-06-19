import 'dart:convert';

import 'package:keuanganku_app/app/core/constants/constant_key.dart';
import 'package:keuanganku_app/app/core/secure_storage/secure_storage.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<void> cacheToken(String token);
  Future<UserModel?> getUser();
  Future<String?> getToken();
  Future<void> clearUser();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});
  @override
  Future<void> cacheToken(String token) async {
    try {
      await secureStorage.write(key: ConstantKey.keyToken, value: token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await secureStorage.write(
          key: ConstantKey.keyUser, value: jsonEncode(user.toJson()));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await secureStorage.delete(key: ConstantKey.keyToken);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await secureStorage.delete(key: ConstantKey.keyUser);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await secureStorage.read(key: ConstantKey.keyToken);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final user = await secureStorage.read(key: ConstantKey.keyUser);
      if (user != null) {
        return UserModel.fromJson(jsonDecode(user));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
