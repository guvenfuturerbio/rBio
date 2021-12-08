import 'package:flutter/material.dart';

import '../../../../utils/selected_scale_type.dart';

class ScaleFilterPopupVm extends ChangeNotifier {
  ScaleFilterPopupVm({SelectedScaleType scaleType}) {
    _selectedScaleType = scaleType;
  }

  List<SelectedScaleType> filterList = [
    SelectedScaleType.WEIGHT,
    SelectedScaleType.BMI,
    SelectedScaleType.BODY_FAT,
    SelectedScaleType.MUSCLE,
    SelectedScaleType.VISCERAL_FAT,
    SelectedScaleType.WATER,
  ];

  SelectedScaleType _selectedScaleType;
  SelectedScaleType get selectedScaleType =>
      _selectedScaleType ?? SelectedScaleType.WEIGHT;
  changeScaleType(SelectedScaleType type) {
    _selectedScaleType = type;
    notifyListeners();
  }
}
