import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    final result = await InternetAddress.lookup('example.com');
    final isInternetAvailable =
        result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    return isInternetAvailable;
  }
}
