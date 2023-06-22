import 'package:formz/formz.dart';

import '../register_form/models/email.dart';
import 'models/otp.dart';

class VerifyOTPForm with FormzMixin {
  final Email email;
  final Otp otp;

  const VerifyOTPForm({
    this.email = const Email.pure(),
    this.otp = const Otp.pure(),
  });

  VerifyOTPForm copyWith({
    Email? email,
    Otp? otp,
  }) {
    return VerifyOTPForm(
      email: email ?? this.email,
      otp: otp ?? this.otp,
    );
  }

  @override
  List<FormzInput> get inputs => [
        email,
        otp,
      ];
}
