import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/http.dart';

import '../../../core/core.dart';

class NecessaryIdentityScreenVm extends ChangeNotifier {
  BuildContext mContext;
  Progress _progress;
  LoadingDialog loadingDialog;

  NecessaryIdentityScreenVm({BuildContext context}) {
    this.mContext = context;
  }

  Progress get progress => this._progress;

  updateIdentity(String identityNumber) async {
    if (identityNumber.isNotEmpty) {
      try {
        showLoadingDialog();
        await getIt<UserManager>().updateIdentityOps(identityNumber);
        hideDialog();
        Navigator.pop(mContext, true);
      } catch (e) {
        print("update identity error " + e.toString());
        hideDialog();
        showGradientDialog(
            LocaleProvider.current.warning,
            e == 5
                ? LocaleProvider.current.doesnt_match_tc
                : LocaleProvider.current.sorry_dont_transaction);
      }
    }
  }

  void showLoadingDialog() async {
    await showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
  }

  void hideDialog() {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(mContext).pop();
      loadingDialog = null;
    }
  }

  void showGradientDialog(String title, String text) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }
}
