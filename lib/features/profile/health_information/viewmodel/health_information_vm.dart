import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/utils/logger_helper.dart';

import '../../../../core/core.dart';

enum HealthInformationType {
  diabetType,
  weight,
  normalRange,
  height,
  maxRange,
  minRange,
  smoker,
  yearofDiagnosis,
}

class HealthInformationVm extends RbioVm {
  @override
  BuildContext mContext;

  bool _showProgressOverlay = false;
  bool get showProgressOverlay => _showProgressOverlay;
  set showProgressOverlay(bool value) {
    _showProgressOverlay = value;
    notifyListeners();
  }

  dynamic key;
  late Person selection;

  HealthInformationVm(this.mContext) {
    selection = getIt<ProfileStorageImpl>().getFirst();
    key = selection.key;
    selection = selection.copy();
  }

  Future<void> updateInformation(Person person) async {
    showProgressOverlay = true;
    try {
      person.isFirstUser = false;
      person.userId = -1;
      final response = await getIt<ChronicTrackingRepository>().updateProfile(
        person,
        person.id!,
      );
      if (response.xIsSuccessful) {
        getIt<ProfileStorageImpl>().update(selection, key);
      }
    } catch (e, stackTrace) {
      showDefaultErrorDialog(e, stackTrace);
    } finally {
      showProgressOverlay = false;
    }
  }

  // #region showDiabetsSheet
  Future<void> showDiabetsSheet() async {
    final result = await showRbioSelectBottomSheet(
      mContext,
      title: LocaleProvider.current.diabet_type,
      children: _getChildren(HealthInformationType.diabetType),
      initialItem: _getInitialItem(HealthInformationType.diabetType),
    );

    if (result != null) {
      switch (result) {
        case 1:
          changeDiabetsType(LocaleProvider.of(mContext).diabetes_type_1);
          break;

        case 2:
          changeDiabetsType(LocaleProvider.of(mContext).diabetes_type_2);
          break;

        default:
          changeDiabetsType(LocaleProvider.of(mContext).non_diabetes);
      }
    }
  }
  // #endregion

  // #region changeDiabetsType
  void changeDiabetsType(String type) {
    selection.diabetesType = type;
    notifyListeners();
  }
  // #endregion

  // #region showHeightSheet
  Future<void> showHeightSheet() async {
    final result = await showRbioSelectBottomSheet(
      mContext,
      title: LocaleProvider.current.height,
      children: _getChildren(HealthInformationType.height),
      initialItem: _getInitialItem(HealthInformationType.height),
    );

    if (result != null) {
      final selectedHeight = result;
      changeHeight(selectedHeight);
    }
  }
  // #endregion

  // #region changeHeight
  void changeHeight(int? height) {
    if (height != null) {
      selection.height = height.toString();
    }
    notifyListeners();
  }
  // #endregion

  // #region showWeightSheet
  Future<void> showWeightSheet() async {
    final result = await showRbioSelectBottomSheet(
      mContext,
      title: LocaleProvider.current.weight,
      children: _getChildren(HealthInformationType.weight),
      initialItem: _getInitialItem(HealthInformationType.weight),
    );

    if (result != null) {
      final selectedWeight = result;
      changeWeight(selectedWeight);
    }
  }
  // #endregion

  // #region changeWeight
  void changeWeight(int? weight) {
    if (weight != null) {
      selection.weight = weight.toString();
    }
    notifyListeners();
  }
  // #endregion

  // #region changeNormalRange
  void changeNormalRange(Map<dynamic, dynamic> value) {
    if (value['min'] != null && value['max'] != null) {
      selection.rangeMin = value['min'];
      selection.rangeMax = value['max'];
    }
    notifyListeners();
  }
  // #endregion

  // #region showMaxRangeSheet
  Future<void> showMaxRangeSheet() async {
    final result = await showRbioSelectBottomSheet(
      mContext,
      title: LocaleProvider.current.max_range,
      children: _getChildren(HealthInformationType.maxRange),
      initialItem: _getInitialItem(HealthInformationType.maxRange),
    );

    if (result != null) {
      final _selectedMaxRange = _getMaxRangeList()[result];
      changeMaxRange(_selectedMaxRange);
    }
  }
  // #endregion

