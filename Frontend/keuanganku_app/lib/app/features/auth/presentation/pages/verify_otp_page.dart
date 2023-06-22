import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:keuanganku_app/app/core/utils/utils.dart';
import 'package:keuanganku_app/app/features/main/presentation/pages/main_page.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../cubit/auth_cubit.dart';

class VerifyOtpPage extends StatelessWidget {
  final String email;
  const VerifyOtpPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          (previous.formStatus != current.formStatus) &&
          (previous.requestType.isVerifyOtp && current.requestType.isVerifyOtp),
      listener: (context, state) {
        if (state.requestType.isVerifyOtp) {
          if (state.formStatus.isInProgress) {
            Utils.showLoadingDialog(context);
          }
          if (state.formStatus.isSuccess) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => MainPage()), (_) => false);
          }
          if (state.formStatus.isFailure) {
            Navigator.of(context).pop();
            Utils.showErrorMessage(context, state.message);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Verify OTP'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Text('Please check your email :\n$email'),
                  const SizedBox(
                    height: 16,
                  ),
                  OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      onChanged: (_) {},
                      onCompleted: (pin) {
                        context.read<AuthCubit>().verifyOtpOtpChanged(pin);
                        context.read<AuthCubit>().verifyOtpSubmitted();

                        if (kDebugMode) {
                          print("Completed: $pin");
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state.countDownSeconds <= 0) {
                          return InkWell(
                            onTap: context.read<AuthCubit>().coba,
                            child: Text(
                              'Resend OTP',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          );
                        }
                        if (state.countDownSeconds > 0) {
                          return Text.rich(
                            TextSpan(
                              text: 'Resend OTP available in ',
                              children: [
                                TextSpan(
                                  text: '${state.countDownSeconds}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(text: ' seconds'),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
