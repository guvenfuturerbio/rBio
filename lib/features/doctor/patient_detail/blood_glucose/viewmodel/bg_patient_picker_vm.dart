part of '../view/bg_patient_detail_screen.dart';

class BgPatientPickerVm extends ChangeNotifier {
  BuildContext context;

  BgPatientPickerVm(this.context) {
    buildHyperRange();
    buildHypoRange();
    buildNormalRange();
  }

  int? _startValue, _endValue;
  LoadingProgress? _stateProcess;
  ProgressDialog? progressDialog;
  double? _lowerValue, _higherValue, _hypoValue, _hyperValue;

  List<int> min = [];
  List<int> max = [];
  List<int> hyperRange = [];
  List<int> hypoRange = [];
  List<Text> minWidget = [];
  List<Text> maxWidget = [];
  List<Widget> hyperRangeWidget = [];
  List<Widget> hypoRangeWidget = [];

  setThumbStartValue(int startValue) {
    _startValue = _startValue;
    notifyListeners();
  }

  int get thumbStartValue => _startValue ?? 0;

  LoadingProgress get stateProcess => _stateProcess ?? LoadingProgress.loading;

  setThumbEndValue(int endValue) {
    _endValue = _endValue;
    notifyListeners();
  }

  get hypoValue =>
      _hypoValue ??
      Provider.of<PatientNotifiers>(context, listen: false).patientDetail.hypo;

  get lowerValue =>
      _lowerValue ??
      Provider.of<PatientNotifiers>(context, listen: false)
          .patientDetail
          .rangeMin;

  get higherValue =>
      _higherValue ??
      Provider.of<PatientNotifiers>(context, listen: false)
          .patientDetail
          .rangeMax;

  get hyperValue =>
      _hyperValue ??
      Provider.of<PatientNotifiers>(context, listen: false).patientDetail.hyper;

  setTargetRange(var lowerValue, var higherValue) {
    _lowerValue = lowerValue;
    _higherValue = higherValue;

    notifyListeners();
  }

  setHypoValue(var value) {
    _hypoValue = value;

    buildHypoRange();
    notifyListeners();
  }

  setHyperValue(var value) {
    _hyperValue = value;
    buildHyperRange();
  }

  List<int> buildHypoRange() {
    hypoRange = [];
    hypoRangeWidget = [];
    for (int i = 0; i < lowerValue; i = i + 10) {
      hypoRange.add(i);
    }
    for (var number in hypoRange) {
      hypoRangeWidget.add(Center(child: Text(number.toString())));
    }
    return hypoRange;
  }

  List<int> buildHyperRange() {
    hyperRange = [];
    hyperRangeWidget = [];
    for (int i = higherValue; i < 1000; i = i + 10) {
      hyperRange.add(i);
    }
    for (var number in hyperRange) {
      hyperRangeWidget.add(Center(child: Text(number.toString())));
    }
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
    for (var number in min) {
      minWidget.add(Text(number.toString()));
    }
    for (var number in max) {
      maxWidget.add(Text(number.toString()));
    }
    notifyListeners();
  }

  updatePatientLimit({required int id}) async {
    _stateProcess = LoadingProgress.loading;
    showLoadingDialog();
    await Future.delayed(const Duration(milliseconds: 300));
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
      _stateProcess = LoadingProgress.done;
      hideDialog(context);
      await Future.delayed(const Duration(milliseconds: 300));
      Navigator.pop(context, true);
    } catch (e) {
      LoggerUtils.instance.i(e);
      hideDialog(context);
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      _stateProcess = LoadingProgress.error;
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          progressDialog = progressDialog ?? const ProgressDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (progressDialog != null && progressDialog!.isShowing()) {
      Navigator.of(context).pop();
      progressDialog = null;
    }
  }

  void showInformationDialog(String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(
            title: LocaleProvider.current.warning, text: text);
      },
    ).then((value) => Navigator.pop(context));
  }
}
