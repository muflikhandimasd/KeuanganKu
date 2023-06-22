import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import '../repositories/home_repository.dart';

class DeleteAccountUseCase extends UseCase<void, int> {
  final HomeRepository repository;

  DeleteAccountUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(int params) async {
    return await repository.deleteAccount(params);
  }
}
