import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHandler with ChangeNotifier {
  static final SharedPreferencesHandler _instance =
      SharedPreferencesHandler._internal();

  factory SharedPreferencesHandler() {
    return _instance;
  }

  SharedPreferencesHandler._internal() {}

  static const String LAST_LOGGED_USER_UID = "LAST_LOGGED_USER_UID";
  static const String LAST_DISPLAY_NAME = "LAST_DISPLAY_NAME";
  static const String LAST_EMAIL = "LAST_EMAIL";

  Future<bool> saveLastLoggedUserUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LAST_LOGGED_USER_UID, uid);
    return true;
  }

  Future<String> getLastLoggedUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString(LAST_LOGGED_USER_UID) ?? "");
  }

  Future<bool> saveLastDisplayName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LAST_DISPLAY_NAME, name);
    return true;
  }

  deleteAutoLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(LAST_DISPLAY_NAME);
    prefs.remove(LAST_EMAIL);
  }

  Future<String> getLastDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString(LAST_DISPLAY_NAME) ?? "");
  }

  Future<bool> saveLastEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LAST_EMAIL, email);
    return true;
  }

  Future<String> getLastEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LAST_EMAIL);
  }
}
