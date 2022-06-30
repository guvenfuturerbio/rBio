import 'package:flutter/material.dart';

import '../../../core/core.dart';

class NecessaryIdentityScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  NecessaryIdentityScreenVm(this.mContext);

  LoadingDialog? loadingDialog;

  Future<void> updateIdentity(String identityNumber) async {
    if (identityNumber.isNotEmpty) {
      try {
        showLoadingDialog();
        await getIt<UserManager>().updateIdentityOps(identityNumber);
        hideDialog();
        Atom.dismiss(true);
      } catch (e, stackTrace) {
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(e, stackTrace: stackTrace);
        hideDialog();
        showWarningDialog(e);
      }
    }
  }

  void showWarningDialog(Object? e) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (context) {
        return RbioContextInfoDialog(
          title: LocaleProvider.current.warning,
          text: e == 5
              ? LocaleProvider.current.doesnt_match_tc
              : LocaleProvider.current.sorry_dont_transaction,
        );
      },
    );
  }

  void showLoadingDialog() async {
    await showDialog(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  void hideDialog() {
    if (loadingDialog != null && loadingDialog!.isShowing()) {
      Navigator.of(mContext).pop();
      loadingDialog = null;
    }
  }
}
