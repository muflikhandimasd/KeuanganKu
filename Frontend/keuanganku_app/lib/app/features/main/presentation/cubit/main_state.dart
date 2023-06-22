part of 'main_cubit.dart';

class MainState extends Equatable {
  final int pageIndex;
  const MainState({this.pageIndex = 0});

  MainState copyWith({
    int? pageIndex,
  }) =>
      MainState(pageIndex: pageIndex ?? this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}
