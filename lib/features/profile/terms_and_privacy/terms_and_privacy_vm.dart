import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../shared/consent_form/consent_form_dialog.dart';
import '../../shared/kvkk_form/kvkk_form_screen.dart';

class TermsAndPrivacyVm extends ChangeNotifier {
  TermsAndPrivacyVm() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      Atom.show(RbioLoading.progressIndicator());
      await fetchKvkkFormState();
      notifyListeners();
      Atom.dismiss();
    });
  }

  bool checkedKvkk = false;
  void setCheckedKvkk(bool value) {
    checkedKvkk = value;
    notifyListeners();
  }

  bool clickedGeneralForm = false;
  void setClickedGeneralForm(bool value) {
    clickedGeneralForm = value;
    notifyListeners();
  }

  Future<void> fetchKvkkFormState() async {
    checkedKvkk = await getIt<UserManager>().getKvkkFormState();
  }

  void showApplicationContestForm() async{
    final consentForm = await getIt<Repository>().getConsentForm();
    Atom.show(ConsentFormDialog(
title:  consentForm.consentHeader,
      text: consentForm.consentContent,
      alwaysAsk: false,
    )).then((value) async {
      if (value != null && value) {
        setClickedGeneralForm(true);
      } else if (value != null && !value) {
        setClickedGeneralForm(false);
      }
    });
  }

  void showKvkkInfo() {
    Atom.show(KvkkFormScreen(
      title: LocaleProvider.current.kvkk_title,
      text: LocaleProvider.current.kvkk_url_text,
      alwaysAsk: true,
    )).then((value) async {
      if (value != null && value) {
        setCheckedKvkk(true);
      } else if (value != null && !value) {
        setCheckedKvkk(false);
      }
    });
  }
}
