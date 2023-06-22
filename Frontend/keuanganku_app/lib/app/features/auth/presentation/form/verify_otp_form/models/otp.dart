import 'package:formz/formz.dart';

enum OtpValidationError { empty, invalid }

class Otp extends FormzInput<String, OtpValidationError> {
  const Otp.dirty(String value) : super.dirty(value);
  const Otp.pure() : super.pure('');

  @override
  OtpValidationError? validator(String value) {
    if (value.isEmpty) {
      return OtpValidationError.empty;
    } else if (value.length < 6) {
      return OtpValidationError.invalid;
    } else {
      return null;
    }
  }
}
