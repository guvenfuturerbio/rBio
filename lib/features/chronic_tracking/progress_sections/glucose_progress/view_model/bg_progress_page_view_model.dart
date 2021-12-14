import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chronic_tracking/utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import 'package:onedosehealth/model/model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/core.dart';
import '../../../../../core/data/service/chronic_service/chronic_storage_service.dart';
import '../../../../../model/bg_measurement/bg_measurement_view_model.dart';
import '../../../lib/notifiers/user_profiles_notifier.dart';
import '../../../lib/widgets/utils/time_period_filters.dart';
import '../../../utils/bg_filter_pop_up/bg_filter_pop_up.dart';
import '../../../utils/chart_data.dart';
import '../../../utils/glucose_margins_filter.dart';
import '../../utils/progress_page_model.dart';
import '../../utils/small_widget_card.dart';
import '../utils/blood_glucose_tagger/bg_tagger_pop_up.dart';
import '../utils/charts/animated_bubble_chart.dart';
import '../utils/charts/animated_line_chart.dart';
import '../view/bg_progress_page.dart';

enum GraphType { BUBBLE, LINE }

class BgProgressPageViewModel
    with ChangeNotifier, IBaseBottomActionsOfGraph
    implements ProgressPage {
  BgProgressPageViewModel({BuildContext context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getIt<GlucoseStorageImpl>().addListener(() {
        print("Triggered GlucoseRepository Listener");

        setSelectedItem(selected);
        print('data');
        print(selected);
      });
      /* GlucoseRepository().addListener(() async {
        //await fetchBgMeasurements();
        //fetchScrolledDailyData();
        print("Triggered GlucoseRepository Listener");
        setSelectedItem(selected);
      }); */
      UserProfilesNotifier().addListener(() async {
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
  }

  ScrollController controller = ScrollController();
  bool hasReachEnd = false;
  List<int> _tags = [1, 2, 3];

  Widget _currentGraph;

  GraphType _currentGraphType;

  List<BgMeasurementGlucoseViewModel> bgMeasurementsDailyData =
      new List<BgMeasurementGlucoseViewModel>();

  List<BgMeasurementGlucoseViewModel> bgMeasurements =
      new List<BgMeasurementGlucoseViewModel>();

  List<ChartData> _chartData;

  List<ChartData> _chartVeryLow;

  List<ChartData> _chartLow;

  List<ChartData> _chartTarget;

  List<ChartData> _chartHigh;

  List<ChartData> _chartVeryHigh;

  int _scrolledListIndex;

  int _listLastIndex;

  TimePeriodFilter _selectedItem;

  DateTime _startDate, _endDate;

  int _currentDateIndex = 0;

  Map<int, List<ChartData>> _chartDataTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartVeryLowTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartLowTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartTargetTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartHighTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartVeryHighTagged = Map<int, List<ChartData>>();

  Map<Color, GlucoseMarginsFilter> _colorInfo =
      Map<Color, GlucoseMarginsFilter>();

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

  DateTime _scrolledDate;

  List<GlucoseMarginsFilter> get states => [
        GlucoseMarginsFilter.HUNGRY,
        GlucoseMarginsFilter.FULL,
        GlucoseMarginsFilter.OTHER
      ];

  Map<GlucoseMarginsFilter, bool> _filterState =
      Map<GlucoseMarginsFilter, bool>();

  Map<GlucoseMarginsFilter, bool> _lastFilterStateBeforeEdit =
      <GlucoseMarginsFilter, bool>{};

  Map<GlucoseMarginsFilter, bool> get filterState {
    _filterState.putIfAbsent(GlucoseMarginsFilter.VERY_LOW, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.LOW, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.TARGET, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.HIGH, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.VERY_HIGH, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.HUNGRY, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.FULL, () => true);
    _filterState.putIfAbsent(GlucoseMarginsFilter.OTHER, () => true);
    return this._filterState;
  }

  Future<void> setFilterState(GlucoseMarginsFilter key) async {
    try {
      _filterState.update(key, (value) => !filterState[key]);
      notifyListeners();
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }

  void updateFilterState() {
    try {
      _lastFilterStateBeforeEdit = Map<GlucoseMarginsFilter, bool>();
      updateBgMeasurement();
      notifyListeners();
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }

  cancelSelections() {
    _filterState = _lastFilterStateBeforeEdit;
    _lastFilterStateBeforeEdit = Map<GlucoseMarginsFilter, bool>();
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
    return filterState[filter];
  }

  List<int> get tags => this._tags;

  Map<int, List<ChartData>> get chartDataTagged => this._chartDataTagged;

  Map<int, List<ChartData>> get chartVeryLowTagged => this._chartVeryLowTagged;

  Map<int, List<ChartData>> get chartLowTagged => this._chartLowTagged;

  Map<int, List<ChartData>> get chartTargetTagged => this._chartTargetTagged;

  Map<int, List<ChartData>> get chartHighTagged => this._chartHighTagged;

  Map<int, List<ChartData>> get chartVeryHighTagged =>
      this._chartVeryHighTagged;

  int get targetMin => getIt<ProfileStorageImpl>().getFirst().rangeMin;

  int get targetMax => getIt<ProfileStorageImpl>().getFirst().rangeMax;

  int get criticMin => getIt<ProfileStorageImpl>().getFirst().hypo;

  int get criticMax => getIt<ProfileStorageImpl>().getFirst().hyper;

  int get dailyHighestValue {
    int highest = bgMeasurementsDailyData.isNotEmpty
        ? int.parse(bgMeasurementsDailyData[0].result)
        : 300;
    for (var data in bgMeasurementsDailyData) {
      if (int.parse(data.result) > highest) {
        highest = int.parse(data.result);
      }
    }
    return highest > targetMax ? highest + 50 : targetMax + 50;
  }

  int get dailyLowestValue {
    int lowest = bgMeasurementsDailyData.isNotEmpty
        ? int.parse(bgMeasurementsDailyData[0].result)
        : 50;
    for (var data in bgMeasurementsDailyData) {
      if (int.parse(data.result) < lowest) {
        lowest = int.parse(data.result);
      }
    }
    return 0; //lowest < targetMin ?  targetMin - 50 : lowest;
  }

  int get highestValue {
    int highest =
        bgMeasurements.isNotEmpty ? int.parse(bgMeasurements[0].result) : 300;
    for (var data in bgMeasurements) {
      if (int.parse(data.result) > highest) {
        highest = int.parse(data.result);
      }
    }
    return 300;
    //return targetMax + targetMin;
  }

  int get lowestValue {
    int lowest =
        bgMeasurements.isNotEmpty ? int.parse(bgMeasurements[0].result) : 50;
    for (var data in bgMeasurements) {
      if (int.parse(data.result) < lowest) {
        lowest = int.parse(data.result);
      }
    }
    return 0;
    //return 0;
  }

  int get totalValuableCount {
    int totalCount = 0;
    if (this._chartData != null) {
      for (var data in this._chartData) {
        if (data.y > 0) {
          totalCount++;
        }
      }
    }
    return totalCount;
  }

  Widget get currentGraph => _currentGraph ?? AnimationScatterDefault();

  void setCurrentGraph() {
    // TODO Delete all string based comparisions, when language is changed it rekts the entire graph sections
    currentGraphType == GraphType.BUBBLE
        ? this._currentGraph = AnimationScatterDefault()
        : this._currentGraph = AnimationLineDefault();
    notifyListeners();
  }

  GraphType get currentGraphType => _currentGraphType ?? GraphType.BUBBLE;

  /// MG13
  void changeGraphType() {
    if (currentGraphType == GraphType.BUBBLE) {
      this._currentGraphType = GraphType.LINE;
    } else {
      this._currentGraphType = GraphType.BUBBLE;
    }
    setCurrentGraph();
    notifyListeners();
  }

  List<TimePeriodFilter> get items => [
        TimePeriodFilter.DAILY,
        TimePeriodFilter.WEEKLY,
        TimePeriodFilter.MONTHLY,
        TimePeriodFilter.MONTHLY_THREE,
        TimePeriodFilter.SPECIFIC
      ];

  TimePeriodFilter get selected => _selectedItem ?? items[0];

  /// MG13
  Future<void> setSelectedItem(TimePeriodFilter s) async {
    resetFilterState();
    this._currentDateIndex = 0;
    this._selectedItem = s;
    setCurrentGraph();
    if (s == TimePeriodFilter.SPECIFIC) {
      fetchBgMeasurement();
      fetchSpesificData();
    } else if (s == TimePeriodFilter.DAILY) {
      fetchBgMeasurement();
      fetchScrolledDailyData();
    } else {
      DateTime currentDateEnd = DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 23, 59, 00);
      DateTime currentDateStart = DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 00, 00);
      s == TimePeriodFilter.WEEKLY
          ? await setStartDate(currentDateStart.subtract(Duration(days: 7)))
          : s == TimePeriodFilter.MONTHLY
              ? await setStartDate(currentDateStart
                  .subtract(Duration(days: currentDateStart.day - 1)))
              : s == TimePeriodFilter.MONTHLY_THREE
                  ? await setStartDate(DateTime(
                      currentDateStart.year, currentDateStart.month - 3, 1))
                  : await setStartDate(currentDateStart);
      await setEndDate(currentDateEnd);
      setChartAverageDataPerDay();
    }
  }

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    this._startDate = d;
    this._currentDateIndex = 0;
    await getIt<GlucoseStorageImpl>().getAndWriteGlucoseData(
        beginDate: _startDate, endDate: endDate.add(Duration(days: 1)));
    fetchBgMeasurementsInDateRange(startDate, endDate.add(Duration(days: 1)));

    notifyListeners();
  }

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate.year, _endDate.month, _endDate.day)
      : DateTime(
          DateTime.now().add(Duration(days: 1)).year,
          DateTime.now().add(Duration(days: 1)).month,
          DateTime.now().add(Duration(days: 1)).day);

  Future<void> setEndDate(DateTime d) async {
    this._endDate = d;
    this._currentDateIndex = 0;
    await getIt<GlucoseStorageImpl>().getAndWriteGlucoseData(
        beginDate: _startDate, endDate: endDate.add(Duration(days: 1)));
    fetchBgMeasurementsInDateRange(startDate, endDate.add(Duration(days: 1)));

    notifyListeners();
  }

  int get scrolledIndex => _scrolledListIndex;

  void setScrolledIndex(int index) {
    if (selected == TimePeriodFilter.DAILY) {
      setListLastIndex(_scrolledListIndex ?? index);
      _scrolledListIndex = index;
      _scrolledListIndex > listLastIndex
          ? setCurrentDateIndex(1)
          : _scrolledListIndex < listLastIndex
              ? setCurrentDateIndex(-1)
              : setCurrentDateIndex(1);
      if (selected == TimePeriodFilter.DAILY ||
          selected == TimePeriodFilter.SPECIFIC) {
        fetchScrolledDailyData();
      }
      notifyListeners();
    }
  }

  int get listLastIndex => _listLastIndex;

  void setListLastIndex(int index) {
    _listLastIndex = index;
  }

  int get currentDateIndex => _currentDateIndex ?? 0;

  void setCurrentDateIndex(int value) {
    this._currentDateIndex += value;
    if (this._currentDateIndex < 0) {
      this._currentDateIndex = 0;
    }
  }

  set currentDateIndex(int val) => _currentDateIndex = val;

  void fetchScrolledData(DateTime date) {
    if (date != null && selected == TimePeriodFilter.DAILY) {
      var _temp = DateTime(_scrolledDate?.year ?? 2000,
          _scrolledDate?.month ?? 01, _scrolledDate?.day ?? 01);
      var _cross = DateTime(date.year, date.month, date.day);
      if (_scrolledDate == null || (_temp != _cross)) {
        _scrolledDate = date;
        this.bgMeasurementsDailyData.clear();

        //print("current Date " + reversedList[currentDateIndex].toString());
        for (var data in bgMeasurements) {
          if (DateTime(data.date.year, data.date.month, data.date.day)
              .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
            this.bgMeasurementsDailyData.add(data);
          }
        }

        setChartDailyData();
      }
    }
  }

  void fetchScrolledDailyData() {
    this.bgMeasurementsDailyData.clear();
    List<DateTime> dateList = fetchBgMeasurementDates();
    //print(dateList.toString());
    List<DateTime> reversedList = dateList.reversed.toList();
    if (reversedList.isNotEmpty) {
      DateTime currentDate = reversedList[currentDateIndex];
      //print("current Date " + reversedList[currentDateIndex].toString());
      for (var data in bgMeasurements) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(
                currentDate.year, currentDate.month, currentDate.day))) {
          this.bgMeasurementsDailyData.add(data);
        }
      }
    }
    setChartDailyData();
  }

  void fetchSpesificData() {
    this.bgMeasurementsDailyData.clear();
    for (var data in bgMeasurements) {
      if (data.date.difference(_startDate).inDays >= 0 &&
          data.date.difference(_endDate).inDays <= 0) {
        this.bgMeasurementsDailyData.add(data);
      }
    }
    setChartDailyData();
  }

  List<ChartData> get chartData => _chartData;

  void setChartDailyData() {
    List<ChartData> chartData = <ChartData>[];
    for (var data in this.bgMeasurementsDailyData) {
      chartData
          .add(ChartData(data.date, int.parse(data.result), data.resultColor));
    }
    this._chartData = chartData;
    this._chartVeryHighTagged.clear();
    this._chartHighTagged.clear();
    this._chartTargetTagged.clear();
    this._chartLowTagged.clear();
    this._chartVeryLowTagged.clear();
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

    for (var data in this.bgMeasurementsDailyData) {
      if (data.resultColor == R.color.very_low) {
        chartData.add(
            ChartData(data.date, int.parse(data.result), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartVeryLow = chartData;
    this._chartVeryLowTagged.putIfAbsent(1, () => chartDataAc);
    this._chartVeryLowTagged.putIfAbsent(2, () => chartDataTok);
    this._chartVeryLowTagged.putIfAbsent(3, () => chartDataFasting);
    this._chartVeryLowTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  List<ChartData> get chartLow => _chartLow;

  void setChartLow() {
    List<ChartData> chartData = <ChartData>[];
    List<ChartData> chartDataAc = <ChartData>[];
    List<ChartData> chartDataTok = <ChartData>[];
    List<ChartData> chartDataFasting = <ChartData>[];
    List<ChartData> chartDataUnTagged = <ChartData>[];

    for (var data in this.bgMeasurementsDailyData) {
      if (data.resultColor == R.color.low) {
        chartData.add(
            ChartData(data.date, int.parse(data.result), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartLow = chartData;
    this._chartLowTagged.putIfAbsent(1, () => chartDataAc);
    this._chartLowTagged.putIfAbsent(2, () => chartDataTok);
    this._chartLowTagged.putIfAbsent(3, () => chartDataFasting);
    this._chartLowTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  List<ChartData> get chartTarget => _chartTarget;

  void setChartTarget() {
    List<ChartData> chartData = <ChartData>[];
    List<ChartData> chartDataAc = <ChartData>[];
    List<ChartData> chartDataTok = <ChartData>[];
    List<ChartData> chartDataFasting = <ChartData>[];
    List<ChartData> chartDataUnTagged = <ChartData>[];

    for (var data in this.bgMeasurementsDailyData) {
      if (data.resultColor == R.color.target) {
        chartData.add(
            ChartData(data.date, int.parse(data.result), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartTarget = chartData;
    this._chartTargetTagged.putIfAbsent(1, () => chartDataAc);
    this._chartTargetTagged.putIfAbsent(2, () => chartDataTok);
    this._chartTargetTagged.putIfAbsent(3, () => chartDataFasting);
    this._chartTargetTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  List<ChartData> get chartHigh => _chartHigh;

  void setChartHigh() {
    List<ChartData> chartData = <ChartData>[];
    List<ChartData> chartDataAc = <ChartData>[];
    List<ChartData> chartDataTok = <ChartData>[];
    List<ChartData> chartDataFasting = <ChartData>[];
    List<ChartData> chartDataUnTagged = <ChartData>[];

    for (var data in this.bgMeasurementsDailyData) {
      if (data.resultColor == R.color.high) {
        chartData.add(
            ChartData(data.date, int.parse(data.result), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartHigh = chartData;
    this._chartHighTagged.putIfAbsent(1, () => chartDataAc);
    this._chartHighTagged.putIfAbsent(2, () => chartDataTok);
    this._chartHighTagged.putIfAbsent(3, () => chartDataFasting);
    this._chartHighTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  List<ChartData> get chartVeryHigh => _chartVeryHigh;

  void setChartVeryHigh() {
    List<ChartData> chartData = <ChartData>[];
    List<ChartData> chartDataAc = <ChartData>[];
    List<ChartData> chartDataTok = <ChartData>[];
    List<ChartData> chartDataFasting = <ChartData>[];
    List<ChartData> chartDataUnTagged = <ChartData>[];

    for (var data in this.bgMeasurementsDailyData) {
      if (data.resultColor == R.color.very_high) {
        chartData.add(
            ChartData(data.date, int.parse(data.result), data.resultColor));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else if (data.tag == 3) {
          chartDataFasting.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartVeryHigh = chartData;
    this._chartVeryHighTagged.putIfAbsent(1, () => chartDataAc);
    this._chartVeryHighTagged.putIfAbsent(2, () => chartDataTok);
    this._chartVeryHighTagged.putIfAbsent(3, () => chartDataFasting);
    this._chartVeryHighTagged.putIfAbsent(-1, () => chartDataUnTagged);
  }

  void setChartAverageDataPerDay() {
    this.bgMeasurementsDailyData = bgMeasurements;
    setChartDailyData();
  }

  Future<void> nextDate() async {
    await setStartDate(endDate);
    if (selected == TimePeriodFilter.WEEKLY) {
      await setEndDate(endDate.add(Duration(days: 7)));
    } else if (selected == TimePeriodFilter.MONTHLY) {
      await setEndDate(DateTime(endDate.year, endDate.month + 1, 1));
    } else if (selected == TimePeriodFilter.MONTHLY_THREE) {
      await setEndDate(DateTime(endDate.year, endDate.month + 3, 1));
    }
    setChartAverageDataPerDay();
  }

  Future<void> previousDate() async {
    await setEndDate(startDate);
    if (selected == TimePeriodFilter.WEEKLY) {
      await setStartDate(startDate.subtract(Duration(days: 7)));
    } else if (selected == TimePeriodFilter.MONTHLY) {
      await setStartDate(DateTime(startDate.year, startDate.month - 1, 1));
    } else if (selected == TimePeriodFilter.MONTHLY_THREE) {
      await setStartDate(DateTime(startDate.year, startDate.month - 3, 1));
    }
    setChartAverageDataPerDay();
  }

  updateBgMeasurement() async {
    if (selected == TimePeriodFilter.DAILY) {
      fetchBgMeasurement();
    } else {
      fetchBgMeasurementsInDateRange(startDate, endDate.add(Duration(days: 1)));
    }

    this.bgMeasurements.removeWhere((element) =>
        (!isFilterSelected(GlucoseMarginsFilter.VERY_HIGH) &&
            element.resultColor == R.color.very_high) ||
        (!isFilterSelected(GlucoseMarginsFilter.HIGH) &&
            element.resultColor == R.color.high) ||
        (!isFilterSelected(GlucoseMarginsFilter.TARGET) &&
            element.resultColor == R.color.target) ||
        (!isFilterSelected(GlucoseMarginsFilter.LOW) &&
            element.resultColor == R.color.low) ||
        (!isFilterSelected(GlucoseMarginsFilter.VERY_LOW) &&
            element.resultColor == R.color.very_low) ||
        (!isFilterSelected(GlucoseMarginsFilter.HUNGRY) && element.tag == 1) ||
        (!isFilterSelected(GlucoseMarginsFilter.FULL) && element.tag == 2) ||
        (!isFilterSelected(GlucoseMarginsFilter.OTHER) &&
            element.tag != 1 &&
            element.tag != 2));
    this.bgMeasurementsDailyData.removeWhere((element) =>
        (!isFilterSelected(GlucoseMarginsFilter.VERY_HIGH) &&
            element.resultColor == R.color.very_high) ||
        (!isFilterSelected(GlucoseMarginsFilter.HIGH) &&
            element.resultColor == R.color.high) ||
        (!isFilterSelected(GlucoseMarginsFilter.TARGET) &&
            element.resultColor == R.color.target) ||
        (!isFilterSelected(GlucoseMarginsFilter.LOW) &&
            element.resultColor == R.color.low) ||
        (!isFilterSelected(GlucoseMarginsFilter.VERY_LOW) &&
            element.resultColor == R.color.very_low) ||
        (!isFilterSelected(GlucoseMarginsFilter.HUNGRY) && element.tag == 1) ||
        (!isFilterSelected(GlucoseMarginsFilter.FULL) && element.tag == 2) ||
        (!isFilterSelected(GlucoseMarginsFilter.OTHER) &&
            element.tag != 1 &&
            element.tag != 2));
    if (selected == TimePeriodFilter.DAILY ||
        selected == TimePeriodFilter.SPECIFIC) {
      fetchScrolledDailyData();
    } else {
      setChartAverageDataPerDay();
    }
  }

  resetFilterState() {
    _filterState = Map<GlucoseMarginsFilter, bool>();
    notifyListeners();
  }

  List<ScatterSeries<ChartData, DateTime>> getDataScatterSeries() {
    return <ScatterSeries<ChartData, DateTime>>[
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[-1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_high,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[1],
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
          dataSource: _chartVeryHighTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_high,
          xAxisName: "Time",
          markerSettings:
              MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[3],
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
          dataSource: _chartHighTagged[-1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.high,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHighTagged[1],
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
          dataSource: _chartHighTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.high,
          xAxisName: "Time",
          markerSettings:
              MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHighTagged[3],
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
          dataSource: _chartTargetTagged[-1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.target,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTargetTagged[1],
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
          dataSource: _chartTargetTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.target,
          xAxisName: "Time",
          markerSettings:
              MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTargetTagged[3],
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
          dataSource: _chartLowTagged[-1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.low,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLowTagged[1],
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
          dataSource: _chartLowTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.low,
          xAxisName: "Time",
          markerSettings:
              MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLowTagged[3],
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
          dataSource: _chartVeryLowTagged[-1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_low,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.rectangle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLowTagged[1],
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
          dataSource: _chartVeryLowTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_low,
          xAxisName: "Time",
          markerSettings:
              MarkerSettings(height: 15, width: 15, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLowTagged[3],
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

  showBleReadingTagger(BuildContext context) {
    Atom.show(
        BgTaggerPopUp(
          isEdit: false,
        ),
        barrierColor: Colors.transparent,
        barrierDismissible: false);
  }

  void showFilter(BuildContext context) {
    filterState.forEach((key, value) {
      _lastFilterStateBeforeEdit.putIfAbsent(key, () => value);
    });
    Atom.show(BgFilterPopUp(
      height: context.HEIGHT * .52,
      width: context.WIDTH * .6,
    ));
  }

  @override
  Widget largeWidget(Function() callBack) {
    return BgProgressPage(
      callBack: callBack,
    );
  }

  @override
  Widget smallWidget(Function() callBack) {
    BgMeasurementGlucoseViewModel lastMeasurement;
    if (bgMeasurements.isNotEmpty) {
      lastMeasurement = BgMeasurementGlucoseViewModel(
          bgMeasurement: getIt<GlucoseStorageImpl>().getLatestMeasurement());
    }

    return RbioSmallChronicWidget(
      callback: callBack,
      lastMeasurement:
          '${lastMeasurement?.result ?? ''} ${lastMeasurement == null ? '' : 'mg/dl'}',
      lastMeasurementDate: lastMeasurement?.date ?? DateTime.now(),
      imageUrl: R.image.ct_blood_glucose,
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
    this.bgMeasurements.clear();
    for (var e in result) {
      DateTime measurementDate =
          BgMeasurementGlucoseViewModel(bgMeasurement: e).date;

      if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
        bgMeasurements.add(BgMeasurementGlucoseViewModel(bgMeasurement: e));
      }
    }
    this.bgMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  void manuelEntry(BuildContext ctx) {
    showBleReadingTagger(ctx);
  }

  getNewItems() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if ((selected == TimePeriodFilter.DAILY) && !hasReachEnd) {
          getIt<GlucoseStorageImpl>()
              .getAndWriteGlucoseData(endDate: bgMeasurements.first.date)
              .then((value) {
            print(value);
            hasReachEnd = value;
          });
        }
      } catch (e, stk) {
        print(e);
        debugPrintStack(stackTrace: stk);
      }
    });
  }
}
