import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../auth.dart';

class ForgotPasswordStep1ScreenVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;
  ForgotPasswordStep1ScreenVm(this.mContext);

  LoadingDialog loadingDialog;

  void forgotPassStep1(UserRegistrationStep1Model userRegistrationStep1) async {
    try {
      showLoadingDialog(this.mContext);
      notifyListeners();
      await getIt<Repository>().forgotPasswordUi(userRegistrationStep1);
      await Future.delayed(Duration(milliseconds: 500));
      hideDialog(this.mContext);
      Atom.to(
        PagePaths.FORGOT_PASSWORD_STEP_2,
        queryParameters: {
          'identityNumber': userRegistrationStep1.identificationNumber,
        },
      );
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
