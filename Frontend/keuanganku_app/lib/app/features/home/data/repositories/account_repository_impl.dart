import 'package:dartz/dartz.dart';

import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/network_info/network_info.dart';

import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/home/data/datasources/account_remote_datasource.dart';

import 'package:keuanganku_app/app/features/home/domain/entities/account.dart';

import 'package:keuanganku_app/app/features/home/domain/usecases/account/update_account_usecase.dart';

import '../../../../core/exceptions/exception.dart';
import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final NetworkInfo networkInfo;
  final AccountRemoteDataSource remoteDataSource;

  AccountRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, void>> createAccount(String params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createAccount(params);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(message: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteAccount(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(message: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, List<Account>>> getAccounts(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final accounts = await remoteDataSource.getAccounts(params);
        return Right(accounts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(message: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, void>> updateAccount(
      UpdateAccountUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateAccount(params);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(message: "No Internet Connection"));
    }
  }
}
