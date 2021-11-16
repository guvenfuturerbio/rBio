import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/notifiers/user_notifiers.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/language_notifiers.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/home/home_page/home_page_view.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/home/home_page_new/home_page_new.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../doctor/utils/progress/progress_dialog.dart';
import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../services/user_service.dart';
import '../../../widgets/consent_form_dialog/consent_form_dialog.dart';
import '../../../widgets/gradient_dialog.dart';
import '../customwebview.dart';

class LoginPageVm extends ChangeNotifier {
  BuildContext mContext;
  ProgressDialog progressDialog;
  bool _visibilityAppleSignIn;
  bool _clickedGeneralForm;
  String _localeCode;
  LoginPageVm({BuildContext context}) {
    this.mContext = context;
    checkAppleSignInVisibility();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchConsentFormState();
      await fetchLanguageOfApp();
    });
  }

  bool get clickedGeneralForm => this._clickedGeneralForm ?? false;

  fetchConsentFormState() async {
    this._clickedGeneralForm =
        await UserService().getApplicationConsentFormState();
    notifyListeners();
  }

  fetchLanguageOfApp() async {
    this._localeCode = await UserService().selectedLangFetcher();
    notifyListeners();
  }

  String get localeCode => this._localeCode;

  changeCountryCode(String locale) async {
    var prov = Provider.of<AppLanguage>(mContext, listen: false);
    prov.changeLanguage(locale);
    notifyListeners();
  }

  toggleGeneralFormClick() {
    this._clickedGeneralForm = !clickedGeneralForm;
    notifyListeners();
  }

  checkAppleSignInVisibility() async {
    this._visibilityAppleSignIn = false;
    notifyListeners();
    if (Platform.isIOS) {
      bool appleSignInAvailability = await SignInWithApple.isAvailable();
      if (appleSignInAvailability) {
        this._visibilityAppleSignIn = true;
        notifyListeners();
      }
    }
  }

  showApplicationContestForm() {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ConsentFormDialog(
            title: LocaleProvider.current.approve_consent_form,
            text: LocaleProvider.current.application_consent_form_text,
            alwaysAsk: false,
          );
        }).then((value) async {
      if (value != null && value) {
        this._clickedGeneralForm = true;
        notifyListeners();
      } else if (value != null && !value) {
        this._clickedGeneralForm = false;
        notifyListeners();
      }
    });
  }

  bool get visibilityAppleSignIn => this._visibilityAppleSignIn ?? false;
  /*signInWithApple() async {
    if (clickedGeneralForm) {
      showLoadingDialog();
      await Future.delayed(Duration(milliseconds: 500));
      try {
        OAuthCredential oAuthCredential =
            await UserService().appleSignInService();
        UserCredential userCredential =
            await UserService().signInWithCredentialFirebase(oAuthCredential);
        await UserService().saveAndRetrieveToken(userCredential.user, 'apple');
        await UserService().handleSuccessfulLogin(userCredential.user);
        hideDialog(mContext);
        navigateHome();
      } on SignInWithAppleAuthorizationException catch (e) {
        if (e.code == AuthorizationErrorCode.canceled) {
          hideDialog(mContext);
        } else {
          print("signin apple exception " + e.toString());
          hideDialog(mContext);
          showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
        }
      } catch (e, stk) {
        print(e);
        print(e.runtimeType);
        print("signin apple exception " + e.toString());
        debugPrintStack(stackTrace: stk);
        hideDialog(mContext);
        showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      }
    } else {
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.approve_consent_form);
    }
  }*/

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(title, text);
        }).then((value) {
      if (text == LocaleProvider.current.approve_consent_form) {
        showApplicationContestForm();
      }
    });
  }

  signInWithEmail() {
    if (clickedGeneralForm) {
      Navigator.pushNamed(mContext, Routes.EMAIL_LOGIN_PAGE);
    } else {
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.approve_consent_form);
    }
  }

  signInWithGoogle() async {
    if (clickedGeneralForm) {
      showLoadingDialog();
      await Future.delayed(Duration(milliseconds: 500));
      try {
        AuthCredential credential = await UserService().googleSignInService();
        print('fdfdf');

        UserCredential userCredential =
            await UserService().signInWithCredentialFirebase(credential);
        UserService().handleCredential(userCredential.user,
            Provider.of<UserNotifiers>(mContext, listen: false));
        hideDialog(mContext);
        navigateHome();
      } catch (e, stk) {
        print(e);
        debugPrintStack(stackTrace: stk);
        hideDialog(mContext);
        showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      }
    } else {
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.approve_consent_form);
    }
  }

  signInWithFacebook() async {
    if (clickedGeneralForm) {
      showLoadingDialog();
      await Future.delayed(Duration(milliseconds: 500));
      try {
        String your_client_id = "772170283418718";
        String your_redirect_url =
            "https://www.facebook.com/connect/login_success.html";
        String result = await showDialog(
            builder: (_) => Dialog(
                    child: CustomWebView(
                  selectedUrl:
                      'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
                )),
            context: mContext);
        OAuthCredential oAuthCredential =
            UserService().facebookSignInService(result);
        UserCredential userCredential =
            await UserService().signInWithCredentialFirebase(oAuthCredential);
        await UserService()
            .saveAndRetrieveToken(userCredential.user, 'facebook');
        await UserService().handleSuccessfulLogin(userCredential.user);

        hideDialog(mContext);
        navigateHome();
      } catch (e) {
        print("signin facebook exception" + e.toString());
        hideDialog(mContext);
        showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      }
    } else {
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.approve_consent_form);
    }
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

  navigateHome() {
    Navigator.of(mContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (contextTrans) => HomePageNew()),
        ModalRoute.withName(Routes.HOME_PAGE));
  }
}
