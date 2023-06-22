// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:keuanganku_app/app/core/network_info/network_info.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final NetworkInfo networkInfo;
  InternetCubit(this.networkInfo) : super(InternetInitial()) {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        emit(const InternetNotConnected('No internet connection'));
      } else {
        _checkInternet(result);
      }
    });
  }

  StreamSubscription<ConnectivityResult>? _subscription;

  void _checkInternet(ConnectivityResult result) async {
    if (await networkInfo.isConnected) {
      emit(InternetConnected(result));
    } else {
      emit(const InternetNotConnected('No internet connection'));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
