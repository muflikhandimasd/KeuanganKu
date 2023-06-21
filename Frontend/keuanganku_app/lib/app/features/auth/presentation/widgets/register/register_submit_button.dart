import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:keuanganku_app/app/features/auth/presentation/widgets/custom_button.dart';

class RegisterSubmitButton extends StatelessWidget {
  const RegisterSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.registerForm != current.registerForm,
      builder: (context, state) => CustomButton(
          text: 'Register',
          color: state.registerForm.isValid
              ? Theme.of(context).primaryColor
              : Colors.grey,
          textColor: state.registerForm.isValid
              ? Colors.grey.withOpacity(0.4)
              : Colors.white,
          onPressed: state.registerForm.isValid
              ? context.read<AuthCubit>().registerSubmitted
              : null),
    );
  }
}
