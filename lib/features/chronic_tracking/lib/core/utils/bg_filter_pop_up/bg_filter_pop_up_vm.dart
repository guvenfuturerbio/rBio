import 'package:flutter/material.dart';

import '../../../helper/resources.dart';
import '../../../widgets/utils/glucose_margins_filter.dart';

class BgFilterPopUpVm extends ChangeNotifier {
  BgFilterPopUpVm({this.filters});
  Map<GlucoseMarginsFilter, bool> filters;

  changeFilter(GlucoseMarginsFilter data) {
    filters[data] = !filters[data];
    notifyListeners();
  }

  bool isFilterSelected(GlucoseMarginsFilter filter) {
    return filters[filter];
  }

  Map<Color, GlucoseMarginsFilter> _colorInfo = <Color, GlucoseMarginsFilter>{};
  Map<Color, GlucoseMarginsFilter> get colorInfo {
    _colorInfo.putIfAbsent(
        R.color.very_low, () => GlucoseMarginsFilter.VERY_LOW);
    _colorInfo.putIfAbsent(R.color.low, () => GlucoseMarginsFilter.LOW);
    _colorInfo.putIfAbsent(R.color.target, () => GlucoseMarginsFilter.TARGET);
    _colorInfo.putIfAbsent(R.color.high, () => GlucoseMarginsFilter.HIGH);
    _colorInfo.putIfAbsent(
        R.color.very_high, () => GlucoseMarginsFilter.VERY_HIGH);
    return this._colorInfo;
  }

  List<GlucoseMarginsFilter> get states => [
        GlucoseMarginsFilter.HUNGRY,
        GlucoseMarginsFilter.FULL,
        GlucoseMarginsFilter.OTHER
      ];

  resetFilterValues() async {
    try {
      filters.forEach((key, value) {
        filters[key] = true;
      });
      notifyListeners();
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }
}
