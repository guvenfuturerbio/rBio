import 'package:flutter/material.dart';

import '../../../core/core.dart';

class KvkkFormScreenVm extends ChangeNotifier {
  BuildContext? mContext;
  bool? clickedConsentForm = false;

  KvkkFormScreenVm({BuildContext? context, bool? alwaysAsk}) {
    mContext = context!;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (alwaysAsk!) {
      } else {
        await fetchClickedConsentForm();
      }
    });
  }

  Future<void> fetchClickedConsentForm() async {
    try {
      clickedConsentForm = await getIt<UserManager>().getKvkkFormState();
      notifyListeners();
    } catch (e) {
      LoggerUtils.instance.e(e);
    }
  }

  toggleConsentFormState() async {
    clickedConsentForm = !clickedConsentForm!;
    notifyListeners();
  }

  saveFormState() {
    getIt<UserManager>().setKvkkFormState(clickedConsentForm!);
    Navigator.pop(mContext!, clickedConsentForm);
  }
}
