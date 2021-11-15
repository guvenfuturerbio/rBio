import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../models/update_my_patient_limit.dart';
import '../../notifiers/patient_notifiers.dart';
import '../../pages/patients_page/patient_page_view_model.dart';
import '../gradient_dialog.dart';
import '../progress/progress_dialog.dart';

class BloodGlucosePickerVM extends ChangeNotifier {
  BuildContext context;
  int _startValue, _endValue;
  StateProcess _stateProcess;
  ProgressDialog progressDialog;
  var _lowerValue, _higherValue, _hypoValue, _hyperValue;

  List<int> min = [];
  List<int> max = [];
  List<int> hyperRange = [];
  List<int> hypoRange = [];
  List<Text> minWidget = [];
  List<Text> maxWidget = [];
  List<Text> hyperRangeWidget = [];
  List<Text> hypoRangeWidget = [];

  BloodGlucosePickerVM(this.context) {
    buildHyperRange();
    buildHypoRange();
    buildNormalRange();
  }

  setThumbStartValue(int startValue) {
    this._startValue = _startValue;
    notifyListeners();
  }

  int get thumbStartValue => this._startValue;

  StateProcess get stateProcess => _stateProcess;

  setThumbEndValue(int endValue) {
    this._endValue = _endValue;
    notifyListeners();
  }

  int get thumbEndValue => this.thumbEndValue;
  get hypoValue =>
      this._hypoValue ??
      Provider.of<PatientNotifiers>(context, listen: false).patientDetail.hypo;

  get lowerValue =>
      this._lowerValue ??
      Provider.of<PatientNotifiers>(context, listen: false)
          .patientDetail
          .rangeMin;

  get higherValue =>
      this._higherValue ??
      Provider.of<PatientNotifiers>(context, listen: false)
          .patientDetail
          .rangeMax;

  get hyperValue =>
      this._hyperValue ??
      Provider.of<PatientNotifiers>(context, listen: false).patientDetail.hyper;

  setTargetRange(var lowerValue, var higherValue) {
    this._lowerValue = lowerValue;
    this._higherValue = higherValue;

    notifyListeners();
  }

  setHypoValue(var value) {
    this._hypoValue = value;

    buildHypoRange();
    notifyListeners();
  }

  setHyperValue(var value) {
    this._hyperValue = value;
    buildHyperRange();
  }

  List<int> buildHypoRange() {
    hypoRange = [];
    hypoRangeWidget = [];
    for (int i = 0; i < lowerValue; i = i + 10) {
      hypoRange.add(i);
    }
    hypoRange.forEach((number) {
      hypoRangeWidget.add(Text(number.toString()));
    });
    return hypoRange;
  }

  List<int> buildHyperRange() {
    hyperRange = [];
    hyperRangeWidget = [];
    for (int i = higherValue; i < 1000; i = i + 10) {
      hyperRange.add(i);
    }
    hyperRange.forEach((number) {
      hyperRangeWidget.add(Text(number.toString()));
    });
    return hyperRange;
  }

  buildNormalRange() {
    min = [];
    max = [];
    minWidget = [];
    maxWidget = [];
    for (int i = hypoValue; i < higherValue; i = i + 10) {
      min.add(i);
    }
    for (int i = lowerValue + 10; i <= hyperValue; i = i + 10) {
      max.add(i);
    }
    min.forEach((number) {
      minWidget.add(Text(number.toString()));
    });
    max.forEach((number) {
      maxWidget.add(Text(number.toString()));
    });
    notifyListeners();
  }

  updatePatientLimit({@required int id}) async {
    this._stateProcess = StateProcess.LOADING;
    showLoadingDialog();
    await Future.delayed(Duration(milliseconds: 300));
    try {
      await Provider.of<PatientNotifiers>(context, listen: false)
          .updatePatientLimit(
              patientId: id,
              updateMyPatientLimit: UpdateMyPatientLimit(
                  rangeMin: (lowerValue.toInt()),
                  rangeMax: (higherValue.toInt()),
                  hyper: (hyperValue)
                      .toInt(), //Provider.of<PatientNotifiers>(context, listen: false).patientDetail.hyper,
                  hypo: (hypoValue)
                      .toInt() //Provider.of<PatientNotifiers>(context, listen: false).patientDetail.hypo
                  ));
      await Provider.of<PatientNotifiers>(context, listen: false)
          .fetchPatientDetail(patientId: id);
      this._stateProcess = StateProcess.DONE;
      hideDialog(context);
      await Future.delayed(Duration(milliseconds: 300));
      Navigator.pop(context, true);
    } catch (e) {
      print(e);
      hideDialog(context);
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      this._stateProcess = StateProcess.ERROR;
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
    print(text);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        }).then((value) => Navigator.pop(context));
  }
}
