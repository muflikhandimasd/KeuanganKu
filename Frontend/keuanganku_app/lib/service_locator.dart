import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:keuanganku_app/app/core/api_handler/api_handler.dart';
import 'package:keuanganku_app/app/core/secure_storage/secure_storage.dart';
import 'package:keuanganku_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:keuanganku_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:keuanganku_app/app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:keuanganku_app/app/features/auth/presentation/cubit/auth_cubit.dart';

import 'app/core/network_info/network_info.dart';
import 'app/features/auth/data/datasources/auth_local_datasource.dart';
import 'app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'app/features/auth/domain/usecases/logout_usecase.dart';
import 'app/features/auth/domain/usecases/register_usecase.dart';
import 'app/features/auth/domain/usecases/send_otp_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<FlutterSecureStorage>(() =>
      const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true)));
  sl.registerLazySingleton<SecureStorage>(() => SecureStorage(sl()));
  final apiHandler = ApiHandler(Dio(), sl());
  await apiHandler.init();

  sl.registerLazySingleton<ApiHandler>(() => apiHandler);
  // Features - Auth
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiHandler: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(secureStorage: sl()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
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

  // Presentation
  sl.registerFactory(() => AuthCubit(
      verifyOtpUseCase: sl(),
      sendOtpUseCase: sl(),
      checkLoginUseCase: sl(),
      logoutUseCase: sl(),
      registerUseCase: sl()));
}
