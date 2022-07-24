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

  Map<Color, GlucoseMarginsFilter> colorInfo(BuildContext context) {
    _colorInfo.putIfAbsent(
      context.xMyCustomTheme.roman,
      () => GlucoseMarginsFilter.veryLow,
    );
    _colorInfo.putIfAbsent(
      context.xMyCustomTheme.tonysPink,
      () => GlucoseMarginsFilter.low,
    );
    _colorInfo.putIfAbsent(
      context.xMyCustomTheme.deYork,
      () => GlucoseMarginsFilter.target,
    );
    _colorInfo.putIfAbsent(
      context.xMyCustomTheme.energyYellow,
      () => GlucoseMarginsFilter.high,
    );
    _colorInfo.putIfAbsent(
      context.xMyCustomTheme.casablanca,
      () => GlucoseMarginsFilter.veryHigh,
    );
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
