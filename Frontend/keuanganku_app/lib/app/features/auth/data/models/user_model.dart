import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.email,
      required super.name,
      required super.phone,
      required super.address,
      required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      token: json['token'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'phone': phone,
        'address': address,
        'token': token,
      };

  @override
  List<Object?> get props => [id, email, name, phone, address, token];
}
