import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase extends UseCase<void, SendOtpUseCaseParams> {
  final AuthRepository repository;

  SendOtpUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(SendOtpUseCaseParams params) async {
    return await repository.sendOtp(params);
  }
}

class SendOtpUseCaseParams extends Equatable {
  final String email;

  const SendOtpUseCaseParams({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  @override
  List<Object?> get props => [email];
}
