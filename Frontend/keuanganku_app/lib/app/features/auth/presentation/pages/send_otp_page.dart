import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:keuanganku_app/app/features/auth/presentation/form/register_form/models/email.dart';
import 'package:keuanganku_app/app/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:keuanganku_app/app/features/auth/presentation/widgets/custom_button.dart';
import 'package:keuanganku_app/app/features/auth/presentation/widgets/custom_text_field.dart';

import '../../../../core/utils/utils.dart';

class SendOtpPage extends StatelessWidget {
  const SendOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.formStatus != current.formStatus,
      listener: (context, state) {
        if (state.requestType.isSendOtp) {
          if (state.formStatus.isSuccess) {
            context.read<AuthCubit>().verifyOtpEmailChanged(state.emailOtp);
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => VerifyOtpPage(
                      email: state.emailOtp,
                    )));
          }
          if (state.formStatus.isInProgress) {
            Utils.showLoadingDialog(context);
          }

          if (state.formStatus.isFailure) {
            Navigator.of(context).pop();
            Utils.showErrorMessage(context, state.message);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Send OTP'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        previous.sendOTPForm.email != current.sendOTPForm.email,
                    builder: (context, state) {
                      return CustomTextField(
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        errorText: state.sendOTPForm.email.isNotValid
                            ? state.sendOTPForm.email.error?.message
                            : null,
                        onChanged: (value) {
                          if (kDebugMode) {
                            print(value);
                          }
                          context.read<AuthCubit>().sendOTPEmailChanged(value);
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomButton(
                    text: 'Send OTP',
                    color: context.watch<AuthCubit>().state.sendOTPForm.isValid
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    onPressed:
                        context.watch<AuthCubit>().state.sendOTPForm.isValid
                            ? () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                context.read<AuthCubit>().sendOTPSubmitted();
                              }
                            : null,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
