import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/custom_button.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    OtpFieldController otpController = OtpFieldController();

    return Scaffold(
      appBar: AppBar(
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
                Text('Please check your email :\nexample@gmail.com'),
                const SizedBox(
                  height: 16,
                ),
                OTPTextField(
                    controller: otpController,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    style: const TextStyle(fontSize: 17),
                    onChanged: (_) {},
                    onCompleted: (pin) {
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
                CustomButton(
                  text: 'Verify OTP',
                  onPressed: () {},
                ),
              ],
            ),
          )),
    );
  }
}
