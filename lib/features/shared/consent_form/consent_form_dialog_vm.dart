import 'package:flutter/material.dart';
import '../../../core/manager/user_manager.dart';
import '../../../core/locator.dart';

class ConsentFormDialogVm extends ChangeNotifier {
  BuildContext? mContext;
  bool? clickedConsentForm;
  ConsentFormDialogVm({BuildContext? context, bool? alwaysAsk}) {
    mContext = context;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (alwaysAsk!) {
      } else {
        await fetchClickedConsentForm();
      }
    });
  }

  fetchClickedConsentForm() async {
    clickedConsentForm = getIt<UserManager>().getApplicationConsentFormState();
    notifyListeners();
  }

  toggleConsentFormState() async {
    clickedConsentForm = !clickedConsentForm!;
    notifyListeners();
  }

  saveConsentFormState() async {
    getIt<UserManager>().setApplicationConsentFormState(clickedConsentForm!);
    Navigator.pop(mContext!, clickedConsentForm);
  }
}
