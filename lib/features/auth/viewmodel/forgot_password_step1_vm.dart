import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../auth.dart';

class ForgotPasswordStep1ScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  ForgotPasswordStep1ScreenVm(this.mContext);

  LoadingDialog? loadingDialog;

  void forgotPassStep1(UserRegistrationStep1Model userRegistrationStep1) async {
    showLoadingDialog();

    final either =
        await getIt<Repository>().forgotPassword(userRegistrationStep1);
    await either.fold(
      (response) async {
        await Future.delayed(const Duration(milliseconds: 500));
        hideDialog();
        Atom.to(
          PagePaths.forgotPasswordStep2,
          queryParameters: {
            'identityNumber': userRegistrationStep1.identificationNumber ?? '',
          },
        );
      },
      (error) {
        hideDialog();

        error.when(
          userNotFound: () {
            showInfoDialog(
              LocaleProvider.current.warning,
              LocaleProvider.current.user_not_found,
            );
          },
          phoneNumberNotMatch: () {
            showInfoDialog(
              LocaleProvider.current.warning,
              LocaleProvider.current.user_phone_not_match,
            );
          },
          undefined: () {
            showInfoDialog(
              LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
          },
        );
      },
    );
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
