import 'package:flutter/material.dart';
import 'package:onedosehealth/core/manager/user_manager.dart';
import 'package:onedosehealth/core/locator.dart';

class ConsentFormDialogVm extends ChangeNotifier {
  BuildContext mContext;
  bool _clickedConsentForm;
  ConsentFormDialogVm({BuildContext context, bool alwaysAsk}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (alwaysAsk) {
      } else {
        await fetchClickedConsentForm();
      }
    });
  }

  bool get clickedConsentForm => this._clickedConsentForm ?? false;

  fetchClickedConsentForm() async {
    this._clickedConsentForm =
        await getIt<UserManager>().getApplicationConsentFormState();
    notifyListeners();
  }

  toggleConsentFormState() async {
    this._clickedConsentForm = !clickedConsentForm;
    notifyListeners();
  }

  saveConsentFormState() async {
    getIt<UserManager>().setApplicationConsentFormState(clickedConsentForm);
    Navigator.pop(mContext, clickedConsentForm);
  }
}
