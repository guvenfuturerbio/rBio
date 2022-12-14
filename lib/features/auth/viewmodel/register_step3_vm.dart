import 'package:flutter/material.dart';

import '../auth.dart';
import '../../../core/core.dart';
import '../../../model/model.dart';

class RegisterStep3ScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  RegisterStep3ScreenVm(this.mContext);

  LoadingDialog? loadingDialog;

  void registerStep3(
    UserRegistrationStep3Model userRegistrationStep3,
    UserRegistrationStep3Model userRegistrationStep3Model,
    bool isWithoutTCKN,
  ) async {
    try {
      showLoadingDialog(mContext);
      GuvenResponseModel response;
      if (isWithoutTCKN) {
        response = await getIt<Repository>()
            .registerStep3WithOutTc(userRegistrationStep3Model);
      } else {
        response =
            await getIt<Repository>().registerStep3Ui(userRegistrationStep3);
      }

      hideDialog(mContext);
      if (response.isSuccessful == true) {
        Atom.to(PagePaths.login, isReplacement: true);
        Atom.show(
          GuvenAlert(
            title: GuvenAlert.buildTitle(LocaleProvider.current.info),
            backgroundColor: getIt<ITheme>().cardBackgroundColor,
            content: GuvenAlert.buildDescription(
                LocaleProvider.current.succefully_created_account),
            actions: [
              GuvenAlert.buildBigMaterialAction(
                LocaleProvider.current.Ok,
                () {
                  Atom.dismiss();
                },
              ),
            ],
          ),
        );
      } else {
        showInfoDialog(
          LocaleProvider.of(mContext).warning,
          response.message.toString(),
        );
      }
    } catch (error, stackTrace) {
      showDelayedErrorDialog(
        error,
        stackTrace,
        () => hideDialog(mContext),
      );
    }
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
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
