import '../../domain/entities/account.dart';

class AccountModel extends Account {
  AccountModel({
    required super.id,
    required super.userId,
    required super.name,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
      };
}
