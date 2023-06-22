import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/update_account_usecase.dart';

import '../../../../core/failures/failure.dart';
import '../entities/account.dart';
import '../usecases/create_account_usecase.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> deleteAccount(int id);
  Future<Either<Failure, void>> createAccount(String params);
  Future<Either<Failure, void>> updateAccount(
      UpdateAccountUseCaseParams params);
  Future<Either<Failure, List<Account>>> getAccounts(NoParams params);
}
