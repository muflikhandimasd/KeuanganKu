import 'package:dartz/dartz.dart';

import 'package:keuanganku_app/app/core/failures/failure.dart';

import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import 'package:keuanganku_app/app/features/transaction/domain/entities/transaction.dart';
import 'package:keuanganku_app/app/features/transaction/domain/usecases/create_transaction_usecase.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/get_transactions_usecase.dart';
import '../../domain/usecases/update_transaction_usecase.dart';
import '../datasources/transaction_local_datasource.dart';
import '../datasources/transaction_remote_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final NetworkInfo networkInfo;
  final TransactionLocalDataSource localDataSource;
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});
  @override
  Future<Either<Failure, void>> createTransaction(
      CreateTransactionUseCaseParams params) async {
    // TODO: implement createTransaction
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(int id) async {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(
      GetTransactionsUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final transactions = await remoteDataSource.getTransactions(params);
        await localDataSource.cacheTransactions(transactions);
        return Right(transactions);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final transactions =
            await localDataSource.getCachedTransactions(params);
        return Right(transactions);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, void>> updateTransaction(
      UpdateTransactionUseCaseParams params) async {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
