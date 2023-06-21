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
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                const Text(
                  'Enter OTP',
                ),
                const SizedBox(
                  height: 4,
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
                    onChanged: (pin) {
                      print("Changed: " + pin);
                    },
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    }),
                const SizedBox(
                  height: 4,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state.countDownSeconds <= 0) {
                      return TextButton(
                          onPressed: () {
                            context.read<AuthCubit>().coba();
                          },
                          child: Text('Resend OTP'));
                    }
                    if (state.countDownSeconds > 0) {
                      return Text(
                        '${state.countDownSeconds}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 50),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(
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
