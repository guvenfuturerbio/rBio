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
    try {
      if (passwordAdvisor.validateStructure()) {
        showLoadingDialog(mContext);
        notifyListeners();

        final response =
            await getIt<Repository>().changePasswordUi(changePasswordModel);
        await Future.delayed(const Duration(milliseconds: 300));
        hideDialog(mContext);

        if (response.isSuccessful == true) {
          showInfoDialog(
            LocaleProvider.of(mContext).success_message_title,
            LocaleProvider.of(mContext).succefully_created_pass,
          );
          Atom.to(PagePaths.login, isReplacement: true);
        } else {
          if (response.datum == 1) {
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.of(mContext).wrong_temporary_pass,
            );
          } else if (response.datum == 2) {
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.of(mContext).pass_must_same,
            );
          } else if (response.datum == 4) {
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.of(mContext).sorry_dont_transaction,
            );
          }
        }
      }
    } catch (error, stackTrace) {
      showDelayedErrorDialog(
        error,
        stackTrace,
        () => hideDialog(mContext),
      );
    } finally {
      notifyListeners();
    }
  }

  void showLoadingDialog(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 30));
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
    notifyListeners();
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null) {
      if (loadingDialog!.isShowing()) {
        Navigator.of(context).pop();
        loadingDialog = null;
      }
    }
  }
}
