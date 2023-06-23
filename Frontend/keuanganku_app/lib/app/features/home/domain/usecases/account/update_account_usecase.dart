import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import '../../repositories/account_repository.dart';

class UpdateAccountUseCase extends UseCase<void, UpdateAccountUseCaseParams> {
  final AccountRepository repository;

  UpdateAccountUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(UpdateAccountUseCaseParams params) async {
    return await repository.updateAccount(params);
  }
}

class UpdateAccountUseCaseParams extends Equatable {
  final int id;
  final String name;

  const UpdateAccountUseCaseParams({
    required this.id,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
