import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/register_usecase.dart';

import '../../domain/entities/user.dart';
import 'package:formz/formz.dart';
import '../../domain/usecases/check_login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../form/register_form/register_form.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SendOtpUseCase sendOtpUseCase;
  final CheckLoginUseCase checkLoginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  AuthCubit({
    required this.loginUseCase,
    required this.sendOtpUseCase,
    required this.checkLoginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
  }) : super(const AuthState());

  void checkLogin() async {
    emit(const AuthLoading());
    final result = await checkLoginUseCase(const NoParams());
    result.fold((_) {
      emit(const AuthUnauthenticated());
    }, (user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthUnauthenticated());
      }
    });
  }
}
