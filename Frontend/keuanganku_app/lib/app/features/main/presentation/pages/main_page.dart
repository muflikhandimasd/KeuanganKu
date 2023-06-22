import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keuanganku_app/app/features/home/presentation/pages/home_page.dart';
import 'package:keuanganku_app/app/features/main/presentation/cubit/main_cubit.dart';
import 'package:keuanganku_app/app/features/profile/presentation/pages/profile_page.dart';
import 'package:keuanganku_app/app/features/transaction/presentation/pages/transaction_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final List<Widget> pages = [
    const HomePage(),
    const TransactionPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: pages.elementAt(state.pageIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.pageIndex,
            onTap: (value) {
              debugPrint(value.toString());
              context.read<MainCubit>().changePage(value);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded), label: ''),
            ],
          ),
        );
      },
    );
  }
}
