import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../auth.dart';

class ForgotPasswordStep2ScreenVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;
  ForgotPasswordStep2ScreenVm(this.mContext);

  final focus = FocusNode();
  LoadingDialog loadingDialog;

  // Fields
  bool _checkLowerCase;
  bool _checkNumeric;
  bool _checkSpecial;
  bool _checkUpperCase;
  bool _checkLength;
  bool _passwordVisibility;

  // Getters
  bool get passwordVisibility => this._passwordVisibility ?? false;
  bool get checkLowerCase => this._checkLowerCase ?? false;
  bool get checkUpperCase => this._checkUpperCase ?? false;
  bool get checkNumeric => this._checkNumeric ?? false;
  bool get checkSpecial => this._checkSpecial ?? false;
  bool get checkLength => this._checkLength ?? false;

  void checkPasswordCapability(String password) {
    this._checkLowerCase = PasswordAdvisor().checkLowercase(password);
    this._checkUpperCase = PasswordAdvisor().checkUpperCase(password);
    this._checkSpecial = PasswordAdvisor().checkSpecialCharacter(password);
    this._checkNumeric = PasswordAdvisor().checkNumberInclude(password);
    this._checkLength = PasswordAdvisor().checkRequiredPasswordLength(password);
    notifyListeners();
  }

  void togglePasswordVisibility() {
    this._passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  bool checkPasswordCapabilityForAll(String password) {
    return PasswordAdvisor().validateStructure(password);
  }

  void forgotPassStep2(ChangePasswordModel changePasswordModel) async {
    try {
      if (checkPasswordCapabilityForAll(changePasswordModel.newPassword)) {
        showLoadingDialog(this.mContext);
        notifyListeners();

        final response =
            await getIt<Repository>().changePasswordUi(changePasswordModel);
        await Future.delayed(Duration(milliseconds: 300));
        hideDialog(this.mContext);

        if (response.isSuccessful == true) {
          showInfoDialog(
            LocaleProvider.of(this.mContext).success_message_title,
            LocaleProvider.of(this.mContext).succefully_created_pass,
          );
          Atom.to(PagePaths.LOGIN, isReplacement: true);
        } else {
          if (response.datum == 1) {
            showInfoDialog(
              LocaleProvider.of(this.mContext).warning,
              LocaleProvider.of(this.mContext).wrong_temporary_pass,
            );
          } else if (response.datum == 2) {
            showInfoDialog(
              LocaleProvider.of(this.mContext).warning,
              LocaleProvider.of(this.mContext).pass_must_same,
            );
          } else if (response.datum == 4) {
            showInfoDialog(
              LocaleProvider.of(this.mContext).warning,
              LocaleProvider.of(this.mContext).sorry_dont_transaction,
            );
          }
        }
      }
    } catch (error, stackTrace) {
      showDelayedErrorDialog(
        error,
        stackTrace,
        () => hideDialog(this.mContext),
      );
    } finally {
      notifyListeners();
    }
  }

  void showLoadingDialog(BuildContext context) async {
    await Future.delayed(new Duration(milliseconds: 30));
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
    notifyListeners();
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
