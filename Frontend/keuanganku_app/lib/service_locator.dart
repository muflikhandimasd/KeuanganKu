import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keuanganku_app/app/core/api_handler/api_handler.dart';
import 'package:keuanganku_app/app/core/constants/constant_global.dart';
import 'package:keuanganku_app/app/core/secure_storage/secure_storage.dart';
import 'package:keuanganku_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:keuanganku_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:keuanganku_app/app/features/global/presentation/cubit/internet_cubit/internet_cubit.dart';
import 'package:keuanganku_app/app/features/home/data/datasources/account_remote_datasource.dart';
import 'package:keuanganku_app/app/features/home/data/repositories/account_repository_impl.dart';
import 'package:keuanganku_app/app/features/home/domain/repositories/account_repository.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/account/create_account_usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/account/delete_account_usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/account/get_accounts_usecase.dart';
import 'package:keuanganku_app/app/features/home/domain/usecases/account/update_account_usecase.dart';
import 'package:keuanganku_app/app/features/home/presentation/cubit/account_cubit/account_cubit.dart';
import 'package:keuanganku_app/app/features/main/presentation/cubit/main_cubit.dart';
import 'package:keuanganku_app/app/features/transaction/domain/entities/transaction.dart';

import 'app/core/network_info/network_info.dart';
import 'app/features/auth/data/datasources/auth_local_datasource.dart';
import 'app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'app/features/auth/domain/usecases/logout_usecase.dart';
import 'app/features/auth/domain/usecases/register_usecase.dart';
import 'app/features/auth/domain/usecases/send_otp_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await dotenv.load(fileName: ".env");
  //! External
  await Hive.initFlutter();
  await Hive.openBox<Transaction>(ConstantGlobal.boxTransaction,
      encryptionCipher: HiveAesCipher(Hive.generateSecureKey()));
  Hive.registerAdapter(TransactionAdapter());
  final boxTransaction = Hive.box<Transaction>(ConstantGlobal.boxTransaction);
  sl.registerLazySingleton<Box<Transaction>>(() => boxTransaction);
  // ! External
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<FlutterSecureStorage>(() =>
      const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true)));
  final secure = SecureStorage(sl());
  // await secure.deleteAll();
  sl.registerLazySingleton<SecureStorage>(() => secure);
  final apiHandler = ApiHandler(Dio(), sl());
  await apiHandler.init();

  sl.registerLazySingleton<ApiHandler>(() => apiHandler);
  // Features - Auth
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiHandler: sl<ApiHandler>()..init()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(secureStorage: sl()));

  sl.registerLazySingleton<AccountRemoteDataSource>(
      () => AccountRemoteDataSourceImpl(sl<ApiHandler>()..init()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  // Use cases
  sl.registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(repository: sl()));
  sl.registerLazySingleton<CheckLoginUseCase>(
      () => CheckLoginUseCase(repository: sl()));
  sl.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton<SendOtpUseCase>(
      () => SendOtpUseCase(repository: sl()));
  sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton<GetAccountsUseCase>(() => GetAccountsUseCase(sl()));
  sl.registerLazySingleton<CreateAccountUseCase>(
      () => CreateAccountUseCase(sl()));
  sl.registerLazySingleton<UpdateAccountUseCase>(
      () => UpdateAccountUseCase(sl()));
  sl.registerLazySingleton<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(sl()));

  // Presentation
  sl.registerFactory(() => AuthCubit(
      verifyOtpUseCase: sl(),
      sendOtpUseCase: sl(),
      checkLoginUseCase: sl(),
      logoutUseCase: sl(),
      registerUseCase: sl()));

  sl.registerFactory<InternetCubit>(() => InternetCubit(sl()));
  sl.registerFactory<MainCubit>(() => MainCubit());
  sl.registerFactory<AccountCubit>(() =>
      AccountCubit(getAll: sl(), create: sl(), update: sl(), delete: sl()));
}
