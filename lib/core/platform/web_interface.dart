import 'dart:ui' as ui;

import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';

class MobileWebInterface {
  static void registerViewFactory(String viewId, dynamic cb) {
    ui.platformViewRegistry.registerViewFactory(viewId, cb);
  
  }

  static HttpClientAdapter getAdapter() {
    return BrowserHttpClientAdapter();
  }

  static HttpClientAdapter onHttpClientCreate(
      HttpClientAdapter httpClientAdapter) {
    return null;
  }
}
