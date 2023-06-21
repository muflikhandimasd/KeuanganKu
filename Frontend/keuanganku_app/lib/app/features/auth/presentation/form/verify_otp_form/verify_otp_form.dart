import 'package:formz/formz.dart';

import '../register_form/models/email.dart';

class VerifyOTPForm with FormzMixin {
  final Email email;

  const VerifyOTPForm({
    this.email = const Email.pure(),
  });

  VerifyOTPForm copyWith({
    Email? email,
  }) {
    return VerifyOTPForm(
      email: email ?? this.email,
    );
  }

  @override
  List<FormzInput> get inputs => [
        email,
      ];
}
