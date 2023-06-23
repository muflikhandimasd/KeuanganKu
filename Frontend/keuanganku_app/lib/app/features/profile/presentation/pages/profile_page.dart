import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:keuanganku_app/app/core/utils/utils.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:keuanganku_app/app/features/auth/presentation/pages/send_otp_page.dart';
import 'package:keuanganku_app/app/features/auth/presentation/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.requestType.isLogout) {
          if (state.formStatus.isSuccess) {
            Utils.showLoadingDialog(context);
          }
          if (state.formStatus.isFailure) {
            Navigator.of(context).pop();
            Utils.showErrorMessage(context, state.message);
          }
          if (state.formStatus.isSuccess) {
            Navigator.of(context).pop();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const SendOtpPage(),
                ),
                (Route<dynamic> route) => false);
          }
        }
      },
      child: Scaffold(
        body: Center(
            child: CustomButton(
          text: 'Logout',
          onPressed: () {
            context.read<AuthCubit>().changeRequestType(RequestType.logout);
            context.read<AuthCubit>().logout();
          },
        )),
      ),
    );
  }
}
