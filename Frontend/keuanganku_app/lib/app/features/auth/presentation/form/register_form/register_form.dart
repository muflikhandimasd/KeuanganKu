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

  const RegisterForm(
      {this.email = const Email.pure(),
      this.address = const Address.pure(),
      this.name = const Name.pure(),
      this.phone = const Phone.pure()});

  RegisterForm copyWith({
    Email? email,
    Address? address,
    Name? name,
    Phone? phone,
  }) {
    return RegisterForm(
      email: email ?? this.email,
      address: address ?? this.address,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<FormzInput> get inputs => [
        email,
        address,
        phone,
        name,
      ];
}
