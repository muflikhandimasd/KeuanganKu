import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/entities/user.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/register_usecase.dart';

import '../usecases/send_otp_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> sendOtp(SendOtpUseCaseParams params);
  Future<Either<Failure, User>> verifyOtp(VerifyOtpUseCaseParams params);
  Future<Either<Failure, void>> register(RegisterUseCaseParams params);
  Future<Either<Failure, void>> logout(NoParams params);
  Future<Either<Failure, User?>> checkLogin(NoParams params);
}
