import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:keuanganku_app/app/features/auth/presentation/form/register_form/models/phone.dart';

import '../custom_text_field.dart';

class RegisterPhoneTextField extends StatelessWidget {
  const RegisterPhoneTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            previous.registerForm.phone != current.registerForm.phone,
        builder: (context, state) {
          return CustomTextField(
            width: double.infinity,
            hintText: 'Masukkan Phone',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            errorText: state.registerForm.phone.isNotValid
                ? state.registerForm.phone.error?.message
                : null,
            onChanged: (value) {
              context.read<AuthCubit>().registerPhoneChanged(value);
            },
          );
        });
  }
}
