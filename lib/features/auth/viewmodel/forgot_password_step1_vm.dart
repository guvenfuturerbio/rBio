import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../auth.dart';

class ForgotPasswordStep1ScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  ForgotPasswordStep1ScreenVm(this.mContext);

  LoadingDialog? loadingDialog;

  void forgotPassStep1(UserRegistrationStep1Model userRegistrationStep1) async {
    try {
      showLoadingDialog(mContext);
      notifyListeners();
      await getIt<Repository>().forgotPasswordUi(userRegistrationStep1);
      await Future.delayed(const Duration(milliseconds: 500));
      hideDialog(mContext);
      Atom.to(
        PagePaths.forgotPasswordStep2,
        queryParameters: {
          'identityNumber': userRegistrationStep1.identificationNumber ?? '',
        },
      );
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
