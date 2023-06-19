import 'package:dio/dio.dart';
import 'package:keuanganku_app/app/core/api_handler/api_handler.dart';
import 'package:keuanganku_app/app/core/config/api_config.dart';
import 'package:keuanganku_app/app/core/exceptions/exception.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/send_otp_usecase.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> sendOtp(SendOtpUseCaseParams params);
  Future<UserModel> login(LoginUseCaseParams params);
  Future<bool> register(RegisterUseCaseParams params);
  Future<bool> logout(NoParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiHandler apiHandler;

  AuthRemoteDataSourceImpl({required this.apiHandler});

  @override
  Future<UserModel> login(LoginUseCaseParams params) async {
    try {
      final response =
          await apiHandler.post(ApiConfig.LOGIN, data: params.toJson());
      final user = UserModel.fromJson(response.data['data']);
      return user;
    } on DioException catch (e) {
      throw ServerException(
          message: e.response?.data['message'] ?? 'Server Error');
    } on CacheException catch (e) {
      throw CacheException(message: e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> logout(NoParams params) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> register(RegisterUseCaseParams params) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<bool> sendOtp(SendOtpUseCaseParams params) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }
}
