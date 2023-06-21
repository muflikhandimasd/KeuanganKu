import 'package:flutter/material.dart';
import 'package:keuanganku_app/app/features/auth/presentation/widgets/register/register_address_textfield.dart';

import '../widgets/register/register_email_textfield.dart';
import '../widgets/register/register_name_textfield.dart';
import '../widgets/register/register_phone_textfield.dart';
import '../widgets/register/register_submit_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            RegisterNameTextField(),
            SizedBox(height: 16),
            RegisterEmailTextField(),
            SizedBox(height: 16),
            RegisterAddressTextField(),
            SizedBox(height: 16),
            RegisterPhoneTextField(),
            SizedBox(height: 16),
            RegisterSubmitButton(),
          ],
        ),
      ),
    );
  }
}
