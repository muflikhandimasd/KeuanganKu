import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import '../repositories/transaction_repository.dart';

class CreateTransactionUseCase
    extends UseCase<void, CreateTransactionUseCaseParams> {
  final TransactionRepository repository;

  CreateTransactionUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(
      CreateTransactionUseCaseParams params) async {
    return await repository.createTransaction(params);
  }
}

class CreateTransactionUseCaseParams extends Equatable {
  final int accountId;
  final String type;
  final String amount;
  final String date;
  final String? description;

  const CreateTransactionUseCaseParams({
    required this.accountId,
    required this.type,
    required this.amount,
    required this.date,
    this.description,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [accountId, type, amount, date, description];
}
