import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/home/home_page_new/home_page_new.dart';
import 'package:provider/provider.dart';

import '../../../doctor/notifiers/user_notifiers.dart';
import '../../../doctor/services/network_connection_checker.dart';
import '../../../doctor/utils/gradient_dialog.dart';
import '../../../doctor/utils/progress/progress_dialog.dart';
import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../services/user_service.dart';
import '../../home/home_page/home_page_view.dart';
import 'doctor_checker.dart';

class EmailLoginPageVm extends ChangeNotifier {
  BuildContext mContext;
  ProgressDialog progressDialog;
  static String INVALID_AUTHORIZATION = "invalid_authorization";
  EmailLoginPageVm({BuildContext context}) {
    this.mContext = context;
  }

  /// MG1
  signIn(String eMail, String password, {bool fromSignup = false}) async {
    if (checkUserInfo(eMail, password)) {
      if (!isEmail(eMail)) {
        await doctorLogin(eMail, password);
      } else {
        patientLogin(eMail, password);
      }
    } else {
      hideDialog(mContext);
      showInformationDialog(
          LocaleProvider.of(mContext).user_login_cannot_blank);
    }
  }

  bool isEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  doctorLogin(String eMail, String password) async {
    showLoadingDialog();
    await Future.delayed(Duration(milliseconds: 500));
    try {
      await Provider.of<UserNotifiers>(mContext, listen: false)
          .login(eMail, password);
      await Provider.of<UserNotifiers>(mContext, listen: false).saveUserInfo(
          eMail,
          password,
          Provider.of<UserNotifiers>(mContext, listen: false).jwtToken,
          'true');
      await Provider.of<UserNotifiers>(mContext, listen: false)
          .addFirebaseToken();
      hideDialog(mContext);
      DoctorChecker().doctor = true;
      Navigator.pushNamed(mContext, Routes.DOCTOR_HOME_PAGE);
    } catch (e) {
      hideDialog(mContext);
      final error = e.toString();
      if (error.contains(INVALID_AUTHORIZATION)) {
        showInformationDialog(
            LocaleProvider.of(mContext).invalid_authorization);
      } else if (error.contains(HttpStatus.unauthorized.toString())) {
        showInformationDialog(
            LocaleProvider.of(mContext).wrong_user_credential);
      } else if (error.contains(NetworkConnectionException.NO_NETWORK)) {
        showInformationDialog(LocaleProvider.of(mContext).no_network);
      } else {
        showInformationDialog(
            LocaleProvider.of(mContext).sorry_dont_transaction);
      }
    }
  }

  patientLogin(String eMail, String password) async {
    showLoadingDialog();
    await Future.delayed(Duration(milliseconds: 500));
    try {
      UserCredential userCredential = await UserService()
          .signInWithEmailAndPasswordFirebase(eMail, password);
      await UserService()
          .saveAndRetrieveToken(userCredential.user, 'patientLogin');
      DoctorChecker().doctor = false;
      await Provider.of<UserNotifiers>(mContext, listen: false).saveUserInfo(
          eMail,
          password,
          Provider.of<UserNotifiers>(mContext, listen: false).jwtToken,
          'false');
      await UserService().handleSuccessfulLogin(userCredential.user);
      //UserNotifier().handleSuccessfulLogin(mContext, userCredential.user);
      hideDialog(mContext);
      Navigator.of(mContext).pushAndRemoveUntil(
          MaterialPageRoute(builder: (contextTrans) => HomePageNew()),
          ModalRoute.withName(Routes.HOME_PAGE));
    } catch (e) {
      print(e);
      hideDialog(mContext);
      final error = e.toString();
      if (error.contains("wrong-password")) {
        showInformationDialog(
            LocaleProvider.of(mContext).wrong_user_credential);
      } else {
        showInformationDialog(
            LocaleProvider.of(mContext).sorry_dont_transaction);
      }
    }
  }

  bool checkUserInfo(String email, String password) {
    bool isCorrect = false;
    if (email.length > 0) {
      if (password.length > 0) {
        isCorrect = true;
      }
    }
    return isCorrect;
  }

  showLoadingDialog() {
    showDialog(
        context: mContext,
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

  showInformationDialog(String text) {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        });
  }
}
