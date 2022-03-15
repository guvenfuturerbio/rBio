import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/core.dart';
import '../../../../../core/enums/glucose_margins_filter.dart';
import '../../../../../model/bg_measurement/bg_measurement_view_model.dart';
import '../../../../../model/model.dart';
import '../../../bottom_actions_of_graph.dart';
import '../../widgets/i_progress_screen.dart';
import '../../widgets/small_chronic_component.dart';
import '../view/bg_progress_screen.dart';
import '../widgets/bg_chart_filter/bg_chart_filter_pop_up.dart';
import '../widgets/charts/bg_bubble_chart.dart';
import '../widgets/charts/bg_line_chart.dart';
import '../widgets/tagger/bg_tagger_pop_up.dart';

enum GraphType { bubble, line }

class BgProgressVm
    with ChangeNotifier, IBaseBottomActionsOfGraph
    implements IProgressScreen {
  BgProgressVm({required BuildContext context}) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      isChartShow = true;
      getIt<GlucoseStorageImpl>().addListener(() {
        setSelectedItem(selected);
      });

      fetchBgMeasurement();
      fetchScrolledDailyData();

      controller.addListener(() {
        if (controller.position.atEdge && controller.position.pixels != 0) {
          getNewItems();
        }
      });
    });
    isChartShow = true;
  }
  bool isChartShow = false;

  @override
  changeChartShowStatus() {
    isChartShow = !isChartShow;
    notifyListeners();
  }

  ScrollController controller = ScrollController();
  bool hasReachEnd = false;
  final List<int> _tags = [1, 2, 3];

  Widget? _currentGraph;

  GraphType? _currentGraphType;

  List<BgMeasurementGlucoseViewModel> bgMeasurementsDailyData = [];

  List<BgMeasurementGlucoseViewModel> bgMeasurements = [];

  List<ChartData> _chartData = [];

  List<ChartData> _chartVeryLow = [];

  List<ChartData> _chartLow = [];

  List<ChartData> _chartTarget = [];

  List<ChartData> _chartHigh = [];

  List<ChartData> _chartVeryHigh = [];

  int? _scrolledListIndex;

  int? _listLastIndex;

  TimePeriodFilter? _selectedItem;

  DateTime? _startDate, _endDate;

  int _currentDateIndex = 0;

  final Map<int, List<ChartData>> _chartDataTagged = <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartVeryLowTagged =
      <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartLowTagged = <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartTargetTagged = <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartHighTagged = <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartVeryHighTagged =
      <int, List<ChartData>>{};

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

  DateTime? _scrolledDate;

  List<GlucoseMarginsFilter> get states => [
        GlucoseMarginsFilter.hungry,
        GlucoseMarginsFilter.full,
        GlucoseMarginsFilter.other
      ];

  Map<GlucoseMarginsFilter, bool> _filterState = <GlucoseMarginsFilter, bool>{};

  Map<GlucoseMarginsFilter, bool> _lastFilterStateBeforeEdit =
      <GlucoseMarginsFilter, bool>{};

  Map<GlucoseMarginsFilter, bool> get filterState {
    _filterState.putIfAbsent(GlucoseMarginsFilter.veryLow, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.low, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.target, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.high, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.veryHigh, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.hungry, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.full, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.other, () => true);
    return _filterState;
  }

  Future<void> setFilterState(GlucoseMarginsFilter key) async {
    try {
      _filterState.update(key, (value) => !filterState[key]!);
      notifyListeners();
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }

  void updateFilterState() {
    try {
      _lastFilterStateBeforeEdit = <GlucoseMarginsFilter, bool>{};
      updateBgMeasurement();
      notifyListeners();
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }

  cancelSelections() {
    _filterState = _lastFilterStateBeforeEdit;
    _lastFilterStateBeforeEdit = <GlucoseMarginsFilter, bool>{};
    notifyListeners();
  }

  /// Connected with filter dialog bottom button.
  /// This function convert all [_filterState] boolean value to [true]
  resetFilterValues() async {
    try {
      _filterState.forEach((key, value) {
        _filterState[key] = true;
      });
      notifyListeners();
      updateBgMeasurement();
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }

  bool isFilterSelected(GlucoseMarginsFilter filter) {
    return filterState[filter] ?? false;
  }

  List<int> get tags => _tags;

  Map<int, List<ChartData>> get chartDataTagged => _chartDataTagged;

  Map<int, List<ChartData>> get chartVeryLowTagged => _chartVeryLowTagged;

  Map<int, List<ChartData>> get chartLowTagged => _chartLowTagged;

  Map<int, List<ChartData>> get chartTargetTagged => _chartTargetTagged;

  Map<int, List<ChartData>> get chartHighTagged => _chartHighTagged;

  Map<int, List<ChartData>> get chartVeryHighTagged => _chartVeryHighTagged;

  int get targetMin => getIt<ProfileStorageImpl>().getFirst().rangeMin!;

  int get targetMax => getIt<ProfileStorageImpl>().getFirst().rangeMax!;

  int get criticMin => getIt<ProfileStorageImpl>().getFirst().hypo!;

  int get criticMax => getIt<ProfileStorageImpl>().getFirst().hyper!;

  int get dailyHighestValue {
    int highest = bgMeasurementsDailyData.isNotEmpty
        ? (double.tryParse(bgMeasurementsDailyData[0].result) ?? 0).toInt()
        : 300;
    for (var data in bgMeasurementsDailyData) {
      if (double.parse(data.result).toInt() > highest) {
        highest = double.parse(data.result).toInt();
      }
    }
    return highest > targetMax ? highest + 50 : targetMax + 50;
  }

  int get dailyLowestValue {
    int lowest = bgMeasurementsDailyData.isNotEmpty
        ? (double.tryParse(bgMeasurementsDailyData[0].result) ?? 0).toInt()
        : 50;
    for (var data in bgMeasurementsDailyData) {
      if (double.parse(data.result).toInt() < lowest) {
        lowest = double.parse(data.result).toInt();
      }
    }
    return 0; //lowest < targetMin ?  targetMin - 50 : lowest;
  }

  int get highestValue {
    int highest =
        bgMeasurements.isNotEmpty ? int.parse(bgMeasurements[0].result) : 300;
    for (var data in bgMeasurements) {
      if (double.parse(data.result).toInt() > highest) {
        highest = double.parse(data.result).toInt();
      }
    }
    return 300;
    //return targetMax + targetMin;
  }

  int get lowestValue {
    int lowest =
        bgMeasurements.isNotEmpty ? int.parse(bgMeasurements[0].result) : 50;
    for (var data in bgMeasurements) {
      if (double.parse(data.result).toInt() < lowest) {
        lowest = double.parse(data.result).toInt();
      }
    }
    return 0;
    //return 0;
  }

  int get totalValuableCount {
    int totalCount = 0;
    for (var data in _chartData) {
      if (data.y > 0) {
        totalCount++;
      }
    }
    return totalCount;
  }

  Widget get currentGraph => _currentGraph ?? const BgBubbleChart();

  void setCurrentGraph() {
    currentGraphType == GraphType.bubble
        ? _currentGraph = const BgBubbleChart()
        : _currentGraph = const BgLineChart();
    notifyListeners();
  }

  GraphType get currentGraphType => _currentGraphType ?? GraphType.bubble;

  /// MG13
  @override
  void changeGraphType() {
    if (currentGraphType == GraphType.bubble) {
      _currentGraphType = GraphType.line;
    } else {
      _currentGraphType = GraphType.bubble;
    }
    setCurrentGraph();
    notifyListeners();
  }

  List<TimePeriodFilter> get items => [
        TimePeriodFilter.daily,
        TimePeriodFilter.weekly,
        TimePeriodFilter.monthly,
        TimePeriodFilter.monthlyThree,
        TimePeriodFilter.spesific
      ];

  TimePeriodFilter get selected => _selectedItem ?? items[0];

  /// MG13
  Future<void> setSelectedItem(TimePeriodFilter s) async {
    resetFilterState();
    _currentDateIndex = 0;
    _selectedItem = s;
    setCurrentGraph();
    if (s == TimePeriodFilter.spesific) {
      fetchBgMeasurement();
      fetchSpesificData();
    } else if (s == TimePeriodFilter.daily) {
      fetchBgMeasurement();
      fetchScrolledDailyData();
    } else {
      DateTime currentDateEnd = DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 23, 59, 00);
      DateTime currentDateStart = DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 00, 00);
      s == TimePeriodFilter.weekly
          ? await setStartDate(
              currentDateStart.subtract(const Duration(days: 7)))
          : s == TimePeriodFilter.monthly
              ? await setStartDate(currentDateStart
                  .subtract(Duration(days: currentDateStart.day - 1)))
              : s == TimePeriodFilter.monthlyThree
                  ? await setStartDate(DateTime(
                      currentDateStart.year, currentDateStart.month - 3, 1))
                  : await setStartDate(currentDateStart);
      await setEndDate(currentDateEnd);
      setChartAverageDataPerDay();
    }
  }

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate!.year, _startDate!.month, _startDate!.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    _startDate = d;
    _currentDateIndex = 0;
    await getIt<GlucoseStorageImpl>().getAndWriteGlucoseData(
        beginDate: _startDate, endDate: endDate.add(const Duration(days: 1)));
    fetchBgMeasurementsInDateRange(
        startDate, endDate.add(const Duration(days: 1)));

    notifyListeners();
  }

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate!.year, _endDate!.month, _endDate!.day)
      : DateTime(
          DateTime.now().add(const Duration(days: 1)).year,
          DateTime.now().add(const Duration(days: 1)).month,
          DateTime.now().add(const Duration(days: 1)).day);

  Future<void> setEndDate(DateTime d) async {
    _endDate = d;
    _currentDateIndex = 0;
    await getIt<GlucoseStorageImpl>().getAndWriteGlucoseData(
        beginDate: _startDate, endDate: endDate.add(const Duration(days: 1)));
    fetchBgMeasurementsInDateRange(
        startDate, endDate.add(const Duration(days: 1)));

    notifyListeners();
  }

  int get scrolledIndex => _scrolledListIndex ?? 0;

  void setScrolledIndex(int index) {
    if (selected == TimePeriodFilter.daily) {
      setListLastIndex(_scrolledListIndex ?? index);
      _scrolledListIndex = index;
      _scrolledListIndex! > listLastIndex
          ? setCurrentDateIndex(1)
          : _scrolledListIndex! < listLastIndex
              ? setCurrentDateIndex(-1)
              : setCurrentDateIndex(1);
      if (selected == TimePeriodFilter.daily ||
          selected == TimePeriodFilter.spesific) {
        fetchScrolledDailyData();
      }
      notifyListeners();
    }
  }

  int get listLastIndex => _listLastIndex ?? 0;

  void setListLastIndex(int index) {
    _listLastIndex = index;
  }

  int get currentDateIndex => _currentDateIndex;

  void setCurrentDateIndex(int value) {
    _currentDateIndex += value;
    if (_currentDateIndex < 0) {
      _currentDateIndex = 0;
    }
  }

  set currentDateIndex(int val) => _currentDateIndex = val;

  void fetchScrolledData(DateTime date) {
    if (selected == TimePeriodFilter.daily) {
      var _temp = DateTime(_scrolledDate?.year ?? 2000,
          _scrolledDate?.month ?? 01, _scrolledDate?.day ?? 01);
      var _cross = DateTime(date.year, date.month, date.day);
      if ((_temp != _cross)) {
        _scrolledDate = date;
        bgMeasurementsDailyData.clear();

        //LoggerUtils.instance.i("current Date " + reversedList[currentDateIndex].toString());
        for (var data in bgMeasurements) {
          if (DateTime(data.date.year, data.date.month, data.date.day)
              .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
            bgMeasurementsDailyData.add(data);
          }
        }

        setChartDailyData();
      }
    }
  }

  void fetchScrolledDailyData() {
    bgMeasurementsDailyData.clear();
    List<DateTime> dateList = fetchBgMeasurementDates();
    //LoggerUtils.instance.i(dateList.toString());
    List<DateTime> reversedList = dateList.reversed.toList();
    if (reversedList.isNotEmpty) {
      DateTime currentDate = reversedList[currentDateIndex];
      //LoggerUtils.instance.i("current Date " + reversedList[currentDateIndex].toString());
      for (var data in bgMeasurements) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(
                currentDate.year, currentDate.month, currentDate.day))) {
          bgMeasurementsDailyData.add(data);
        }
      }
    }
    setChartDailyData();
  }

  void fetchSpesificData() {
    bgMeasurementsDailyData.clear();
    for (var data in bgMeasurements) {
      if (data.date.difference(_startDate!).inDays >= 0 &&
          data.date.difference(_endDate!).inDays <= 0) {
        bgMeasurementsDailyData.add(data);
      }
    }
    setChartDailyData();
  }

  List<ChartData> get chartData => _chartData;

  void setChartDailyData() {
    List<ChartData> chartData = <ChartData>[];
    for (var data in bgMeasurementsDailyData) {
      chartData.add(ChartData(
          data.date, double.parse(data.result).toInt(), data.resultColor));
    }
    _chartData = chartData;
    _chartVeryHighTagged.clear();
    _chartHighTagged.clear();
    _chartTargetTagged.clear();
    _chartLowTagged.clear();
    _chartVeryLowTagged.clear();
    setChartGroupData();
    notifyListeners();
  }

  void setChartGroupData() {
    setChartVeryLow();
    setChartLow();
    setChartTarget();
    setChartHigh();
    setChartVeryHigh();
  }

  List<ChartData> get chartVeryLow => _chartVeryLow;

  void setChartVeryLow() {
    List<ChartData> chartData = <ChartData>[];
    List<ChartData> chartDataAc = <ChartData>[];
    List<ChartData> chartDataTok = <ChartData>[];
    List<ChartData> chartDataFasting = <ChartData>[];
    List<ChartData> chartDataUnTagged = <ChartData>[];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.very_low) {
        chartData.add(ChartData(
            data.date, double.parse(data.result).toInt(), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else {
          chartDataUnTagged.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        }
      }
    }
    _chartVeryLow = chartData;
    _chartVeryLowTagged.putIfAbsent(1, () => chartDataAc);
    _chartVeryLowTagged.putIfAbsent(2, () => chartDataTok);
    _chartVeryLowTagged.putIfAbsent(3, () => chartDataFasting);
    _chartVeryLowTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  List<ChartData> get chartLow => _chartLow;

  void setChartLow() {
    List<ChartData> chartData = <ChartData>[];
    List<ChartData> chartDataAc = <ChartData>[];
    List<ChartData> chartDataTok = <ChartData>[];
    List<ChartData> chartDataFasting = <ChartData>[];
    List<ChartData> chartDataUnTagged = <ChartData>[];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.low) {
        chartData.add(ChartData(
            data.date, double.parse(data.result).toInt(), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else {
          chartDataUnTagged.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        }
      }
    }
    _chartLow = chartData;
    _chartLowTagged.putIfAbsent(1, () => chartDataAc);
    _chartLowTagged.putIfAbsent(2, () => chartDataTok);
    _chartLowTagged.putIfAbsent(3, () => chartDataFasting);
    _chartLowTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  List<ChartData> get chartTarget => _chartTarget;

  void setChartTarget() {
    List<ChartData> chartData = <ChartData>[];
    List<ChartData> chartDataAc = <ChartData>[];
    List<ChartData> chartDataTok = <ChartData>[];
    List<ChartData> chartDataFasting = <ChartData>[];
    List<ChartData> chartDataUnTagged = <ChartData>[];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.target) {
        chartData.add(ChartData(
            data.date, double.parse(data.result).toInt(), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else {
          chartDataUnTagged.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        }
      }
    }
    _chartTarget = chartData;
    _chartTargetTagged.putIfAbsent(1, () => chartDataAc);
    _chartTargetTagged.putIfAbsent(2, () => chartDataTok);
    _chartTargetTagged.putIfAbsent(3, () => chartDataFasting);
    _chartTargetTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  List<ChartData> get chartHigh => _chartHigh;

  void setChartHigh() {
    List<ChartData> chartData = <ChartData>[];
    List<ChartData> chartDataAc = <ChartData>[];
    List<ChartData> chartDataTok = <ChartData>[];
    List<ChartData> chartDataFasting = <ChartData>[];
    List<ChartData> chartDataUnTagged = <ChartData>[];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.high) {
        chartData.add(ChartData(
            data.date, double.parse(data.result).toInt(), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else {
          chartDataUnTagged.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        }
      }
    }
    _chartHigh = chartData;
    _chartHighTagged.putIfAbsent(1, () => chartDataAc);
    _chartHighTagged.putIfAbsent(2, () => chartDataTok);
    _chartHighTagged.putIfAbsent(3, () => chartDataFasting);
    _chartHighTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  List<ChartData> get chartVeryHigh => _chartVeryHigh;

  void setChartVeryHigh() {
    List<ChartData> chartData = <ChartData>[];
    List<ChartData> chartDataAc = <ChartData>[];
    List<ChartData> chartDataTok = <ChartData>[];
    List<ChartData> chartDataFasting = <ChartData>[];
    List<ChartData> chartDataUnTagged = <ChartData>[];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.very_high) {
        chartData.add(ChartData(
            data.date, double.parse(data.result).toInt(), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        } else {
          chartDataUnTagged.add(ChartData(
              data.date, double.parse(data.result).toInt(), data.resultColor));
        }
      }
    }
    _chartVeryHigh = chartData;
    _chartVeryHighTagged.putIfAbsent(1, () => chartDataAc);
    _chartVeryHighTagged.putIfAbsent(2, () => chartDataTok);
    _chartVeryHighTagged.putIfAbsent(3, () => chartDataFasting);
    _chartVeryHighTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  void setChartAverageDataPerDay() {
    bgMeasurementsDailyData = bgMeasurements;
    setChartDailyData();
  }

  changeStartDate(DateTime date) {
    _startDate = date;
    setSelectedItem(selected);
  }

  changeEndDate(DateTime date) {
    _endDate = date;
    setSelectedItem(selected);
  }

  Future<void> nextDate() async {
    await setStartDate(endDate);
    if (selected == TimePeriodFilter.weekly) {
      await setEndDate(endDate.add(const Duration(days: 7)));
    } else if (selected == TimePeriodFilter.monthly) {
      await setEndDate(DateTime(endDate.year, endDate.month + 1, 1));
    } else if (selected == TimePeriodFilter.monthlyThree) {
      await setEndDate(DateTime(endDate.year, endDate.month + 3, 1));
    }
    setChartAverageDataPerDay();
  }

  Future<void> previousDate() async {
    await setEndDate(startDate);
    if (selected == TimePeriodFilter.weekly) {
      await setStartDate(startDate.subtract(const Duration(days: 7)));
    } else if (selected == TimePeriodFilter.monthly) {
      await setStartDate(DateTime(startDate.year, startDate.month - 1, 1));
    } else if (selected == TimePeriodFilter.monthlyThree) {
      await setStartDate(DateTime(startDate.year, startDate.month - 3, 1));
    }
    setChartAverageDataPerDay();
  }

  updateBgMeasurement() async {
    if (selected == TimePeriodFilter.daily) {
      fetchBgMeasurement();
    } else {
      fetchBgMeasurementsInDateRange(
          startDate, endDate.add(const Duration(days: 1)));
    }

    bgMeasurements.removeWhere((element) =>
        (!isFilterSelected(GlucoseMarginsFilter.veryHigh) &&
            element.resultColor == R.color.very_high) ||
        (!isFilterSelected(GlucoseMarginsFilter.high) &&
            element.resultColor == R.color.high) ||
        (!isFilterSelected(GlucoseMarginsFilter.target) &&
            element.resultColor == R.color.target) ||
        (!isFilterSelected(GlucoseMarginsFilter.low) &&
            element.resultColor == R.color.low) ||
        (!isFilterSelected(GlucoseMarginsFilter.veryLow) &&
            element.resultColor == R.color.very_low) ||
        (!isFilterSelected(GlucoseMarginsFilter.hungry) && element.tag == 1) ||
        (!isFilterSelected(GlucoseMarginsFilter.full) && element.tag == 2) ||
        (!isFilterSelected(GlucoseMarginsFilter.other) &&
            element.tag != 1 &&
            element.tag != 2));
    bgMeasurementsDailyData.removeWhere((element) =>
        (!isFilterSelected(GlucoseMarginsFilter.veryHigh) &&
            element.resultColor == R.color.very_high) ||
        (!isFilterSelected(GlucoseMarginsFilter.high) &&
            element.resultColor == R.color.high) ||
        (!isFilterSelected(GlucoseMarginsFilter.target) &&
            element.resultColor == R.color.target) ||
        (!isFilterSelected(GlucoseMarginsFilter.low) &&
            element.resultColor == R.color.low) ||
        (!isFilterSelected(GlucoseMarginsFilter.veryLow) &&
            element.resultColor == R.color.very_low) ||
        (!isFilterSelected(GlucoseMarginsFilter.hungry) && element.tag == 1) ||
        (!isFilterSelected(GlucoseMarginsFilter.full) && element.tag == 2) ||
        (!isFilterSelected(GlucoseMarginsFilter.other) &&
            element.tag != 1 &&
            element.tag != 2));
    if (selected == TimePeriodFilter.daily ||
        selected == TimePeriodFilter.spesific) {
      fetchScrolledDailyData();
    } else {
      setChartAverageDataPerDay();
    }
  }

  resetFilterState() {
    _filterState = <GlucoseMarginsFilter, bool>{};
    notifyListeners();
  }

  List<ScatterSeries<ChartData, DateTime>> getDataScatterSeries() {
    return <ScatterSeries<ChartData, DateTime>>[
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[-1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_high,
          xAxisName: "Time",
          markerSettings: const MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderWidth: 5,
              borderColor: R.color.very_high,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[2] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_high,
          xAxisName: "Time",
          markerSettings:
              const MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[3] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_high,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderColor: R.color.very_high,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHighTagged[-1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.high,
          xAxisName: "Time",
          markerSettings: const MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHighTagged[1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderWidth: 2,
              borderColor: R.color.high,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHighTagged[2] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.high,
          xAxisName: "Time",
          markerSettings:
              const MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHighTagged[3] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.high,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderColor: R.color.high,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTargetTagged[-1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.target,
          xAxisName: "Time",
          markerSettings: const MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTargetTagged[1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderWidth: 2,
              borderColor: R.color.target,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTargetTagged[2] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.target,
          xAxisName: "Time",
          markerSettings:
              const MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTargetTagged[3] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.target,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderColor: R.color.target,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLowTagged[-1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.low,
          xAxisName: "Time",
          markerSettings: const MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLowTagged[1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderWidth: 2,
              borderColor: R.color.low,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLowTagged[2] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.low,
          xAxisName: "Time",
          markerSettings:
              const MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLowTagged[3] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.low,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderColor: R.color.low,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLowTagged[-1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_low,
          xAxisName: "Time",
          markerSettings: const MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLowTagged[1] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderWidth: 2,
              borderColor: R.color.very_low,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLowTagged[2] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_low,
          xAxisName: "Time",
          markerSettings:
              const MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLowTagged[3] ?? [],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_low,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              borderColor: R.color.very_low,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
    ];
  }

  void showBleReadingTagger() {
    Atom.show(
      const BgTaggerPopUp(
        isEdit: false,
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
    );
  }

  @override
  void showFilter(BuildContext context) {
    filterState.forEach((key, value) {
      _lastFilterStateBeforeEdit.putIfAbsent(key, () => value);
    });

    Atom.show(
      BgChartFilterPopUp(
        height: context.height * .52,
        width: context.width * .6,
      ),
    );
  }

  @override
  Widget largeWidget() {
    return BgProgressScreen(
      callBack: () {},
    );
  }

  @override
  Widget smallWidget(Function() callBack) {
    BgMeasurementGlucoseViewModel? lastMeasurement;
    if (bgMeasurements.isNotEmpty &&
        getIt<GlucoseStorageImpl>().getLatestMeasurement() != null) {
      lastMeasurement = BgMeasurementGlucoseViewModel(
        bgMeasurement: getIt<GlucoseStorageImpl>().getLatestMeasurement()!,
      );
    }

    return SmallChronicComponent(
      callback: callBack,
      lastMeasurement: lastMeasurement == null
          ? LocaleProvider.current.no_measurement
          : '${(double.tryParse(lastMeasurement.result) ?? 0).toStringAsFixed(1)}  mg/dl',
      lastMeasurementDate: lastMeasurement?.date ?? DateTime.now(),
      imageUrl: R.image.bloodGlucose,
    );
  }

  fetchBgMeasurement() {
    var _bgMeasurement = getIt<GlucoseStorageImpl>().getAll();
    bgMeasurements = _bgMeasurement
        .map((e) => BgMeasurementGlucoseViewModel(bgMeasurement: e))
        .toList();
    bgMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  List<DateTime> fetchBgMeasurementDates() {
    List<DateTime> _bgMeasurementDates = <DateTime>[];
    bool isInclude = false;
    for (var data in bgMeasurements) {
      for (var data2 in _bgMeasurementDates) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(data2.year, data2.month, data2.day))) {
          isInclude = true;
        }
      }
      if (!isInclude) {
        _bgMeasurementDates
            .add(DateTime(data.date.year, data.date.month, data.date.day));
      }
      isInclude = false;
      _bgMeasurementDates.sort((a, b) => a.compareTo(b));
    }
    return _bgMeasurementDates;
  }

  Future<void> fetchBgMeasurementsInDateRange(
      DateTime start, DateTime end) async {
    final result = getIt<GlucoseStorageImpl>().getAll();
    bgMeasurements.clear();
    for (var e in result) {
      DateTime measurementDate =
          BgMeasurementGlucoseViewModel(bgMeasurement: e).date;

      if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
        bgMeasurements.add(BgMeasurementGlucoseViewModel(bgMeasurement: e));
      }
    }
    bgMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  void manuelEntry(BuildContext ctx) {
    showBleReadingTagger();
  }

  getNewItems() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      try {
        if ((selected == TimePeriodFilter.daily) && !hasReachEnd) {
          getIt<GlucoseStorageImpl>()
              .getAndWriteGlucoseData(endDate: bgMeasurements.first.date)
              .then((value) {
            hasReachEnd = value;
          });
        }
      } catch (e, stk) {
        debugPrintStack(stackTrace: stk);
      }
    });
  }
}
