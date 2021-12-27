import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/data/imports/cronic_tracking.dart';

enum HealthInformationType {
  DiabetType,
  Weight,
  NormalRange,
  Height,
  MaxRange,
  MinRange,
  Smoker,
  YearofDiagnosis,
}

class HealthInformationVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  bool _showProgressOverlay = false;
  bool get showProgressOverlay => _showProgressOverlay;
  set showProgressOverlay(bool value) {
    _showProgressOverlay = value;
    notifyListeners();
  }

  var key;
  Person _selection;
  Person get selection => _selection;

  HealthInformationVm({BuildContext context}) {
    this.mContext = context;
    _selection = getIt<ProfileStorageImpl>().getFirst();
    key = _selection.key;
    _selection = _selection.copy();
  }

  Future<void> updateInformation(Person person) async {
    showProgressOverlay = true;
    try {
      person.isFirstUser = false;
      person.userId = -1;
      final response = await getIt<ChronicTrackingRepository>()
          .updateProfile(person, person.id);
      if (response.isSuccessful) {
        getIt<ProfileStorageImpl>().update(_selection, key);
      }
    } catch (e, stackTrace) {
      showDefaultErrorDialog(e, stackTrace);
    } finally {
      showProgressOverlay = false;
    }
  }

  // #region showDiabetsSheet
  void showDiabetsSheet() {
    var selectedType;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.DiabetType),
      initialItem: _getInitialItem(HealthInformationType.DiabetType),
      onSelectedItemChanged: (value) {
        if (value == null) {
          selectedType = _selection.diabetesType == null
              ? 0
              : _selection.diabetesType == 'Type 1'
                  ? 1
                  : _selection.diabetesType == 'Type 2'
                      ? 2
                      : 0;
        } else {
          selectedType = value;
        }
      },
      pick: () async {
        switch (selectedType) {
          case 1:
            changeDiabetsType('${LocaleProvider.current.diabetes_type_1}');
            break;

          case 2:
            changeDiabetsType('${LocaleProvider.current.diabetes_type_2}');
            break;

          default:
            changeDiabetsType('${LocaleProvider.current.non_diabetes}');
        }

        _closeBottomSheet();
      },
    );
  }
  // #endregion

  // #region changeDiabetsType
  void changeDiabetsType(String type) {
    _selection.diabetesType = type;
    notifyListeners();
  }
  // #endregion

  // #region showHeightSheet
  void showHeightSheet() {
    var selectedHeight;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.Height),
      initialItem: _getInitialItem(HealthInformationType.Height),
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
    _selection.height = height.toString();
    notifyListeners();
  }
  // #endregion

  // #region showWeightSheet
  void showWeightSheet() {
    var selectedWeight;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.Weight),
      initialItem: _getInitialItem(HealthInformationType.Weight),
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
    _selection.weight = weight.toString();
    notifyListeners();
  }
  // #endregion

  // #region changeNormalRange
  void changeNormalRange(Map<String, dynamic> value) {
    if (value['min'] != null && value['max'] != null) {
      _selection.rangeMin = value['min'];
      _selection.rangeMax = value['max'];
    }
    notifyListeners();
  }
  // #endregion

  // #region showMaxRangeSheet
  void showMaxRangeSheet() {
    var _selectedMaxRange;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.MaxRange),
      initialItem: _getInitialItem(HealthInformationType.MaxRange),
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
    _selection.hyper = selectedHyper < _selection.rangeMax
        ? _selection.rangeMax + 1
        : selectedHyper;
    notifyListeners();
  }
  // #endregion

  // #region showMinRangeSheet
  void showMinRangeSheet() {
    var _selectedMinRange;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.MinRange),
      initialItem: _getInitialItem(HealthInformationType.MinRange),
      onSelectedItemChanged: (val) => _selectedMinRange = val,
      pick: () {
        changeMinRange(_selectedMinRange);
        _closeBottomSheet();
      },
    );
  }
  // #endregion

  // #region changeMinRange
  void changeMinRange(int selectedMinRange) {
    if (selectedMinRange != null) {
      var _tempHypo = selectedMinRange * 10;
      _selection.hypo =
          _tempHypo > _selection.rangeMin ? _selection.rangeMin - 1 : _tempHypo;
      notifyListeners();
    }
  }
  // #endregion

  // #region showSmokerSheet
  void showSmokerSheet() {
    var selectedType;

    _showBottomSheet(
      children: _getChildren(HealthInformationType.Smoker),
      initialItem: _getInitialItem(HealthInformationType.Smoker),
      onSelectedItemChanged: (value) {
        if (value != null) {
          selectedType = _selection.smoker == null
              ? 0
              : _selection.smoker
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
    _selection.smoker = type;
    notifyListeners();
  }
  // #endregion

  // #region showDiagnosisSheet
  void showDiagnosisSheet() {
    {
      var selectedYear;

      _showBottomSheet(
        children: _getChildren(HealthInformationType.YearofDiagnosis),
        initialItem: _getInitialItem(HealthInformationType.YearofDiagnosis),
        onSelectedItemChanged: (value) =>
            selectedYear = DateTime.now().year - value,
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
    _selection.yearOfDiagnosis = diagnosis;
    notifyListeners();
  }
  // #endregion

  // #region _getInitialItem
  int _getInitialItem(HealthInformationType type) {
    switch (type) {
      case HealthInformationType.DiabetType:
        {
          return _selection.diabetesType == "Type 1"
              ? 1
              : (_selection.diabetesType == "Type 2" ? 2 : 0);
        }

      case HealthInformationType.Height:
        {
          return int.parse(_selection.height) ?? 150;
        }

      case HealthInformationType.Weight:
        return _selection.weight == 'null'
            ? 0
            : int.parse(_selection.weight) ?? 50;

      case HealthInformationType.Smoker:
        {
          return _selection.smoker == null
              ? 0
              : _selection.smoker
                  ? 1
                  : 0;
        }

      case HealthInformationType.YearofDiagnosis:
        {
          return _selection.yearOfDiagnosis != null
              ? DateTime.now().year - _selection.yearOfDiagnosis
              : 0;
        }

      case HealthInformationType.MaxRange:
        {
          return _getMaxRangeList().indexOf(_selection.hyper);
        }

      case HealthInformationType.MinRange:
        {
          return _selection.hypo ~/ 10;
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
      case HealthInformationType.DiabetType:
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

      case HealthInformationType.Height:
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

      case HealthInformationType.Weight:
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

      case HealthInformationType.Smoker:
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

      case HealthInformationType.YearofDiagnosis:
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

      case HealthInformationType.MaxRange:
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

      case HealthInformationType.MinRange:
        {
          return List.generate(
            (_selection.rangeMin + 10) ~/ 10,
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
    for (int i = _selection.rangeMax; i < 1000; i = i + 10) {
      hyperWidget.add(i);
    }
    return hyperWidget;
  }
  // #endregion

  // #region _showBottomSheet
  void _showBottomSheet({
    List<Widget> children,
    int initialItem,
    void Function(dynamic) onSelectedItemChanged,
    void Function() pick,
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
    TextEditingController diabetTypeController,
    TextEditingController weightController,
    TextEditingController normalRangeController,
    TextEditingController heightController,
    TextEditingController maxRangeController,
    TextEditingController minRangeController,
    TextEditingController smokerController,
    TextEditingController yearofDiagnosisController,
  }) {
    diabetTypeController.text = selection.diabetesType;
    weightController.text = "${selection.weight} kg";
    normalRangeController.text =
        "${selection.rangeMin}-${selection.rangeMax} mg/dl";
    heightController.text = "${selection.height} cm";
    maxRangeController.text = "${selection.hyper} mg/dl";
    minRangeController.text = "${selection.hypo} mg/dl";
    smokerController.text = "${selection.smoker}";
    yearofDiagnosisController.text = "${selection.yearOfDiagnosis}";
  }
  // #endregion
}
