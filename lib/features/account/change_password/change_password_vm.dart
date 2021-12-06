import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';
import '../../../core/locator.dart';
import '../../../generated/l10n.dart';
import '../../../model/shared/user_login_info.dart';

class ChangePasswordScreenVm extends ChangeNotifier {
  BuildContext mContext;
  LoadingProgress _progress;
  final focus = FocusNode();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _passwordAgainController =
      new TextEditingController();
  final TextEditingController _oldPasswordController =
      new TextEditingController();
  bool _checkLowerCase;
  bool _checkNumeric;
  bool _checkSpecial;
  bool _checkUpperCase;
  bool _checkLength;
  LoadingDialog loadingDialog;
  bool _passwordVisibility;

  final _passwordFNode = FocusNode();
  final _passwordAgainFNode = FocusNode();
  final _oldPasswordFNode = FocusNode();

  ChangePasswordScreenVm({
    BuildContext context,
  }) {
    this.mContext = context;
  }

  LoadingProgress get progress => this._progress;
  TextEditingController get passwordController => this._passwordController;
  TextEditingController get passwordAgainController =>
      this._passwordAgainController;
  TextEditingController get oldPasswordController =>
      this._oldPasswordController;
  FocusNode get passwordFNode => this._passwordFNode;
  FocusNode get passwordAgainFNode => this._passwordAgainFNode;
  FocusNode get oldPasswordFNode => this._oldPasswordFNode;
  bool get passwordVisibility => this._passwordVisibility ?? false;

  get checkLowerCase => this._checkLowerCase ?? false;

  get checkUpperCase => this._checkUpperCase ?? false;

  get checkNumeric => this._checkNumeric ?? false;

  get checkSpecial => this._checkSpecial ?? false;

  get checkLength => this._checkLength ?? false;

  checkPasswordCapability(String password) {
    this._checkLowerCase = PasswordAdvisor().checkLowercase(password);
    this._checkUpperCase = PasswordAdvisor().checkUpperCase(password);
    this._checkSpecial = PasswordAdvisor().checkSpecialCharacter(password);
    this._checkNumeric = PasswordAdvisor().checkNumberInclude(password);
    this._checkLength = PasswordAdvisor().checkRequiredPasswordLength(password);
    notifyListeners();
  }

  checkPasswordCapabilityForAll(String password) {
    return PasswordAdvisor().validateStructure(password);
  }

  togglePasswordVisibility() {
    this._passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  Future<void> changePassword() async {
    if (checkPasswordCapabilityForAll(this._passwordController.text)) {
      try {
        showLoadingDialog(this.mContext);
        notifyListeners();
        final response = await getIt<Repository>().changeUserPasswordUi(
            this._oldPasswordController.text, this._passwordController.text);
        hideDialog(this.mContext);
        if (response.isSuccessful == true) {
          UserLoginInfo userLoginInfo =
              await getIt<UserManager>().getSavedLoginInfo();
          await getIt<ISharedPreferencesManager>().setString(
              SharedPreferencesKeys.LOGIN_PASSWORD,
              this._passwordController.text);
          bool rememberChecked = userLoginInfo.password != "" ? true : false;
          await getIt<UserManager>().saveLoginInfo(
            userLoginInfo.username,
            userLoginInfo.password,
            rememberChecked,
            getIt<ISharedPreferencesManager>()
                .getString(SharedPreferencesKeys.JWT_TOKEN),
          );
          AnalyticsManager().sendEvent(new ChangeMyPasswordSuccessEvent());
          showGradientDialog(
              this.mContext,
              LocaleProvider.of(this.mContext).success_message_title,
              LocaleProvider.of(this.mContext).succefully_created_pass);
          notifyListeners();
        } else {
          AnalyticsManager().sendEvent(new ChangeMyPasswordFailEvent());
          try {
            int errorCode = response.datum;
            if (errorCode == 1) {
              showGradientDialog(
                  this.mContext,
                  LocaleProvider.of(this.mContext).warning,
                  LocaleProvider.of(this.mContext).error_old_password_wrong);
            } else if (errorCode == 2) {
              showGradientDialog(
                  this.mContext,
                  LocaleProvider.of(this.mContext).warning,
                  LocaleProvider.of(this.mContext).error_password_mismatch);
            } else if (errorCode == 4) {
              showGradientDialog(
                  this.mContext,
                  LocaleProvider.of(this.mContext).warning,
                  LocaleProvider.of(this.mContext).error_system_malfunction);
            } else {
              showGradientDialog(
                  this.mContext,
                  LocaleProvider.of(this.mContext).warning,
                  LocaleProvider.of(this.mContext).sorry_dont_transaction);
            }
            notifyListeners();
          } catch (e) {
            showGradientDialog(
                this.mContext,
                LocaleProvider.of(this.mContext).warning,
                LocaleProvider.of(this.mContext).sorry_dont_transaction);
            notifyListeners();
          }
        }
      } catch (error, stk) {
        Sentry.captureException(error, stackTrace: stk);
        AnalyticsManager().sendEvent(new ChangeMyPasswordFailEvent());
        Future.delayed(const Duration(milliseconds: 500), () {
          print(error);
          hideDialog(this.mContext);
          showGradientDialog(
              this.mContext,
              LocaleProvider.of(this.mContext).warning,
              error.toString() == "network"
                  ? LocaleProvider.of(this.mContext).no_network_connection
                  : LocaleProvider.of(this.mContext).sorry_dont_transaction);
        });
        debugPrintStack(stackTrace: stk);
        notifyListeners();
      }
    }
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: this.mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }

  void showLoadingDialog(BuildContext context) async {
    await new Future.delayed(new Duration(milliseconds: 30));
    await showDialog(
        context: this.mContext,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
    //builder: (BuildContext context) => WillPopScope(child:loadingDialog = LoadingDialog() , onWillPop:  () async => false,));
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(this.mContext).pop();
      loadingDialog = null;
      notifyListeners();
    }
  }
}
