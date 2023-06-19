import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';

import '../repositories/auth_repository.dart';

class RegisterUseCase extends UseCase<bool, RegisterUseCaseParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(RegisterUseCaseParams params) async {
    return await repository.register(params);
  }
}

class RegisterUseCaseParams extends Equatable {
  final String email;
  final String name;
  final String phone;
  final String address;

  const RegisterUseCaseParams(
      {required this.email,
      required this.name,
      required this.phone,
      required this.address});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
    };
  }

  @override
  List<Object?> get props => [email, name, phone, address];
}
