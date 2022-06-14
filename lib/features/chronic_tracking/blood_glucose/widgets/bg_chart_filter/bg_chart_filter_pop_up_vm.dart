import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class BgChartFilterPopUpVm extends ChangeNotifier {
  Map<GlucoseMarginsFilter, bool> filters;

  BgChartFilterPopUpVm({
    required this.filters,
  });

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
        getIt<IAppConfig>().theme.veryLow, () => GlucoseMarginsFilter.veryLow);
    _colorInfo.putIfAbsent(
        getIt<IAppConfig>().theme.low, () => GlucoseMarginsFilter.low);
    _colorInfo.putIfAbsent(
        getIt<IAppConfig>().theme.target, () => GlucoseMarginsFilter.target);
    _colorInfo.putIfAbsent(
        getIt<IAppConfig>().theme.high, () => GlucoseMarginsFilter.high);
    _colorInfo.putIfAbsent(getIt<IAppConfig>().theme.veryHigh,
        () => GlucoseMarginsFilter.veryHigh);
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
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stk);
      debugPrintStack(stackTrace: stk);
    }
  }
}
