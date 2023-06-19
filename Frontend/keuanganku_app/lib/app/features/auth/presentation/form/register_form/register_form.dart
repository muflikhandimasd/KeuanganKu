import 'package:formz/formz.dart';
import 'package:keuanganku_app/app/features/auth/presentation/form/register_form/models/email.dart';

import 'models/address.dart';
import 'models/name.dart';
import 'models/phone.dart';

class RegisterForm with FormzMixin {
  final Email email;
  final Address address;
  final Name name;
  final Phone phone;

  RegisterForm(
      {this.email = const Email.pure(),
      this.address = const Address.pure(),
      this.name = const Name.pure(),
      this.phone = const Phone.pure()});

  @override
  List<FormzInput> get inputs => [
        email,
        address,
        phone,
        name,
      ];
}
