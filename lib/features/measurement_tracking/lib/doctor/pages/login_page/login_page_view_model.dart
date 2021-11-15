import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onedosehealth/doctor/notifiers/user_notifiers.dart';
import 'package:onedosehealth/doctor/resources/resources.dart';
import 'package:onedosehealth/doctor/services/network_connection_checker.dart';
import 'package:onedosehealth/doctor/services/user_service.dart';
import 'package:onedosehealth/doctor/utils/gradient_dialog.dart';
import 'package:onedosehealth/doctor/utils/progress/progress_dialog.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';

class LoginPageViewModel extends ChangeNotifier {
  BuildContext _context;
  String _userId, _password;
  ProgressDialog progressDialog;
  String _userIdText, _passwordText;
  LoginPageViewModel({BuildContext context}) {
    this._context = context;
    getUserInfo();
  }
  setPasswordText(String text) {
    this._passwordText = text;
    notifyListeners();
  }

  setUserIdText(String text) {
    this._userIdText = text;
    notifyListeners();
  }

  setUserInfo(String userId, String password) {
    this._userId = userId;
    this._password = password;
    notifyListeners();
  }

  String get userId => this._userId;
  String get password => this._password;
  String get userIdText => this._userIdText;
  String get passwordText => this._passwordText;
  getUserInfo() async {
    await Provider.of<UserNotifiers>(_context, listen: false).getUserInfo();
    this._userId = Provider.of<UserNotifiers>(_context, listen: false).userId;
    this._password =
        Provider.of<UserNotifiers>(_context, listen: false).password;
    this._userIdText =
        Provider.of<UserNotifiers>(_context, listen: false).userId;
    this._passwordText =
        Provider.of<UserNotifiers>(_context, listen: false).password;
    notifyListeners();
  }

  login() async {
    showLoadingDialog();
    await Future.delayed(Duration(milliseconds: 500));
    if (checkUserInfo()) {
      try {
        await Provider.of<UserNotifiers>(_context, listen: false)
            .login(userIdText, passwordText);
        await Provider.of<UserNotifiers>(_context, listen: false).saveUserInfo(
            userIdText,
            passwordText,
            Provider.of<UserNotifiers>(
              _context,
              listen: false,
            ).jwtToken,
            'true');
        await Provider.of<UserNotifiers>(_context, listen: false)
            .addFirebaseToken();
        hideDialog(_context);
        Navigator.pushNamed(_context, Routes.HOME_PAGE);
      } catch (e) {
        hideDialog(_context);
        final error = e.toString();
        if (error.contains(UserService.INVALID_AUTHORIZATION)) {
          showInformationDialog(
              LocaleProvider.of(_context).invalid_authorization);
        } else if (error.contains(HttpStatus.unauthorized.toString())) {
          showInformationDialog(
              LocaleProvider.of(_context).wrong_user_credential);
        } else if (error.contains(NetworkConnectionException.NO_NETWORK)) {
          showInformationDialog(LocaleProvider.of(_context).no_network);
        } else {
          showInformationDialog(
              LocaleProvider.of(_context).sorry_dont_transaction);
        }
      }
    } else {
      hideDialog(_context);
      showInformationDialog(
          LocaleProvider.of(_context).user_login_cannot_blank);
    }
  }

  bool checkUserInfo() {
    bool isCorrect = false;
    if (userIdText.length > 0) {
      if (passwordText.length > 0) {
        isCorrect = true;
      }
    }
    return isCorrect;
  }

  showInformationDialog(String text) {
    showDialog(
        context: _context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        });
  }

  showLoadingDialog() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            progressDialog = progressDialog ?? ProgressDialog());
  }

  hideDialog(BuildContext context) {
    if (progressDialog != null && progressDialog.isShowing()) {
      Navigator.of(context).pop();
      progressDialog = null;
    }
  }
}
