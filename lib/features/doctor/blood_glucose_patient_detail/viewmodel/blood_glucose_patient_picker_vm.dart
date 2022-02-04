part of '../view/blood_glucose_patient_detail_screen.dart';

class BloodGlucosePatientPickerVm extends ChangeNotifier {
  BuildContext context;
  int _startValue, _endValue;
  LoadingProgress _stateProcess;
  ProgressDialog progressDialog;
  var _lowerValue, _higherValue, _hypoValue, _hyperValue;

  List<int> min = [];
  List<int> max = [];
  List<int> hyperRange = [];
  List<int> hypoRange = [];
  List<Text> minWidget = [];
  List<Text> maxWidget = [];
  List<Widget> hyperRangeWidget = [];
  List<Widget> hypoRangeWidget = [];

  BloodGlucosePatientPickerVm(this.context) {
    buildHyperRange();
    buildHypoRange();
    buildNormalRange();
  }

  setThumbStartValue(int startValue) {
    this._startValue = _startValue;
    notifyListeners();
  }

  int get thumbStartValue => this._startValue;

  LoadingProgress get stateProcess => _stateProcess;

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
      hypoRangeWidget.add(Center(child: Text(number.toString())));
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
      hyperRangeWidget.add(Center(child: Text(number.toString())));
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
    this._stateProcess = LoadingProgress.LOADING;
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
      this._stateProcess = LoadingProgress.DONE;
      hideDialog(context);
      await Future.delayed(Duration(milliseconds: 300));
      Navigator.pop(context, true);
    } catch (e) {
      LoggerUtils.instance.i(e);
      hideDialog(context);
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      this._stateProcess = LoadingProgress.ERROR;
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          progressDialog = progressDialog ?? ProgressDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (progressDialog != null && progressDialog.isShowing()) {
      Navigator.of(context).pop();
      progressDialog = null;
    }
  }

  void showInformationDialog(String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(LocaleProvider.current.warning, text);
      },
    ).then((value) => Navigator.pop(context));
  }
}
