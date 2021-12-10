import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../model/model.dart';
import '../../notifiers/patient_notifiers.dart';
import '../gradient_dialog.dart';
import '../hypo_hyper_edit/hypo_hyper_edit_view_model.dart';
import '../progress/progress_dialog.dart';

class RangeSetterSliderViewModel extends ChangeNotifier {
  BuildContext context;
  double _startValue, _endValue;
  StateProcess _stateProcess;
  ProgressDialog progressDialog;
  var _lowerValue, _higherValue, _hypoValue, _hyperValue;
  var MAX_RANGE = 300;
  var MIN_DISTANCE = 10;
  var MAX_TARGET = 280;
  var MIN_TARGET = 30;
  RangeSetterSliderViewModel({BuildContext context}) {
    this.context = context;
  }
  StateProcess get stateProcess => _stateProcess;

  setThumbStartValue(int startValue) {
    this._startValue = _startValue;
    notifyListeners();
  }

  double get thumbStartValue => this._startValue;

  setThumbEndValue(int endValue) {
    this._endValue = _endValue;
    notifyListeners();
  }

  get maxRange => this.MAX_RANGE;

  get minDistance => this.MIN_DISTANCE;

  get maxTarget => this.MAX_TARGET;

  get minTarget => this.MIN_TARGET;

  double get thumbEndValue => this.thumbEndValue;

  setTargetRange(var lowerValue, var higherValue) {
    this._lowerValue = lowerValue;
    this._higherValue = higherValue;
    if ((lowerValue - MIN_DISTANCE - 1) < hypoValue) {
      if (lowerValue > MIN_TARGET) {
        setHypoValue(lowerValue - MIN_DISTANCE);
      }
    }
    if ((higherValue + MIN_DISTANCE - 1) > hyperValue) {
      if (higherValue < MAX_TARGET) {
        setHyperValue(higherValue + MIN_DISTANCE);
      }
    }
    notifyListeners();
  }

  setHypoValue(var value) {
    this._hypoValue = value;
    notifyListeners();
  }

  setHyperValue(var value) {
    this._hyperValue = value;
    notifyListeners();
  }

  get hypoValue =>
      this._hypoValue ??
      Provider.of<PatientNotifiers>(context, listen: false)
          .patientDetail
          .hypo
          .toDouble();

  get lowerValue =>
      this._lowerValue ??
      Provider.of<PatientNotifiers>(context, listen: false)
          .patientDetail
          .rangeMin
          .toDouble();

  get higherValue =>
      this._higherValue ??
      Provider.of<PatientNotifiers>(context, listen: false)
          .patientDetail
          .rangeMax
          .toDouble();

  get hyperValue =>
      this._hyperValue ??
      Provider.of<PatientNotifiers>(context, listen: false)
          .patientDetail
          .hyper
          .toDouble();

  updatePatientLimit(
      {@required int startValue,
      @required int endValue,
      @required int id}) async {
    this._stateProcess = StateProcess.LOADING;
    showLoadingDialog();
    await Future.delayed(Duration(milliseconds: 300));
    try {
      await Provider.of<PatientNotifiers>(context, listen: false)
          .updatePatientLimit(
              patientId: id,
              updateMyPatientLimit: UpdateMyPatientLimit(
                  rangeMin: (lowerValue as double).toInt(),
                  rangeMax: (higherValue as double).toInt(),
                  hyper: (hyperValue as double)
                      .toInt(), //Provider.of<PatientNotifiers>(context, listen: false).patientDetail.hyper,
                  hypo: (hypoValue as double)
                      .toInt() //Provider.of<PatientNotifiers>(context, listen: false).patientDetail.hypo
                  ));
      await Provider.of<PatientNotifiers>(context, listen: false)
          .fetchPatientDetail(patientId: id);
      this._stateProcess = StateProcess.DONE;
      hideDialog(context);
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
