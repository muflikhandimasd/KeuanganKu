import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class UpdateTransactionUseCase
    extends UseCase<void, UpdateTransactionUseCaseParams> {
  final TransactionRepository repository;

  UpdateTransactionUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(
      UpdateTransactionUseCaseParams params) async {
    return await repository.updateTransaction(params);
  }
}

class UpdateTransactionUseCaseParams extends Equatable {
  final int id;
  final String accountId;
  final String type;
  final String amount;
  final String date;
  final String? description;

  const UpdateTransactionUseCaseParams({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.date,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'amount': amount,
        'date': date,
        'description': description,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, accountId, type, amount, date, description];
}
