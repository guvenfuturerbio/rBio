import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/imports/cronic_tracking.dart';
import '../../../../core/locator.dart';
import '../helper/build_configurations.dart';

class LoginViewModel with ChangeNotifier {
  Future<bool> loginWithEmailPass(String email, String password) async {
    final response = await getIt<ChronicTrackingRepository>().login(
        clientId: BuildConfigurations.CLIENT_ID,
        grantType: "password",
        clientSecret: BuildConfigurations.CLIENT_SECRET,
        scope: "openid",
        username: email,
        password: password);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", email);
    await prefs.setString("password", password);
    await prefs.setString("jwtToken", response.accessToken);
    return true;
  }
}
