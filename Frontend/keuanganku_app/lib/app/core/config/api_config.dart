// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  ApiConfig._();

  static final String BASE_URL = dotenv.env['BASE_URL'] ?? "";
  static const String VERIFY_OTP = "/verify-otp";
  static const String REGISTER = "/register";
  static const String SEND_OTP = "/send-otp";
  static const String LOGOUT = "/logout";
  static const String ACCOUNT = "/accounts";
}
