import '../../domain/usecases/create_transaction_usecase.dart';
import '../../domain/usecases/get_transactions_usecase.dart';
import '../../domain/usecases/update_transaction_usecase.dart';
import '../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions(
      GetTransactionsUseCaseParams params);
  Future<void> createTransaction(CreateTransactionUseCaseParams params);

  Future<void> deleteTransaction(int id);
  Future<void> updateTransaction(UpdateTransactionUseCaseParams params);
}
