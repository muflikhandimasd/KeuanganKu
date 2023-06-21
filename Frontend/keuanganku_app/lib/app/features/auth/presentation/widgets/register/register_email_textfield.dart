import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:keuanganku_app/app/features/auth/presentation/form/register_form/models/email.dart';

import '../custom_text_field.dart';

class RegisterEmailTextField extends StatelessWidget {
  const RegisterEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            previous.registerForm.email != current.registerForm.email,
        builder: (context, state) {
          return CustomTextField(
            width: double.infinity,
            hintText: 'Masukkan email',
            keyboardType: TextInputType.emailAddress,
            errorText: state.registerForm.email.isNotValid
                ? state.registerForm.email.error?.message
                : null,
            onChanged: (value) {
              context.read<AuthCubit>().registerEmailChanged(value);
            },
          );
        });
  }
}
