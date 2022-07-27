import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class RegisterStep3ScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  RegisterStep3ScreenVm(this.mContext);

  LoadingDialog? loadingDialog;

  final AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  AutovalidateMode? get autovalidateMode => _autovalidateMode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState>? get formKey => _formKey;

  void registerStep3(
    UserRegistrationStep3Model userRegistrationStep3,
    bool isWithoutTCKN,
  ) async {
    try {
      showLoadingDialog(mContext);
      GuvenResponseModel? response;
      if (isWithoutTCKN) {
        // response = await getIt<Repository>().registerStep3WithOutTc(userRegistrationStep3);
      } else {
        response = await getIt<Repository>().addStep3(userRegistrationStep3);
      }

      hideDialog(mContext);
      if (response?.isSuccessful == true) {
        Atom.to(PagePaths.login, isReplacement: true);
        Atom.show(
          RbioMessageDialog(
            description: LocaleProvider.current.succefully_created_account,
            buttonTitle: LocaleProvider.current.ok,
            isAtom: true,
          ),
        );
      } else {
        showInfoDialog(
          LocaleProvider.of(mContext).warning,
          response?.message.toString() ?? '',
        );
      }
    } catch (error, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(error, stackTrace: stackTrace);
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
