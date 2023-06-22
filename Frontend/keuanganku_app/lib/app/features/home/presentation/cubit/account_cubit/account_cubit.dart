import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/create_account_usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/delete_account_usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/get_accounts_usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/update_account_usecase.dart';

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
}
