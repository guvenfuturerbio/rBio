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
  final message =
      'network';
  @override
  String toString() => message;
}