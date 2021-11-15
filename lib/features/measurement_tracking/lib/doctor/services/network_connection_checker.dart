import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:connectivity/connectivity.dart';

class NetworkConnectionChecker implements RequestInterceptor{
  @override
  FutureOr<Request> onRequest(Request request) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isConnectionNone = connectivityResult == ConnectivityResult.none;
    if (isConnectionNone) {
      throw NetworkConnectionException();
    }
    return request;
  }
}

class NetworkConnectionException implements Exception {
  // ignore: non_constant_identifier_names
  static String NO_NETWORK = "no_network";
  final message = NO_NETWORK;
  @override
  String toString() => message;
}