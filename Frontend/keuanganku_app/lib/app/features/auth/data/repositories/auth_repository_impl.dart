import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/exceptions/exception.dart';

import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/network_info/network_info.dart';

import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:keuanganku_app/app/features/auth/data/datasources/auth_remote_datasource.dart';

import 'package:keuanganku_app/app/features/auth/domain/entities/user.dart';

import 'package:keuanganku_app/app/features/auth/domain/usecases/register_usecase.dart';

import 'package:keuanganku_app/app/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/verify_otp_usecase.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, User?>> checkLogin(NoParams params) async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } catch (_) {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp(VerifyOtpUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.verifyOtp(params);
        await localDataSource.cacheUser(user);
        await localDataSource.cacheToken(user.token);
        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.logout(params);
        await localDataSource.clearUser();
        await localDataSource.clearToken();

        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, void>> register(RegisterUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.register(params);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendOtp(SendOtpUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.sendOtp(params);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
