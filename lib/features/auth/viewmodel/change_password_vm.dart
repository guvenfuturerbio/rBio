import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';
import '../../../model/shared/user_login_info.dart';

class ChangePasswordScreenVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  LoadingProgress _progress;

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

  Future<void> changePassword({
    @required String newPassword,
    @required String oldPassword,
  }) async {
    if (checkPasswordCapabilityForAll(newPassword)) {
      try {
        showLoadingDialog(this.mContext);
        notifyListeners();
        final response = await getIt<Repository>()
            .changeUserPasswordUi(oldPassword, newPassword);
        hideDialog(this.mContext);
        if (response.isSuccessful == true) {
          UserLoginInfo userLoginInfo =
              await getIt<UserManager>().getSavedLoginInfo();
          await getIt<ISharedPreferencesManager>()
              .setString(SharedPreferencesKeys.LOGIN_PASSWORD, newPassword);
          bool rememberChecked = userLoginInfo.password != "" ? true : false;
          await getIt<UserManager>().saveLoginInfo(
            userLoginInfo.username,
            userLoginInfo.password,
            rememberChecked,
            getIt<ISharedPreferencesManager>()
                .getString(SharedPreferencesKeys.JWT_TOKEN),
          );
          showInfoDialog(
            LocaleProvider.of(this.mContext).success_message_title,
            LocaleProvider.of(this.mContext).succefully_created_pass,
          );
          notifyListeners();
        } else {
          try {
            int errorCode = response.datum;
            if (errorCode == 1) {
              showInfoDialog(
                LocaleProvider.of(this.mContext).warning,
                LocaleProvider.of(this.mContext).error_old_password_wrong,
              );
            } else if (errorCode == 2) {
              showInfoDialog(
                LocaleProvider.of(this.mContext).warning,
                LocaleProvider.of(this.mContext).error_password_mismatch,
              );
            } else if (errorCode == 4) {
              showInfoDialog(
                LocaleProvider.of(this.mContext).warning,
                LocaleProvider.of(this.mContext).error_system_malfunction,
              );
            } else {
              showInfoDialog(
                LocaleProvider.of(this.mContext).warning,
                LocaleProvider.of(this.mContext).sorry_dont_transaction,
              );
            }
          } catch (e) {
            showInfoDialog(
              LocaleProvider.of(this.mContext).warning,
              LocaleProvider.of(this.mContext).sorry_dont_transaction,
            );
          } finally {
            notifyListeners();
          }
        }
      } catch (error, stk) {
        Sentry.captureException(error, stackTrace: stk);
        Future.delayed(const Duration(milliseconds: 500), () {
          hideDialog(this.mContext);
          showGradientDialog(
            LocaleProvider.of(this.mContext).warning,
            LocaleProvider.of(this.mContext).sorry_dont_transaction,
            false,
          );
        });
      } finally {
        notifyListeners();
      }
    }
  }

  void showLoadingDialog(BuildContext context) async {
    await Future.delayed(new Duration(milliseconds: 30));
    await showDialog(
      context: this.mContext,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(this.mContext).pop();
      loadingDialog = null;
      notifyListeners();
    }
  }
}
