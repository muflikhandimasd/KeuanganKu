import 'package:formz/formz.dart';

enum AddressValidationError { empty }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.dirty(String value) : super.dirty(value);
  const Address.pure() : super.pure('');

  @override
  AddressValidationError? validator(String value) {
    if (value.isEmpty) {
      return AddressValidationError.empty;
    } else {
      return null;
    }
  }
}

extension AddressValidationErrorMessage on AddressValidationError {
  String get message {
    switch (this) {
      case AddressValidationError.empty:
        return 'Alamat tidak boleh kosong';

      default:
        return '';
    }
  }
}
