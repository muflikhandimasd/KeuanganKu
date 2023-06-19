import 'package:dartz/dartz.dart';
import 'package:keuanganku_app/app/core/failures/failure.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/entities/user.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/register_usecase.dart';

import '../usecases/send_otp_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> sendOtp(SendOtpUseCaseParams params);
  Future<Either<Failure, User>> login(LoginUseCaseParams params);
  Future<Either<Failure, bool>> register(RegisterUseCaseParams params);
  Future<Either<Failure, bool>> logout(NoParams params);
  Future<Either<Failure, User?>> checkLogin(NoParams params);
}
