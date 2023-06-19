import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class LoginUseCase extends UseCase<User, LoginUseCaseParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});
  @override
  Future<Either<Failure, User>> call(LoginUseCaseParams params) async {
    return await repository.login(params);
  }
}

class LoginUseCaseParams extends Equatable {
  final String email;
  final String otp;

  const LoginUseCaseParams({required this.email, required this.otp});

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };

  @override
  List<Object?> get props => [email, otp];
}
