import 'package:validators/validators.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.dirty(String value) : super.dirty(value);
  const Email.pure() : super.pure('');

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    } else if (!isEmail(value)) {
      return EmailValidationError.invalid;
    } else {
      return null;
    }
  }
}

extension EmailValidationErrorMessage on EmailValidationError {
  String get message {
    switch (this) {
      case EmailValidationError.empty:
        return 'Email tidak boleh kosong';
      case EmailValidationError.invalid:
        return 'Email tidak valid';
      default:
        return '';
    }
  }
}
