import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import '../repositories/home_repository.dart';

class CreateAccountUseCase extends UseCase<void, String> {
  final HomeRepository repository;

  CreateAccountUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.createAccount(params);
  }
}
