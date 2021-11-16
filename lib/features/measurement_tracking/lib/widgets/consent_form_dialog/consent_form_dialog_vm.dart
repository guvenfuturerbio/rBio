import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/services/user_service.dart';

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
        await UserService().getApplicationConsentFormState();
    notifyListeners();
  }

  toggleConsentFormState() async {
    this._clickedConsentForm = !clickedConsentForm;
    if (clickedConsentForm) {
      UserService().setApplicationConsentFormState(true);
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      Navigator.pop(mContext, true);
    } else {
      UserService().setApplicationConsentFormState(false);
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      Navigator.pop(mContext, false);
    }
  }
}
