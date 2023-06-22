import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:keuanganku_app/app/core/api_handler/api_handler.dart';
import 'package:keuanganku_app/app/core/config/api_config.dart';
import 'package:keuanganku_app/app/core/exceptions/exception.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/update_account_usecase.dart';

import '../models/account_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<AccountModel>> getAccounts(NoParams params);
  Future<void> createAccount(String name);
  Future<void> updateAccount(UpdateAccountUseCaseParams params);
  Future<void> deleteAccount(int id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiHandler api;
  HomeRemoteDataSourceImpl(this.api);
  @override
  Future<void> createAccount(String name) async {
    try {
      await api.post(ApiConfig.ACCOUNT, data: {
        'name': name,
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.response?.data['message'] ?? 'Server Error');
    }
  }

  @override
  Future<void> deleteAccount(int id) async {
    try {
      await api.delete('${ApiConfig.ACCOUNT}/$id');
    } on DioException catch (e) {
      throw ServerException(
          message: e.response?.data['message'] ?? 'Server Error');
    }
  }

  @override
  Future<List<AccountModel>> getAccounts(NoParams params) async {
    try {
      final response = await api.get(ApiConfig.ACCOUNT);
      final List responseAccounts = response.data['data'];
      final List<AccountModel> accounts = [];
      for (final json in responseAccounts) {
        accounts.add(AccountModel.fromJson(json));
      }
      return accounts;
    } on DioException catch (e) {
      throw ServerException(
          message: e.response?.data['message'] ?? 'Server Error');
    }
  }

  @override
  Future<void> updateAccount(UpdateAccountUseCaseParams params) async {
    try {
      await api.put('${ApiConfig.ACCOUNT}/${params.id}', data: {
        'name': params.name,
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.response?.data['message'] ?? 'Server Error');
    }
  }
}
