import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class ScaleFilterPopupVm extends ChangeNotifier {
  ScaleFilterPopupVm({SelectedScaleType? scaleType}) {
    _selectedScaleType = scaleType;
  }

  List<SelectedScaleType> filterList = [
    SelectedScaleType.weight,
    SelectedScaleType.bmi,
    SelectedScaleType.bodyFat,
    SelectedScaleType.muscle,
    SelectedScaleType.visceralFat,
    SelectedScaleType.water,
  ];

  SelectedScaleType? _selectedScaleType;
  SelectedScaleType get selectedScaleType =>
      _selectedScaleType ?? SelectedScaleType.weight;
  changeScaleType(SelectedScaleType? type) {
    _selectedScaleType = type;
    notifyListeners();
  }
}
