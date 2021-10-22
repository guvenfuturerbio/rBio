import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';

class KvkkFormScreenVm extends ChangeNotifier {
  BuildContext mContext;
  bool _clickedConsentForm;
  KvkkFormScreenVm({BuildContext context, bool alwaysAsk}) {
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
    try {
      this._clickedConsentForm = await getIt<UserManager>().getKvkkFormState();
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  toggleConsentFormState() async {
    this._clickedConsentForm = !clickedConsentForm;
    notifyListeners();
  }

  saveFormState() {
    getIt<UserManager>().setKvkkFormState(clickedConsentForm);
    Navigator.pop(mContext, clickedConsentForm);
  }
}
