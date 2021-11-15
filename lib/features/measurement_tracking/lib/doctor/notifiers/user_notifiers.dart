import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../helper/jwt_token_parser.dart';
import '../models/login_response.dart';
import '../services/user_service.dart';

class UserNotifiers extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  static String USER_ID = "USER_ID";
  // ignore: non_constant_identifier_names
  static String PASSWORD = "PASSWORD";
  // ignore: non_constant_identifier_names
  static String JWT_TOKEN = "JWT_TOKEN";

  // ignore: non_constant_identifier_names
  static String IS_DOCTOR = "IS_DOCTOR";

  String _userId, _password, _jwtToken, _userName, _isDoctor;
  LoginResponse _loginResponse;
  final storage = new FlutterSecureStorage();

  setUserId(String userId) {
    this._userId = userId;
    notifyListeners();
  }

  setIsDoctor(String val) {
    this._isDoctor = val;
    notifyListeners();
  }

  setPassword(String password) {
    this._password = password;
    notifyListeners();
  }

  setJwtToken(String jwtToken) {
    this._jwtToken = jwtToken;
    notifyListeners();
  }

  String get userId => this._userId;

  String get password => this._password;

  String get jwtToken => this._jwtToken;

  String get userName => this._userName;

  String get isDoctor => this._isDoctor;

  login(String userId, String password) async {
    this._loginResponse = await UserService().login(userId, password);
    this._userId = userId;
    this._password = password;
    this._jwtToken = loginResponse.accessToken;
    this._userName = parseJwtPayLoad(loginResponse.accessToken)['name'] ??
        parseJwtPayLoad(loginResponse.accessToken)['fullname'];
    notifyListeners();
  }

  addFirebaseToken() async {
    await UserService().addFirebaseToken();
    notifyListeners();
  }

  LoginResponse get loginResponse => this._loginResponse;

  saveUserInfo(
      String userId, String password, String jwtToken, String isDoctor) async {
    await storage.write(key: USER_ID, value: userId);
    await storage.write(key: PASSWORD, value: password);
    await storage.write(key: JWT_TOKEN, value: jwtToken);
    await storage.write(key: IS_DOCTOR, value: isDoctor);
  }

  getUserInfo() async {
    this._userId = await storage.read(key: USER_ID);
    this._password = await storage.read(key: PASSWORD);
    this._jwtToken = await storage.read(key: JWT_TOKEN);
    this._isDoctor = await storage.read(key: IS_DOCTOR);
    notifyListeners();
  }

  deleteData() async {
    await storage.delete(key: USER_ID);
    await storage.delete(key: PASSWORD);
    await storage.delete(key: JWT_TOKEN);
    await storage.delete(key: IS_DOCTOR);
  }
}
