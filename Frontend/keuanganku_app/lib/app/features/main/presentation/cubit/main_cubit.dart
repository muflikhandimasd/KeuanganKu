// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void changePage(int index) {
    emit(state.copyWith(pageIndex: index));
  }
}
