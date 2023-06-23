import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keuanganku_app/app/core/utils/utils.dart';
import 'package:keuanganku_app/app/features/home/presentation/cubit/account_cubit/account_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Column(
          children: [
            BlocConsumer<AccountCubit, AccountState>(
              listener: (context, state) {
                if (state is AccountError) {
                  Utils.showErrorMessage(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is AccountLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AccountLoaded) {
                  return DropdownButtonFormField(
                      items: state.accounts
                          .map((e) => DropdownMenuItem(
                              value: e.id, child: Text(e.name)))
                          .toList(),
                      onChanged: (value) {
                        if (kDebugMode) {
                          log('value: $value');
                        }
                      });
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ));
  }
}
