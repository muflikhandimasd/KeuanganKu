import 'package:hive_flutter/hive_flutter.dart';
part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String accountId;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final String amount;
  @HiveField(4)
  final String date;
  @HiveField(5)
  final String? description;
  @HiveField(6)
  final String createdAt;
  @HiveField(7)
  final String updatedAt;

  Transaction({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}
