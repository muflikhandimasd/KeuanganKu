import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import '../../repositories/account_repository.dart';

class CreateAccountUseCase extends UseCase<void, String> {
  final AccountRepository repository;

  CreateAccountUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.createAccount(params);
  }
}
