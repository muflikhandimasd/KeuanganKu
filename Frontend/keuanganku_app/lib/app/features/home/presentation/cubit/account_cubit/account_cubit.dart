import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/account/create_account_usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/account/delete_account_usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/account/get_accounts_usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/account/update_account_usecase.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/account.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final GetAccountsUseCase getAll;
  final CreateAccountUseCase create;
  final UpdateAccountUseCase update;
  final DeleteAccountUseCase delete;
  AccountCubit({
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(AccountInitial());

  void getAccounts() async {
    emit(AccountLoading());
    final result = await getAll(const NoParams());
    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (accounts) => emit(AccountLoaded(accounts)),
    );
  }

  void createAccount(String name) async {
    emit(AccountLoading());
    final result = await create(name);
    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (_) => getAccounts(),
    );
  }

  void updateAccount(int id, String name) async {
    emit(AccountLoading());
    final result = await update(UpdateAccountUseCaseParams(id: id, name: name));
    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (_) => getAccounts(),
    );
  }

  void deleteAccount(int id) async {
    emit(AccountLoading());
    final result = await delete(id);
    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (_) => getAccounts(),
    );
  }
}
