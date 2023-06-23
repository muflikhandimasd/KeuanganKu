import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import '../../repositories/account_repository.dart';

class DeleteAccountUseCase extends UseCase<void, int> {
  final AccountRepository repository;

  DeleteAccountUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(int params) async {
    return await repository.deleteAccount(params);
  }
}
