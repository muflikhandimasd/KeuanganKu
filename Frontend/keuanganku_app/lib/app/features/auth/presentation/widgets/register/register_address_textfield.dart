import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:keuanganku_app/app/features/auth/presentation/form/register_form/models/address.dart';

import '../custom_text_field.dart';

class RegisterAddressTextField extends StatelessWidget {
  const RegisterAddressTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            previous.registerForm.address != current.registerForm.address,
        builder: (context, state) {
          return CustomTextField(
            width: double.infinity,
            hintText: 'Masukkan Address',
            keyboardType: TextInputType.streetAddress,
            errorText: state.registerForm.address.isNotValid
                ? state.registerForm.address.error?.message
                : null,
            onChanged: (value) {
              context.read<AuthCubit>().registerAddressChanged(value);
            },
          );
        });
  }
}
