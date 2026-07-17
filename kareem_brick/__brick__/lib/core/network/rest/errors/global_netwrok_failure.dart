import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkHelper {
  NetworkHelper() : _isConnected = true {
    onStatusChange.listen((state) {
      _isConnected = state;
    });
  }
  bool _isConnected;
  bool get isConnected => _isConnected;

  Stream<bool> get onStatusChange {
    return InternetConnection().onStatusChange.map((status) {
      return status == InternetStatus.connected;
    });
  }
}
