// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:keuanganku_app/app/core/usecase/usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:keuanganku_app/app/features/auth/presentation/form/verify_otp_form/models/otp.dart';

import '../../domain/entities/user.dart';
import 'package:formz/formz.dart';
import '../../domain/usecases/check_login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../form/register_form/models/address.dart';
import '../form/register_form/models/email.dart';
import '../form/register_form/models/name.dart';
import '../form/register_form/models/phone.dart';
import '../form/register_form/register_form.dart';
import '../form/send_otp_form/send_otp_form.dart';
import '../form/verify_otp_form/verify_otp_form.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final SendOtpUseCase sendOtpUseCase;
  final CheckLoginUseCase checkLoginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  AuthCubit({
    required this.verifyOtpUseCase,
    required this.sendOtpUseCase,
    required this.checkLoginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
  }) : super(const AuthState());

  Timer _timer = Timer.periodic(Duration.zero, (_) {});

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }

  void coba() {
    _startTimer();
  }

  void _startTimer() async {
    emit(state.copyWith(countDownSeconds: 60));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final second = state.countDownSeconds - 1;
      if (second < 0) {
        _timer.cancel();
      } else {
        emit(state.copyWith(countDownSeconds: second));
      }
    });
  }

  void _setEmailOtp(String value) {
    emit(state.copyWith(emailOtp: value));
  }

  void verifyOtpEmailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        verifyOTPForm: state.verifyOTPForm
            .copyWith(email: email, otp: state.verifyOTPForm.otp)));
  }

  void verifyOtpOtpChanged(String value) {
    final otp = Otp.dirty(value);
    emit(state.copyWith(
        verifyOTPForm: state.verifyOTPForm
            .copyWith(email: state.verifyOTPForm.email, otp: otp)));
  }

  void _changeRequestType(RequestType requestType) {
    emit(state.copyWith(requestType: requestType));
  }

  void registerEmailChanged(String value) {
    final email = Email.dirty(value);
    _setEmailOtp(value);
    emit(state.copyWith(
      registerForm: state.registerForm.copyWith(
        email: email,
        address: state.registerForm.address,
        name: state.registerForm.name,
        phone: state.registerForm.phone,
      ),
    ));
  }

  void registerAddressChanged(String value) {
    final address = Address.dirty(value);
    emit(state.copyWith(
      registerForm: state.registerForm.copyWith(
        email: state.registerForm.email,
        address: address,
        name: state.registerForm.name,
        phone: state.registerForm.phone,
      ),
    ));
  }

  void registerNameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      registerForm: state.registerForm.copyWith(
        email: state.registerForm.email,
        address: state.registerForm.address,
        name: name,
        phone: state.registerForm.phone,
      ),
    ));
  }

  void registerPhoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      registerForm: state.registerForm.copyWith(
        email: state.registerForm.email,
        address: state.registerForm.address,
        name: state.registerForm.name,
        phone: phone,
      ),
    ));
  }

  void registerSubmitted() async {
    if (state.registerForm.isValid) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      final result = await registerUseCase(RegisterUseCaseParams(
        email: state.registerForm.email.value,
        address: state.registerForm.address.value,
        name: state.registerForm.name.value,
        phone: state.registerForm.phone.value,
      ));
      result.fold((f) {
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.failure,
          message: f.message,
        ));
      }, (isSuccessRegister) {
        _resetRegisterForm();
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.success,
        ));
      });
    }
  }

  void _resetRegisterForm() {
    emit(state.copyWith(
      registerForm: const RegisterForm(),
    ));
  }

  void sendOTPEmailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      sendOTPForm: state.sendOTPForm.copyWith(
        email: email,
      ),
    ));
  }

  void sendOTPSubmitted() async {
    _changeRequestType(RequestType.sendOtp);
    if (state.sendOTPForm.email.isValid) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      final result = await sendOtpUseCase(SendOtpUseCaseParams(
        email: state.sendOTPForm.email.value,
      ));
      result.fold((f) {
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.failure,
          message: f.message,
        ));
      }, (isSuccessSendOtp) {
        _startTimer();
        _setEmailOtp(state.sendOTPForm.email.value);
        _resetSendOTPForm();
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.success,
        ));
      });
    }
  }

  void _resetSendOTPForm() {
    emit(state.copyWith(
      sendOTPForm: const SendOTPForm(),
    ));
  }

  void checkLogin() async {
    final result = await checkLoginUseCase(const NoParams());
    result.fold((_) {
      return;
    }, (user) {
      if (user != null) {
        if (kDebugMode) {
          log(user.token);
        }
        emit(state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: user,
        ));
      } else {
        return;
      }
    });
  }

  _resetVerifyOTPForm() {
    emit(state.copyWith(
      verifyOTPForm: const VerifyOTPForm(),
    ));
  }

  void verifyOtpSubmitted() async {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
    final result = await verifyOtpUseCase(VerifyOtpUseCaseParams(
      email: state.verifyOTPForm.email.value,
      otp: state.verifyOTPForm.otp.value,
    ));
    result.fold((f) {
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.failure,
        message: f.message,
      ));
    }, (user) {
      _resetVerifyOTPForm();
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.success,
        user: user,
        authStatus: AuthStatus.authenticated,
      ));
    });
  }
}
