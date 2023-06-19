abstract class Failure {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message = 'Server Error'});
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure({this.message = 'Cache Error'});
}

class NoInternetFailure extends Failure {
  final String message;

  NoInternetFailure({this.message = 'No Internet Connection'});
}
