import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:keuanganku_app/app/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:keuanganku_app/app/features/auth/presentation/widgets/custom_button.dart';
import 'package:keuanganku_app/app/features/auth/presentation/widgets/custom_text_field.dart';

class SendOtpPage extends StatelessWidget {
  const SendOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                CustomTextField(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomButton(
                  text: 'Send OTP',
                  onPressed: () {
                    context.read<AuthCubit>().coba();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerifyOtpPage(),
                        ));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
