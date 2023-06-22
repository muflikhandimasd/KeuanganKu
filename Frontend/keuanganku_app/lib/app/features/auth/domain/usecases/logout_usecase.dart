import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout(params);
  }
}
