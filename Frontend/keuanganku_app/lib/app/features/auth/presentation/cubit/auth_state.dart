part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final FormzSubmissionStatus formStatus;
  final User? user;
  final String message;
  final RegisterForm registerForm;
  const AuthState({
    

  });

  @override
  List<Object> get props => [];
}
