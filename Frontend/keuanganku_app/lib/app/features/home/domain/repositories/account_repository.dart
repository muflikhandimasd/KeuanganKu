import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/account/update_account_usecase.dart';

import '../../../../core/failures/failure.dart';
import '../entities/account.dart';

abstract class AccountRepository {
  Future<Either<Failure, void>> deleteAccount(int id);
  Future<Either<Failure, void>> createAccount(String params);
  Future<Either<Failure, void>> updateAccount(
      UpdateAccountUseCaseParams params);
  Future<Either<Failure, List<Account>>> getAccounts(NoParams params);
}
