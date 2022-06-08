import 'package:flutter/material.dart';
import '../../../core/manager/user_manager.dart';
import '../../../core/locator.dart';

class ConsentFormDialogVm extends ChangeNotifier {
  BuildContext? mContext;

  ConsentFormDialogVm({BuildContext? context, bool? alwaysAsk}) {
    mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (alwaysAsk!) {
      } else {
        fetchClickedConsentForm();
      }
    });
  }

  bool clickedConsentForm = false;

  void fetchClickedConsentForm() {
    clickedConsentForm = getIt<UserManager>().getApplicationConsentFormState();
    notifyListeners();
  }

  void toggleConsentFormState() {
    clickedConsentForm = !clickedConsentForm;
    notifyListeners();
  }

  void saveConsentFormState() {
    getIt<UserManager>().setApplicationConsentFormState(clickedConsentForm);
    Navigator.pop(mContext!, clickedConsentForm);
  }
}
