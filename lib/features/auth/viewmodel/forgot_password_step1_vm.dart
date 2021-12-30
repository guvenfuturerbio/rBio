import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../auth.dart';

class ForgotPasswordStep1ScreenVm extends ChangeNotifier {
  BuildContext mContext;
  LoadingDialog loadingDialog;

  ForgotPasswordStep1ScreenVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

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
      notifyListeners();
    } catch (error) {
      Future.delayed(const Duration(milliseconds: 500), () {
        print(error);
        hideDialog(this.mContext);
        showGradientDialog(
            this.mContext,
            LocaleProvider.of(this.mContext).warning,
            error.toString() == "network"
                ? LocaleProvider.of(this.mContext).no_network_connection
                : LocaleProvider.of(this.mContext).sorry_dont_transaction);
        notifyListeners();
      });
    }
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
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
