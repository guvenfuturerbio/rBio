import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../auth.dart';

class ForgotPasswordStep2ScreenVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;
  ForgotPasswordStep2ScreenVm(this.mContext);

  final focus = FocusNode();
  LoadingDialog loadingDialog;

  bool _passwordVisibility;
  bool get passwordVisibility => this._passwordVisibility ?? false;
  void togglePasswordVisibility() {
    this._passwordVisibility = !passwordVisibility;
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
    try {
      if (passwordAdvisor.validateStructure()) {
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
