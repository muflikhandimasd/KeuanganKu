import 'package:keuanganku_app/app/core/exceptions/exception.dart';
import 'package:keuanganku_app/app/features/transaction/data/models/transaction_model.dart';
import 'package:hive/hive.dart';
import 'package:keuanganku_app/app/features/transaction/domain/usecases/update_transaction_usecase.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/usecases/get_transactions_usecase.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getCachedTransactions(
      GetTransactionsUseCaseParams params);
  Future<void> cacheTransactions(List<TransactionModel> transactions);
  Future<void> deleteCachedTransactions();

  Future<void> deleteTransaction(int id);
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final Box<Transaction> box;

  TransactionLocalDataSourceImpl(this.box);

  @override
  Future<List<TransactionModel>> getCachedTransactions(
      GetTransactionsUseCaseParams params) async {
    try {
      await box.clear();
      final List<TransactionModel> transactions = [];
      final values =
          box.values.where((element) => element.accountId == params.accountId);
      for (final transaction in values) {
        transactions.add(TransactionModel.fromEntity(transaction));
      }
      return transactions;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> cacheTransactions(List<TransactionModel> transactions) async {
    try {
      for (final transaction in transactions) {
        await box.put(transaction.id, transaction);
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> deleteCachedTransactions() async {
    try {
      await box.clear();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> deleteTransaction(int id) async {
    try {
      await box.delete(id);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> updateTransaction(UpdateTransactionUseCaseParams params) async {
    try {
      await box.put(params.id, params);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
