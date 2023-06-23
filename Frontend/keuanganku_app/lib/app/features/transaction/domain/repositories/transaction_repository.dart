import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/features/transaction/domain/entities/transaction.dart';
import 'package:keuanganku_app/app/features/transaction/domain/usecases/create_transaction_usecase.dart';
import 'package:keuanganku_app/app/features/transaction/domain/usecases/get_transactions_usecase.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../usecases/update_transaction_usecase.dart';

abstract class TransactionRepository {
  Future<Either<Failure, void>> deleteTransaction(int id);
  Future<Either<Failure, void>> createTransaction(
      CreateTransactionUseCaseParams params);
  Future<Either<Failure, void>> updateTransaction(
      UpdateTransactionUseCaseParams params);
  Future<Either<Failure, List<Transaction>>> getTransactions(
      GetTransactionsUseCaseParams params);
}
