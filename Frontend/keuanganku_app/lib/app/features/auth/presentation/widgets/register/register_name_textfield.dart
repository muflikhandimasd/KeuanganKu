import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:keuanganku_app/app/features/auth/presentation/form/register_form/models/name.dart';

import '../custom_text_field.dart';

class RegisterNameTextField extends StatelessWidget {
  const RegisterNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            previous.registerForm.name != current.registerForm.name,
        builder: (context, state) {
          return CustomTextField(
            width: double.infinity,
            hintText: 'Masukkan name',
            keyboardType: TextInputType.name,
            errorText: state.registerForm.name.isNotValid
                ? state.registerForm.name.error?.message
                : null,
            onChanged: (value) {
              context.read<AuthCubit>().registerNameChanged(value);
            },
          );
        });
  }
}
