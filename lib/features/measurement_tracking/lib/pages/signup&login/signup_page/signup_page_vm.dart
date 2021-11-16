import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../core/utils/progress_dialog.dart';
import '../../../services/user_service.dart';
import '../../../widgets/gradient_dialog.dart';
import '../email_login_page/doctor_checker.dart';

class SignUpPageVm extends ChangeNotifier {
  final BuildContext mContext;
  ProgressDialog progressDialog;

  String errorMessage = '';

  SignUpPageVm({this.mContext});

  // Sign up interface func.
  signUp(String email, String name, String password) async {
    try {
      showLoadingDialog();
      if (checkUserInfo(email, password)) {
        if (isEmail(email)) {
          await UserService()
              .createUserWithEmailAndPassword(email, password, name);
          hideDialog(mContext);
          errorMessage = LocaleProvider.current.succefully_created_account;
          showInformationDialog().then((value) => signIn(email, password));
        } else {
          errorMessage = LocaleProvider.of(mContext).verify_email_error;
          throw Exception('email-not-true');
        }
      } else {
        errorMessage = LocaleProvider.of(mContext).user_login_cannot_blank;
        throw Exception(LocaleProvider.of(mContext).user_login_cannot_blank);
      }
      hideDialog(mContext);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      hideDialog(mContext);

      handleErrorMessage(e.code);
      showInformationDialog();
    } catch (_) {
      hideDialog(mContext);
      showInformationDialog();
    }
  }

  //Sign in interface func
  Future<void> signIn(String email, String password) async {
    showLoadingDialog();
    try {
      UserCredential userCredential = await UserService()
          .signInWithEmailAndPasswordFirebase(email, password);
      DoctorChecker().doctor = false;

      await UserService().handleCredential(userCredential.user, isSignUp: true);
      hideDialog(mContext);
      // Navigator.of(mContext).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (contextTrans) => HomePageNew()),
      //   ModalRoute.withName(Routes.HOME_PAGE),
      // );
    } catch (e) {
      print(e);
      hideDialog(mContext);
      errorMessage = LocaleProvider.current.sorry_dont_transaction;
      showInformationDialog();
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

  bool isEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
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

  Future showInformationDialog() async {
    await showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, errorMessage);
        });
  }

  void handleErrorMessage(String errorCode) {
    switch (errorCode) {
      case "email-already-in-use":
        errorMessage = LocaleProvider.current.email_address_already_in_use;
        break;
      case "user-not-found":
        errorMessage = LocaleProvider.current.user_with_email_does_not_exists;
        break;
      case "wrong-password":
        errorMessage = LocaleProvider.current.wrong_password;
        break;
      case "user-create-error":
        errorMessage = LocaleProvider.current.user_create_error;
        break;
      case "oauth_credential_error":
        errorMessage = LocaleProvider.current.oauth_credential_error;
        break;
      case "apple_credential_error":
        errorMessage = LocaleProvider.current.apple_credential_error;
        break;
      case "verify-email":
        errorMessage = LocaleProvider.current.verify_email_error;
        break;
      case 'weak-password':
        errorMessage = LocaleProvider.current.password_at_least_6;
        break;
      default:
        errorMessage = LocaleProvider.current.login_error_message;
    }
  }
}