  // #region changeMaxRange
  void changeMaxRange(int? selectedHyper) async {
    if (selectedHyper != null) {
      selection.hyper = selectedHyper < selection.rangeMax!
          ? selection.rangeMax! + 1
          : selectedHyper;
    }
    notifyListeners();
  }
  // #endregion

  // #region showMinRangeSheet
  Future<void> showMinRangeSheet() async {
    final result = await showRbioSelectBottomSheet(
      mContext,
      title: LocaleProvider.current.min_range,
      children: _getChildren(HealthInformationType.minRange),
      initialItem: _getInitialItem(HealthInformationType.minRange),
    );

    if (result != null) {
      final _selectedMinRange = result;
      changeMinRange(_selectedMinRange);
    }
  }
  // #endregion

  // #region changeMinRange
  void changeMinRange(int? selectedMinRange) {
    if (selectedMinRange != null) {
      var _tempHypo = selectedMinRange * 10;
      selection.hypo =
          _tempHypo > selection.rangeMin! ? selection.rangeMin! - 1 : _tempHypo;
      notifyListeners();
    }
  }
  // #endregion

  // #region showSmokerSheet
  Future<void> showSmokerSheet() async {
    final result = await showRbioSelectBottomSheet(
      mContext,
      title: LocaleProvider.current.do_you_smoke,
      children: _getChildren(HealthInformationType.smoker),
      initialItem: _getInitialItem(HealthInformationType.smoker),
    );

    if (result != null) {
      switch (result) {
        case 0:
          changeSmokerType(false);
          break;

        default:
          changeSmokerType(true);
      }
    }
  }
  // #endregion

  // #region changeSmokerType
  void changeSmokerType(bool type) {
    selection.smoker = type;
    notifyListeners();
  }
  // #endregion

  // #region showDiagnosisSheet
  Future<void> showDiagnosisSheet() async {
    {
      final result = await showRbioSelectBottomSheet(
        mContext,
        title: LocaleProvider.current.year_of_diagnosis,
        children: _getChildren(HealthInformationType.yearofDiagnosis),
        initialItem: _getInitialItem(HealthInformationType.yearofDiagnosis),
      );

      if (result != null) {
        final selectedYear = (DateTime.now().year - result).toInt();
        changeDiagnosis(selectedYear);
      }
    }
  }
  // #endregion

  // #region changeDiagnosis
  void changeDiagnosis(int? diagnosis) {
    if (diagnosis != null) {
      selection.yearOfDiagnosis = diagnosis;
    }
    notifyListeners();
  }
  // #endregion

  // #region _getInitialItem
  int _getInitialItem(HealthInformationType type) {
    switch (type) {
      case HealthInformationType.diabetType:
        {
          return (selection.diabetesType == "Type 1" ||
                  selection.diabetesType == "Tip 1")
              ? 1
              : ((selection.diabetesType == "Type 2" ||
                      selection.diabetesType == "Tip 2")
                  ? 2
                  : 0);
        }

      case HealthInformationType.height:
        {
          return int.tryParse(selection.height ?? '170') ?? 150;
        }

      case HealthInformationType.weight:
        return selection.weight == 'null'
            ? 0
            : int.tryParse(selection.weight ?? '70') ?? 50;

      case HealthInformationType.smoker:
        {
          return selection.smoker == null
              ? 0
              : selection.smoker ?? false
                  ? 1
                  : 0;
        }

      case HealthInformationType.yearofDiagnosis:
        {
          return selection.yearOfDiagnosis != null
              ? DateTime.now().year - (selection.yearOfDiagnosis ?? 2001)
              : 0;
        }

      case HealthInformationType.maxRange:
        {
          return _getMaxRangeList().indexOf(selection.hyper!);
        }

      case HealthInformationType.minRange:
        {
          return selection.hypo! ~/ 10;
        }

      default:
        throw Exception('Undefined type.');
    }
  }
  // #endregion

