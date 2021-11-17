import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/build_configurations.dart';
import 'login_response.dart';
import 'onedose_sso_service.dart';

class LoginViewModel with ChangeNotifier {
  Future<bool> loginWithEmailPass(String email, String password) async {
    final Response response = await ODSsoService.create().login(
        clientId: BuildConfigurations.CLIENT_ID,
        grantType: "password",
        clientSecret: BuildConfigurations.CLIENT_SECRET,
        scope: "openid",
        username: email,
        password: password);

    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      final LoginResponse _login = LoginResponse.fromJson(responseBody);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", email);
      prefs.setString("password", password);
      prefs.setString("jwtToken", _login.accessToken);
      return true;
    } else
      return false;
  }
}
