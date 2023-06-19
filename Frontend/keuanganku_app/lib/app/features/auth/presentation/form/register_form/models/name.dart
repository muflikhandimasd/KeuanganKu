import 'package:formz/formz.dart';

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.dirty(String value) : super.dirty(value);
  const Name.pure() : super.pure('');

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    } else {
      return null;
    }
  }
}

extension NameValidationErrorMessage on NameValidationError {
  String get message {
    switch (this) {
      case NameValidationError.empty:
        return 'Nama tidak boleh kosong';

      default:
        return '';
    }
  }
}
