import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../glucose_margins_filter.dart';

class BgFilterPopUpVm extends ChangeNotifier {
  BgFilterPopUpVm({required this.filters});
  Map<GlucoseMarginsFilter, bool> filters;

  changeFilter(GlucoseMarginsFilter data) {
    filters[data] = !filters[data]!;
    notifyListeners();
  }

  bool isFilterSelected(GlucoseMarginsFilter filter) {
    return filters[filter]!;
  }

  final Map<Color, GlucoseMarginsFilter> _colorInfo =
      <Color, GlucoseMarginsFilter>{};
  Map<Color, GlucoseMarginsFilter> get colorInfo {
    _colorInfo.putIfAbsent(
        R.color.very_low, () => GlucoseMarginsFilter.veryLow);
    _colorInfo.putIfAbsent(R.color.low, () => GlucoseMarginsFilter.low);
    _colorInfo.putIfAbsent(R.color.target, () => GlucoseMarginsFilter.target);
    _colorInfo.putIfAbsent(R.color.high, () => GlucoseMarginsFilter.high);
    _colorInfo.putIfAbsent(
        R.color.very_high, () => GlucoseMarginsFilter.veryHigh);
    return _colorInfo;
  }

  List<GlucoseMarginsFilter> get states => [
        GlucoseMarginsFilter.hungry,
        GlucoseMarginsFilter.full,
        GlucoseMarginsFilter.other
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
