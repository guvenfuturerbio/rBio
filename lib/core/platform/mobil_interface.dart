import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class MobileWebInterface {
  static void registerViewFactory(String viewId, dynamic cb) {}

  static HttpClientAdapter getAdapter() {
    return DefaultHttpClientAdapter();
  }

  static HttpClientAdapter onHttpClientCreate(
      HttpClientAdapter httpClientAdapter) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return httpClientAdapter;
  }
}
