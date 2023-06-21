part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final FormzSubmissionStatus formStatus;
  final User? user;
  final String message;
  final RegisterForm registerForm;
  final SendOTPForm sendOTPForm;
  final int countDownSeconds;
  final String emailOtp;

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
      ];
}