  // #region _getChildren
  List<Widget> _getChildren(HealthInformationType type) {
    TextStyle _bottomTextStyle =
        CupertinoTheme.of(mContext).textTheme.dateTimePickerTextStyle;

    switch (type) {
      case HealthInformationType.diabetType:
        {
          return [
            Center(
              child: Text(
                LocaleProvider.of(mContext).non_diabetes,
                style: _bottomTextStyle,
              ),
            ),
            Center(
              child: Text(
                LocaleProvider.of(mContext).diabetes_type_1,
                style: _bottomTextStyle,
              ),
            ),
            Center(
              child: Text(
                LocaleProvider.of(mContext).diabetes_type_2,
                style: _bottomTextStyle,
              ),
            ),
          ];
        }

      case HealthInformationType.height:
        {
          return List.generate(
            250,
            (index) => Center(
              child: Text(
                '$index cm',
                style: _bottomTextStyle,
              ),
            ),
          );
        }

      case HealthInformationType.weight:
        {
          return List.generate(
            250,
            (index) => Center(
              child: Text(
                '$index kg',
                style: _bottomTextStyle,
              ),
            ),
          );
        }

      case HealthInformationType.smoker:
        {
          return [
            Center(
              child: Text(
                LocaleProvider.of(mContext).non_smoker,
                style: _bottomTextStyle,
              ),
            ),
            Center(
              child: Text(
                LocaleProvider.of(mContext).smoker,
                style: _bottomTextStyle,
              ),
            ),
          ];
        }

      case HealthInformationType.yearofDiagnosis:
        {
          return List.generate(
            100,
            (index) => Center(
              child: Text(
                '${DateTime.now().year - index}',
                style: _bottomTextStyle,
              ),
            ),
          );
        }

      case HealthInformationType.maxRange:
        {
          return _getMaxRangeList()
              .map(
                (e) => Center(
                  child: Text(
                    (e).toString() + " mg/dL.",
                    style: _bottomTextStyle,
                  ),
                ),
              )
              .toList();
        }

      case HealthInformationType.minRange:
        {
          return List.generate(
            (selection.rangeMin ?? 50 + 10) ~/ 10,
            (index) => Center(
              child: Text(
                (index * 10).toString() + " mg/dL.",
                style: _bottomTextStyle,
              ),
            ),
          );
        }

      default:
        throw Exception('Undefined type.');
    }
  }
  // #endregion

  // #region _getMaxRangeList
  List<int> _getMaxRangeList() {
    List<int> hyperWidget = [];
    for (int i = selection.rangeMax ?? 50; i < 1000; i = i + 10) {
      hyperWidget.add(i);
    }
    return hyperWidget;
  }
  // #endregion

  // #region changeTextFiels
  void changeTextFiels({
    required TextEditingController diabetTypeController,
    required TextEditingController weightController,
    required TextEditingController normalRangeController,
    required TextEditingController heightController,
    required TextEditingController maxRangeController,
    required TextEditingController minRangeController,
    required TextEditingController smokerController,
    required TextEditingController yearofDiagnosisController,
  }) {
    diabetTypeController.text = selection.diabetesType == 'Non-Diabetes'
        ? LocaleProvider.current.non_diabetes
        : selection.diabetesType ?? '';
    weightController.text = "${selection.weight} kg";
    normalRangeController.text =
        "${selection.rangeMin}-${selection.rangeMax} mg/dl";
    heightController.text = "${selection.height} cm";
    maxRangeController.text = "${selection.hyper} mg/dl";
    minRangeController.text = "${selection.hypo} mg/dl";
    smokerController.text = selection.smoker ?? false
        ? LocaleProvider.current.smoker
        : LocaleProvider.current.non_smoker;
    yearofDiagnosisController.text = "${selection.yearOfDiagnosis}";
  }
  // #endregion
}
