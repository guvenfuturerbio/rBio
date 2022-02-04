import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';

class KvkkFormScreenVm extends ChangeNotifier {
  BuildContext? mContext;
  bool? clickedConsentForm;
  KvkkFormScreenVm({BuildContext? context, bool? alwaysAsk}) {
    mContext = context!;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (alwaysAsk!) {
      } else {
        await fetchClickedConsentForm();
      }
    });
  }

  fetchClickedConsentForm() async {
    try {
      clickedConsentForm = await getIt<UserManager>().getKvkkFormState();
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
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
