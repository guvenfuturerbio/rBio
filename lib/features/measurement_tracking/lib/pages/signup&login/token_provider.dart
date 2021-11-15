import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';

import 'login_provider.dart';

class TokenProvider with ChangeNotifier {
  static final TokenProvider _instance = TokenProvider._internal();
  factory TokenProvider() {
    return _instance;
  }

  TokenProvider._internal() {}

  String _authToken = "";
  String get authToken => _authToken;

  Future<String> acquireAuthToken(String username, String password) async {
    final response = await getToken(username, password);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      this._authToken = responseBody['access_token'];
      notifyListeners();
      return this._authToken;
    } else {
      throw Exception('acquireAuthToken');
    }
  }

  Future<Response> getToken(String username, String password) async {
    LoginProvider _loginProvider = LoginProvider.create();
    return _loginProvider.loginUi(
        "OneDoseLocalExternal" /*"CerebrumPlusProductionExternal"*/,
        "password",
        "9b00c5fc-a38c-463b-9b2e-20b88884c0f6" /*"87702b40-56f5-458e-b3f6-d24d09727dbc"*/,
        "openid",
        "31909548256",
        "123");
  }

  void setAuthToken(String token) {
    this._authToken = token;
    notifyListeners();
  }
}
