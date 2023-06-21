// ignore_for_file: overridden_fields

abstract class Failure {
  final String message;

  Failure({this.message = 'Unexpected Error'});
}

class ServerFailure extends Failure {
  @override
  final String message;

  ServerFailure({this.message = 'Server Error'});
}

class CacheFailure extends Failure {
  @override
  final String message;

  CacheFailure({this.message = 'Cache Error'});
}

class NoInternetFailure extends Failure {
  @override
  final String message;

  NoInternetFailure({this.message = 'No Internet Connection'});
}
