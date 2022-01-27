import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/shared/consent_form/consent_form_dialog.dart';
import 'package:onedosehealth/features/shared/kvkk_form/kvkk_form_screen.dart';

class TermsAndPrivacyVm extends ChangeNotifier {
  bool _checkedKvkk;
  bool get checkedKvkkForm => this._checkedKvkk ?? false;
  bool _clickedGeneralForm;
  TermsAndPrivacyVm() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Atom.show(RbioLoading.progressIndicator());
      await fetchKvkkFormState();
      notifyListeners();
      Atom.dismiss();
    });
  }
  set checkedKvkkForm(bool value) {
    this._checkedKvkk = value;
    notifyListeners();
  }

  set clickedGeneralForm(bool value) {
    this._clickedGeneralForm = value;
    notifyListeners();
  }

  bool get clickedGeneralForm => this._clickedGeneralForm ?? false;
  Future<void> fetchKvkkFormState() async {
    this._checkedKvkk = await getIt<UserManager>().getKvkkFormState();
  }

  showApplicationContestForm() {
    Atom.show(ConsentFormDialog(
      title: LocaleProvider.current.approve_consent_form,
      text: LocaleProvider.current.application_consent_form_text,
      alwaysAsk: false,
    )).then((value) async {
      if (value != null && value) {
        this._clickedGeneralForm = true;
        notifyListeners();
      } else if (value != null && !value) {
        this._clickedGeneralForm = false;
        notifyListeners();
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
        this._checkedKvkk = true;
        notifyListeners();
      } else if (value != null && !value) {
        this._checkedKvkk = false;
        notifyListeners();
      }
    });
  }
}
