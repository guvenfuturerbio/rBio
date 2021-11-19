import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/generated/l10n.dart';

import '../../../core/utils/progress_dialog.dart';
import '../../../helper/resources.dart';
import '../../../services/user_service.dart';
import '../../../widgets/gradient_dialog.dart';
import '../../home/home_page_new/home_page_new.dart';
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
      patientLogin(eMail, password);
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

  patientLogin(String eMail, String password) async {
    showLoadingDialog();
    await Future.delayed(Duration(milliseconds: 500));
    try {
      UserCredential userCredential = await UserService()
          .signInWithEmailAndPasswordFirebase(eMail, password);
      await UserService()
          .saveAndRetrieveToken(userCredential.user, 'patientLogin');
      await UserService().handleSuccessfulLogin(userCredential.user);
      DoctorChecker().doctor = false;
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
      },
    );
  }
}
