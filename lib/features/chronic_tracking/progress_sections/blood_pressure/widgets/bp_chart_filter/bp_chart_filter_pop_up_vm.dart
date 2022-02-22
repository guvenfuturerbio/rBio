import 'package:flutter/material.dart';

class BpChartFilterPopUpVm extends ChangeNotifier {
  Map<String, bool> measurements = {};
  BpChartFilterPopUpVm({required this.measurements});

  changeFilter(String key) {
    measurements[key] = !measurements[key]!;
    notifyListeners();
  }
}
