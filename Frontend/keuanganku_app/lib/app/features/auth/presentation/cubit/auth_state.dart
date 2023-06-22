part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

enum RequestType { sendOtp, verifyOtp, register, logout, initial }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final FormzSubmissionStatus formStatus;
  final User? user;
  final String message;
  final RegisterForm registerForm;
  final SendOTPForm sendOTPForm;
  final int countDownSeconds;
  final String emailOtp;
  final VerifyOTPForm verifyOTPForm;
  final RequestType requestType;

  bool get isAuthenticated => authStatus == AuthStatus.authenticated;

  const AuthState({
    this.authStatus = AuthStatus.unauthenticated,
    this.formStatus = FormzSubmissionStatus.initial,
    this.user,
    this.message = '',
    this.registerForm = const RegisterForm(),
    this.sendOTPForm = const SendOTPForm(),
    this.countDownSeconds = 60,
    this.emailOtp = '',
    this.verifyOTPForm = const VerifyOTPForm(),
    this.requestType = RequestType.initial,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    FormzSubmissionStatus? formStatus,
    User? user,
    String? message,
    RegisterForm? registerForm,
    SendOTPForm? sendOTPForm,
    int? countDownSeconds,
    String? emailOtp,
    VerifyOTPForm? verifyOTPForm,
    RequestType? requestType,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      formStatus: formStatus ?? this.formStatus,
      user: user ?? this.user,
      message: message ?? this.message,
      registerForm: registerForm ?? this.registerForm,
      sendOTPForm: sendOTPForm ?? this.sendOTPForm,
      countDownSeconds: countDownSeconds ?? this.countDownSeconds,
      emailOtp: emailOtp ?? this.emailOtp,
      verifyOTPForm: verifyOTPForm ?? this.verifyOTPForm,
      requestType: requestType ?? this.requestType,
    );
  }

  @override
  List<Object?> get props => [
        authStatus,
        formStatus,
        user,
        message,
        registerForm,
        sendOTPForm,
        countDownSeconds,
        emailOtp,
        verifyOTPForm,
        requestType,
      ];
}

extension RequestTypeX on RequestType {
  bool get isSendOtp => this == RequestType.sendOtp;
  bool get isVerifyOtp => this == RequestType.verifyOtp;
  bool get isRegister => this == RequestType.register;
  bool get isLogout => this == RequestType.logout;
  bool get isInitial => this == RequestType.initial;
}
