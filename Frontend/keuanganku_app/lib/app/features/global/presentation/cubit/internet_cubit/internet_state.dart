part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectivityResult result;

  const InternetConnected(this.result);

  @override
  // TODO: implement props
  List<Object> get props => [result];
}

class InternetNotConnected extends InternetState {
  final String message;

  const InternetNotConnected(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
