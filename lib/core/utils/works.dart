import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../generated/l10n.dart';
import '../data/repository/repository.dart';
import '../locator.dart';
import '../widgets/gradient_dialog.dart';
import '../widgets/loading_dialog.dart';

class Works {
  LoadingDialog loadingDialog;

  Future<void> patientCallMe(BuildContext context) async {
    showLoadingDialog(context);
    try {
      final response = await getIt<Repository>().patientCallMeUi();
      hideDialog(context);
      if (response.datum != 0) {
        showGradientDialog(context, LocaleProvider.of(context).info,
            LocaleProvider.of(context).we_will_call);
      } else {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            LocaleProvider.of(context).sorry_dont_transaction);
      }
    } catch (error) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          print(error);
          hideDialog(context);
          showGradientDialog(
              context,
              LocaleProvider.of(context).warning,
              error.toString() == "network"
                  ? LocaleProvider.of(context).no_network_connection
                  : LocaleProvider.of(context).sorry_dont_transaction);
        },
      );
    }
  }

  Future<void> showLoadingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  Future<void> hideDialog(BuildContext context) async {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(title, text);
      },
    );
  }

  static const platform = const MethodChannel('omron');

  Future<void> getOmronDeviceList() async {
    try {
      var result = await platform.invokeMethod('omron', {"isDebug": true});
      print("result " + result.toString());
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
