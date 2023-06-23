import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.accountId,
    required super.type,
    required super.amount,
    required super.date,
    required super.description,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        accountId: json['account_id'],
        type: json['type'],
        amount: json['amount'],
        date: json['date'],
        description: json['description'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  factory TransactionModel.fromEntity(Transaction transaction) =>
      TransactionModel(
        id: transaction.id,
        accountId: transaction.accountId,
        type: transaction.type,
        amount: transaction.amount,
        date: transaction.date,
        description: transaction.description,
        createdAt: transaction.createdAt,
        updatedAt: transaction.updatedAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'account_id': accountId,
        'type': type,
        'amount': amount,
        'date': date,
        'description': description,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
