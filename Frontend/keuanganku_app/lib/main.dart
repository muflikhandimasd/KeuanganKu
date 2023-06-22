// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:keuanganku_app/app/features/auth/presentation/pages/send_otp_page.dart';
import 'package:keuanganku_app/app/features/global/presentation/cubit/internet_cubit/internet_cubit.dart';
import 'package:keuanganku_app/app/features/main/presentation/cubit/main_cubit.dart';
import 'package:keuanganku_app/app/features/main/presentation/pages/main_page.dart';
import './service_locator.dart' as di;
import 'app/features/auth/presentation/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  Bloc.observer = GlobalObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => di.sl<AuthCubit>()..checkLogin(),
        ),
        BlocProvider<InternetCubit>(
          create: (context) => di.sl<InternetCubit>(),
        ),
        BlocProvider<MainCubit>(
          create: (context) => di.sl<MainCubit>(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      home: _getHomeWidget(),
    );
  }
}

Widget _getHomeWidget() {
  return BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
      if (state.isAuthenticated) {
        FlutterNativeSplash.remove();
        return MainPage();
      } else {
        FlutterNativeSplash.remove();
        return const SendOtpPage();
      }
    },
  );
}

class GlobalObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
