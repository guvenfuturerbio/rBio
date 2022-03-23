import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../auth.dart';

class ForgotPasswordStep2ScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  ForgotPasswordStep2ScreenVm(this.mContext);

  final focus = FocusNode();
  LoadingDialog? loadingDialog;

  bool _passwordVisibility = false;
  bool get passwordVisibility => _passwordVisibility;
  void togglePasswordVisibility() {
    _passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  final PasswordAdvisor passwordAdvisor = PasswordAdvisor();

  bool get checkLowerCase => passwordAdvisor.lowerCaseValue;
  bool get checkUpperCase => passwordAdvisor.upperCaseValue;
  bool get checkNumeric => passwordAdvisor.numericValue;
  bool get checkSpecial => passwordAdvisor.specialValue;
  bool get checkLength => passwordAdvisor.lengthValue;

  void checkPasswordCapability(String newPassword) {
    passwordAdvisor.checkPassword(newPassword);
    notifyListeners();
  }

  void forgotPassStep2(ChangePasswordModel changePasswordModel) async {
    if (passwordAdvisor.validateStructure()) {
      showLoadingDialog();

      final either =
          await getIt<Repository>().changePassword(changePasswordModel);
      await either.fold(
        (response) async {
          hideDialog();
          Atom.to(
            PagePaths.loginWithSuccessChangePassword(),
            isReplacement: true,
          );
        },
        (error) {
          hideDialog();

          error.when(
            oldError: () {
              showInfoDialog(
                LocaleProvider.of(mContext).warning,
                LocaleProvider.of(mContext).wrong_temporary_pass,
              );
            },
            confirmError: () {
              showInfoDialog(
                LocaleProvider.of(mContext).warning,
                LocaleProvider.of(mContext).pass_must_same,
              );
            },
            systemError: () {
              showInfoDialog(
                LocaleProvider.of(mContext).warning,
                LocaleProvider.of(mContext).error_system_malfunction,
              );
            },
            undefined: () {
              showInfoDialog(
                LocaleProvider.of(mContext).warning,
                LocaleProvider.of(mContext).sorry_dont_transaction,
              );
            },
          );
        },
      );
    }
  }

  void showLoadingDialog() async {
    await Future.delayed(const Duration(milliseconds: 30));
    await showDialog(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
    notifyListeners();
  }

  void hideDialog() {
    if (loadingDialog != null) {
      if (loadingDialog!.isShowing()) {
        Navigator.of(mContext).pop();
        loadingDialog = null;
      }
    }
    notifyListeners();
  }
}
