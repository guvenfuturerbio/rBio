import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class RegisterStep3ScreenVm with ChangeNotifier {
  BuildContext context;
  LoadingDialog loadingDialog;
  CountryListResponse countryList;
  DateTime selectedDate;

  RegisterStep3ScreenVm(this.context) {}

  void registerStep3(
      UserRegistrationStep3Model userRegistrationStep3,
      UserRegistrationStep3Model userRegistrationStep3Model,
      bool isWithoutTCKN) async {
    try {
      showLoadingDialog(context);
      GuvenResponseModel response;
      if (isWithoutTCKN) {
        response = await getIt<Repository>()
            .registerStep3WithOutTc(userRegistrationStep3Model);
      } else {
        response =
            await getIt<Repository>().registerStep3Ui(userRegistrationStep3);
      }

      hideDialog(context);
      if (response.isSuccessful == true) {
        Atom.to(PagePaths.LOGIN, isReplacement: true);
      } else {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            response.message.toString());
      }
    } catch (error) {
      Future.delayed(const Duration(milliseconds: 500), () {
        print(error);
        hideDialog(context);
        showGradientDialog(
            context,
            LocaleProvider.of(context).warning,
            error.toString() == "network"
                ? LocaleProvider.of(context).no_network_connection
                : LocaleProvider.of(context).sorry_dont_transaction);
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
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
    //builder: (BuildContext context) => WillPopScope(child:loadingDialog = LoadingDialog() , onWillPop:  () async => false,));
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
