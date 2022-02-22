import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/shared/guven_response_model.dart';

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
  void showDiabetsSheet() {
    late int selectedType;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.diabetType),
      initialItem: _getInitialItem(HealthInformationType.diabetType),
      onSelectedItemChanged: (value) {
        if (value == null) {
          selectedType = selection.diabetesType == null
              ? 0
              : selection.diabetesType == 'Type 1'
                  ? 1
                  : selection.diabetesType == 'Type 2'
                      ? 2
                      : 0;
        } else {
          selectedType = value;
        }
      },
      pick: () async {
        switch (selectedType) {
          case 1:
            changeDiabetsType(LocaleProvider.of(mContext).diabetes_type_1);
            break;

          case 2:
            changeDiabetsType(LocaleProvider.of(mContext).diabetes_type_2);
            break;

          default:
            changeDiabetsType(LocaleProvider.of(mContext).non_diabetes);
        }

        _closeBottomSheet();
      },
    );
  }
  // #endregion

  // #region changeDiabetsType
  void changeDiabetsType(String type) {
    selection.diabetesType = type;
    notifyListeners();
  }
  // #endregion

  // #region showHeightSheet
  void showHeightSheet() {
    late int selectedHeight;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.height),
      initialItem: _getInitialItem(HealthInformationType.height),
      onSelectedItemChanged: (value) => selectedHeight = value,
      pick: () {
        changeHeight(selectedHeight);
        _closeBottomSheet();
      },
    );
  }
  // #endregion

  // #region changeHeight
  void changeHeight(int height) {
    selection.height = height.toString();
    notifyListeners();
  }
  // #endregion

  // #region showWeightSheet
  void showWeightSheet() {
    late int selectedWeight;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.weight),
      initialItem: _getInitialItem(HealthInformationType.weight),
      onSelectedItemChanged: (value) => selectedWeight = value,
      pick: () {
        changeWeight(selectedWeight);
        _closeBottomSheet();
      },
    );
  }
  // #endregion

  // #region changeWeight
  void changeWeight(int weight) {
    selection.weight = weight.toString();
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
  void showMaxRangeSheet() {
    late int _selectedMaxRange;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.maxRange),
      initialItem: _getInitialItem(HealthInformationType.maxRange),
      onSelectedItemChanged: (val) =>
          val = _selectedMaxRange = _getMaxRangeList()[val],
      pick: () {
        changeMaxRange(_selectedMaxRange);
        _closeBottomSheet();
      },
    );
  }
  // #endregion

  // #region changeMaxRange
  void changeMaxRange(int selectedHyper) async {
    selection.hyper = selectedHyper < selection.rangeMax!
        ? selection.rangeMax! + 1
        : selectedHyper;
    notifyListeners();
  }
  // #endregion

  // #region showMinRangeSheet
  void showMinRangeSheet() {
    int? _selectedMinRange;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.minRange),
      initialItem: _getInitialItem(HealthInformationType.minRange),
      onSelectedItemChanged: (val) => _selectedMinRange = val,
      pick: () {
        changeMinRange(_selectedMinRange);
        _closeBottomSheet();
      },
    );
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
  void showSmokerSheet() {
    late int selectedType;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.smoker),
      initialItem: _getInitialItem(HealthInformationType.smoker),
      onSelectedItemChanged: (value) {
        if (value != null) {
          selectedType = selection.smoker == null
              ? 0
              : selection.smoker ?? false
                  ? 0
                  : 1;
        } else {
          selectedType = value;
        }
      },
      pick: () async {
        switch (selectedType) {
          case 0:
            changeSmokerType(false);
            break;

          default:
            changeSmokerType(true);
        }

        _closeBottomSheet();
      },
    );
  }
  // #endregion

  // #region changeSmokerType
  void changeSmokerType(bool type) {
    selection.smoker = type;
    notifyListeners();
  }
  // #endregion

  // #region showDiagnosisSheet
  void showDiagnosisSheet() {
    {
      late int selectedYear;

      _showBottomSheet(
        children: _getChildren(HealthInformationType.yearofDiagnosis),
        initialItem: _getInitialItem(HealthInformationType.yearofDiagnosis),
        onSelectedItemChanged: (value) =>
            selectedYear = (DateTime.now().year - value).toInt(),
        pick: () {
          changeDiagnosis(selectedYear);
          _closeBottomSheet();
        },
      );
    }
  }
  // #endregion

  // #region changeDiagnosis
  void changeDiagnosis(int diagnosis) {
    selection.yearOfDiagnosis = diagnosis;
    notifyListeners();
  }
  // #endregion

  // #region _getInitialItem
  int _getInitialItem(HealthInformationType type) {
    switch (type) {
      case HealthInformationType.diabetType:
        {
          return selection.diabetesType == "Type 1"
              ? 1
              : (selection.diabetesType == "Type 2" ? 2 : 0);
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
    TextStyle _bottomTextStyle = mContext.xHeadline2;

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

  // #region _showBottomSheet
  void _showBottomSheet({
    required List<Widget> children,
    required int initialItem,
    required void Function(dynamic) onSelectedItemChanged,
    required void Function() pick,
  }) {
    showModalBottomSheet(
      context: mContext,
      builder: (BuildContext builder) {
        return RbioSelectBottomSheet(
          children: children,
          initalItem: initialItem,
          onSelectedItemChanged: onSelectedItemChanged,
          pick: pick,
        );
      },
    );
  }
  // #endregion

  // #region _closeBottomSheet
  void _closeBottomSheet() {
    Navigator.pop(mContext);
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
    diabetTypeController.text = selection.diabetesType ?? '';
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
