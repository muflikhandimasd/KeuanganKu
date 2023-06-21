import 'package:formz/formz.dart';

import '../register_form/models/email.dart';

class SendOTPForm with FormzMixin {
  final Email email;

  const SendOTPForm({
    this.email = const Email.pure(),
  });

  SendOTPForm copyWith({
    Email? email,
  }) {
    return SendOTPForm(
      email: email ?? this.email,
    );
  }

  @override
  List<FormzInput> get inputs => [
        email,
      ];
}
