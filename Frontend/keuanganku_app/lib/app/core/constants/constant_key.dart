import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConstantKey {
  ConstantKey._();
  static final String keyToken = dotenv.env['SECRET_KEY_TOKEN'] ?? '__token__';
  static final String keyUser = dotenv.env['SECRET_KEY_USER'] ?? '__user__';
}
