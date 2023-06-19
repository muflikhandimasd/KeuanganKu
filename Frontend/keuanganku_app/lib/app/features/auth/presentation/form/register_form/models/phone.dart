import 'package:validators/validators.dart';
import 'package:formz/formz.dart';

enum PhoneValidationError { empty, invalid }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.dirty(String value) : super.dirty(value);
  const Phone.pure() : super.pure('');

  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneValidationError.empty;
    } else if (!isNumeric(value)) {
      return PhoneValidationError.invalid;
    } else {
      return null;
    }
  }
}

extension PhoneValidationErrorMessage on PhoneValidationError {
  String get message {
    switch (this) {
      case PhoneValidationError.empty:
        return 'Nomor Telepon tidak boleh kosong';
      case PhoneValidationError.invalid:
        return 'Nomor Telepon tidak valid';
      default:
        return '';
    }
  }
}
