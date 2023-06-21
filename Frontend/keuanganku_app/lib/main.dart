import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:keuanganku_app/app/features/auth/presentation/pages/send_otp_page.dart';
import './service_locator.dart' as di;
import 'app/features/auth/presentation/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
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
      ],
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (_, state) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Montserrat',
          ),
          debugShowCheckedModeBanner: false,
          home: _getHomeWidget(state),
        );
      },
    );
  }
}

Widget _getHomeWidget(AuthState state) {
  FlutterNativeSplash.remove();
  if (state.isAuthenticated) {
    return const Scaffold(
      body: Center(
        child: Text('Authenticated'),
      ),
    );
  } else {
    return const SendOtpPage();
  }
}
