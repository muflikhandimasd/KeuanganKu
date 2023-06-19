import 'package:equatable/equatable.dart';

abstract class User extends Equatable {
  final int id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.token,
  });

  Map<String, dynamic> toJson();
}
