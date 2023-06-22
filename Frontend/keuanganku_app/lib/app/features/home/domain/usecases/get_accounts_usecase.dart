import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import '../entities/account.dart';
import '../repositories/home_repository.dart';

class GetAccountsUseCase extends UseCase<List<Account>, NoParams> {
  final HomeRepository repository;
  GetAccountsUseCase(this.repository);
  @override
  Future<Either<Failure, List<Account>>> call(NoParams params) async {
    return await repository.getAccounts(params);
  }
}
