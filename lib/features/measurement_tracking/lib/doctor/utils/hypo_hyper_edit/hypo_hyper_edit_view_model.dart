import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../models/update_my_patient_limit.dart';
import '../../notifiers/patient_notifiers.dart';
import '../../pages/patients_page/patient_page_view_model.dart';
import '../gradient_dialog.dart';
import '../progress/progress_dialog.dart';

class HypoHyperEditViewModel extends ChangeNotifier {
  BuildContext context;
  int _hypo, _hyper;
  StateProcess _stateProcess;
  ProgressDialog progressDialog;
  String _hyperText, _hypoText;
  HypoHyperEditViewModel({BuildContext context}) {
    this.context = context;
    getHypoHyper();
  }

  StateProcess get stateProcess => _stateProcess;

  getHypoHyper() {
    this._hyper = Provider.of<PatientNotifiers>(context, listen: false)
        .patientDetail
        .hyper;
    this._hypo = Provider.of<PatientNotifiers>(context, listen: false)
        .patientDetail
        .hypo;
    this._hyperText = Provider.of<PatientNotifiers>(context, listen: false)
        .patientDetail
        .hyper
        .toString();
    this._hypoText = Provider.of<PatientNotifiers>(context, listen: false)
        .patientDetail
        .hypo
        .toString();
    notifyListeners();
  }

  int get hyper => this._hyper;

  int get hypo => this._hypo;

  String get hypoText => this._hypoText;

  String get hyperText => this._hyperText;

  setHypoText(String text) {
    this._hypoText = text;
    notifyListeners();
  }

  setHyperText(String text) {
    this._hyperText = text;
    notifyListeners();
  }

  updatePatientLimit(
      {@required int hypo, @required int hyper, @required int id}) async {
    this._stateProcess = StateProcess.LOADING;
    showLoadingDialog();
    await Future.delayed(Duration(milliseconds: 300));
    try {
      await Provider.of<PatientNotifiers>(context, listen: false)
          .updatePatientLimit(
              patientId: id,
              updateMyPatientLimit: UpdateMyPatientLimit(
                  rangeMin:
                      Provider.of<PatientNotifiers>(context, listen: false)
                          .patientDetail
                          .rangeMin,
                  rangeMax:
                      Provider.of<PatientNotifiers>(context, listen: false)
                          .patientDetail
                          .rangeMax,
                  hyper: hyper,
                  hypo: hypo));
      await Provider.of<PatientNotifiers>(context, listen: false)
          .fetchPatientDetail(patientId: id);
      this._stateProcess = StateProcess.DONE;
      hideDialog(context);
      Navigator.pop(context, true);
    } catch (e) {
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      this._stateProcess = StateProcess.ERROR;
      hideDialog(context);
    }
  }

  showLoadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            progressDialog = progressDialog ?? ProgressDialog());
  }

  hideDialog(BuildContext context) {
    if (progressDialog != null && progressDialog.isShowing()) {
      Navigator.of(context).pop();
      progressDialog = null;
    }
  }

  showInformationDialog(String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        }).then((value) => Navigator.pop(context));
  }
}
