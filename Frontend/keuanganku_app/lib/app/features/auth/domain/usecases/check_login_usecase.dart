import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/entities/user.dart';
import '../repositories/auth_repository.dart';

class CheckLoginUseCase extends UseCase<User?, NoParams> {
  final AuthRepository repository;

  CheckLoginUseCase({required this.repository});
  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.checkLogin(params);
  }
}
