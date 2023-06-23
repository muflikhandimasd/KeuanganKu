import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/transaction/domain/entities/transaction.dart';

import '../repositories/transaction_repository.dart';

class GetTransactionsUseCase
    extends UseCase<List<Transaction>, GetTransactionsUseCaseParams> {
  final TransactionRepository repository;
  GetTransactionsUseCase(this.repository);
  @override
  Future<Either<Failure, List<Transaction>>> call(
      GetTransactionsUseCaseParams params) async {
    return await repository.getTransactions(params);
  }
}

class GetTransactionsUseCaseParams extends Equatable {
  final String accountId;

  const GetTransactionsUseCaseParams({
    required this.accountId,
  });

  @override
  List<Object?> get props => [accountId];
}
