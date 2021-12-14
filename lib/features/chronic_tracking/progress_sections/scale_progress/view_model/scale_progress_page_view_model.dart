import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/scale_progress/utils/scale_measurements/scale_measurement_vm.dart';
import 'package:onedosehealth/features/chronic_tracking/utils/chart_data.dart';
import 'package:onedosehealth/model/model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/constants/constants.dart' as rBio;
import '../../../../../core/core.dart';
import '../../../lib/notifiers/user_profiles_notifier.dart';
import '../../../lib/widgets/utils/scale_margin_filter.dart';
import '../../../lib/widgets/utils/time_period_filters.dart';
import '../../../utils/selected_scale_type.dart';
import '../../utils/progress_page_model.dart';
import '../../utils/small_widget_card.dart';
import '../utils/charts/animated_scale_buble_chart.dart';
import '../utils/charts/animated_scale_line_chart.dart';
import '../utils/scale_filter_pop_up/scale_filter_pop_up.dart';
import '../utils/scale_tagger/scale_tagger_pop_up.dart';
import '../view/scale_progress_page.dart';

enum GraphType { BUBBLE, LINE }

class ScaleProgressPageViewModel extends ChangeNotifier
    implements ProgressPage {
  final controller = ScrollController();
  bool hasReachEnd = false;
  ScaleProgressPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print('here');
      getIt<ScaleStorageImpl>().addListener(() async {
        print("Triggered ScaleRepository Listener");
        setSelectedItem(selected);
      });
      UserProfilesNotifier().addListener(() async {
        setSelectedItem(selected);
      });
      fetchScaleMeasurements();
      fetchScrolledDailyData();
      controller.addListener(() {
        if (controller.position.atEdge && controller.position.pixels != 0) {
          getNewItems();
        }
      });
    });
  }

  Widget get bubleChart => AnimationScaleScatterDefault();

  Widget _currentGraph;

  GraphType _currentGraphType;

  List<ScaleMeasurementViewModel> scaleMeasurementsDailyData =
      <ScaleMeasurementViewModel>[];

  List<ScaleMeasurementViewModel> scaleMeasurements =
      <ScaleMeasurementViewModel>[];

  List<ChartData> _chartData;

  List<ChartData> _chartVeryLow;

  List<ChartData> _chartLow;

  List<ChartData> _chartTarget;

  List<ChartData> _chartHigh;

  List<ChartData> _chartVeryHigh;

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

  Map<Color, ScaleMarginsFilter> _colorInfo = Map<Color, ScaleMarginsFilter>();

  Map<Color, ScaleMarginsFilter> get colorInfo {
    _colorInfo.putIfAbsent(R.color.very_low, () => ScaleMarginsFilter.VERY_LOW);
    _colorInfo.putIfAbsent(R.color.low, () => ScaleMarginsFilter.LOW);
    _colorInfo.putIfAbsent(R.color.target, () => ScaleMarginsFilter.TARGET);
    _colorInfo.putIfAbsent(R.color.high, () => ScaleMarginsFilter.HIGH);
    _colorInfo.putIfAbsent(
        R.color.very_high, () => ScaleMarginsFilter.VERY_HIGH);
    return this._colorInfo;
  }

  DateTime _scrolledDate;

  Map<ScaleMarginsFilter, bool> _colorFilterState =
      <ScaleMarginsFilter, bool>{};
  Map<ScaleMarginsFilter, bool> get colorFilterState {
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.VERY_LOW, () => true);
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.LOW, () => true);
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.TARGET, () => true);
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.HIGH, () => true);
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.OTHER, () => true);
    return this._colorFilterState;
  }

  bool isFilterSelected(SelectedScaleType filter) {
    return colorFilterState[filter];
  }

  SelectedScaleType _selectedScaleType;
  SelectedScaleType get currentScaleType =>
      _selectedScaleType ?? SelectedScaleType.WEIGHT;

  Map<int, List<ChartData>> get chartDataTagged => this._chartDataTagged;

  Map<int, List<ChartData>> get chartVeryLowTagged => this._chartVeryLowTagged;

  Map<int, List<ChartData>> get chartLowTagged => this._chartLowTagged;

  Map<int, List<ChartData>> get chartTargetTagged => this._chartTargetTagged;

  Map<int, List<ChartData>> get chartHighTagged => this._chartHighTagged;

  Map<int, List<ChartData>> get chartVeryHighTagged =>
      this._chartVeryHighTagged;

  int get targetMin => scaleMeasurements.isEmpty
      ? 0
      : scaleMeasurements[0].minRange(currentScaleType);

  int get targetMax => scaleMeasurements.isEmpty
      ? 0
      : scaleMeasurements[0].maxRange(currentScaleType);

  int get criticMin => UserProfilesNotifier().selection.hypo;

  int get criticMax => UserProfilesNotifier().selection.hyper;

  int get dailyHighestValue {
    int highest = scaleMeasurementsDailyData.isNotEmpty &&
            scaleMeasurements[0].getMeasurement(currentScaleType) != null
        ? scaleMeasurementsDailyData[0].getMeasurement(currentScaleType).toInt()
        : 70;
    for (var data in scaleMeasurementsDailyData) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType).toInt();
        if (_currentValue > highest) {
          highest = _currentValue;
        }
      }
    }
    return highest > targetMax ? highest + 10 : targetMax + 10;
  }

  changeScaleType(SelectedScaleType type) {
    _selectedScaleType = type;
    setSelectedItem(selected);
  }

  int get dailyLowestValue {
    int lowest = scaleMeasurementsDailyData.isNotEmpty &&
            scaleMeasurements[0].getMeasurement(currentScaleType) != null
        ? scaleMeasurementsDailyData[0].getMeasurement(currentScaleType).toInt()
        : 50;
    for (var data in scaleMeasurementsDailyData) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType).toInt();
        if (_currentValue < lowest) {
          lowest = _currentValue;
        }
      }
    }
    return lowest < targetMin ? targetMin - 15 : lowest - 15;
  }

  int get highestValue {
    int highest = scaleMeasurements.isNotEmpty &&
            scaleMeasurements[0].getMeasurement(currentScaleType) != null
        ? scaleMeasurements[0].getMeasurement(currentScaleType).toInt()
        : 300;
    for (var data in scaleMeasurements) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType).toInt();
        if (_currentValue > highest) {
          highest = _currentValue;
        }
      }
    }
    return 300;
    //return targetMax + targetMin;
  }

  int get lowestValue {
    int lowest = scaleMeasurements.isNotEmpty &&
            scaleMeasurements[0].getMeasurement(currentScaleType) != null
        ? scaleMeasurements[0].getMeasurement(currentScaleType).toInt()
        : 50;
    for (var data in scaleMeasurements) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType).toInt();
        if (_currentValue < lowest) {
          lowest = _currentValue;
        }
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

  void setCurrentGraph() {
    // TODO Delete all string based comparisions, when language is changed it rekts the entire graph sections
    currentGraphType == GraphType.BUBBLE
        ? this._currentGraph = AnimationScaleScatterDefault()
        : this._currentGraph = AnimationScaleLineDefault();
    notifyListeners();
  }

  Widget get currentGraph => _currentGraph ?? AnimationScaleScatterDefault();

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

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    this._startDate = d;
    this._currentDateIndex = 0;
    await getIt<ScaleStorageImpl>().getAndWriteScaleData(
        beginDate: _startDate, endDate: endDate.add(Duration(days: 1)));
    fetchScaleMeasurementsInDateRange(
        startDate, endDate.add(Duration(days: 1)));
    //fetchScrolledDailyData();
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
    await getIt<ScaleStorageImpl>().getAndWriteScaleData(
        beginDate: _startDate, endDate: endDate.add(Duration(days: 1)));
    fetchScaleMeasurementsInDateRange(
        startDate, endDate.add(Duration(days: 1)));

    //fetchScrolledDailyData();
    notifyListeners();
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

  changeStartDate(DateTime date) {
    print(date);
    print(selected);
    _startDate = date;
    setSelectedItem(selected);
  }

  changeEndDate(DateTime date) {
    _endDate = date;
    setSelectedItem(selected);
  }

  set currentDateIndex(int val) => _currentDateIndex = val;

  void fetchScrolledData(DateTime date) {
    if (date != null && selected == TimePeriodFilter.DAILY) {
      var _temp = DateTime(_scrolledDate?.year ?? 2000,
          _scrolledDate?.month ?? 01, _scrolledDate?.day ?? 01);
      var _cross = DateTime(date.year, date.month, date.day);
      if (_scrolledDate == null || (_temp != _cross)) {
        _scrolledDate = date;
        this.scaleMeasurementsDailyData.clear();

        //print("current Date " + reversedList[currentDateIndex].toString());
        for (var data in scaleMeasurements) {
          if (DateTime(data.date.year, data.date.month, data.date.day)
              .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
            this.scaleMeasurementsDailyData.add(data);
          }
        }

        setChartDailyData();
      }
    }
  }

  void fetchScrolledDailyData() {
    this.scaleMeasurementsDailyData.clear();
    List<DateTime> dateList = fetchScaleMeasurementsDateList();
    //print(dateList.toString());
    List<DateTime> reversedList = dateList.reversed.toList();
    if (reversedList.isNotEmpty) {
      DateTime currentDate = reversedList[currentDateIndex];
      //print("current Date " + reversedList[currentDateIndex].toString());
      for (var data in scaleMeasurements) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(
                currentDate.year, currentDate.month, currentDate.day))) {
          this.scaleMeasurementsDailyData.add(data);
        }
      }
    }
    setChartDailyData();
  }

  List<ChartData> get chartData => _chartData;

  void setChartDailyData() {
    List<ChartData> tempChartData = <ChartData>[];
    for (var data in this.scaleMeasurementsDailyData) {
      if (data.getMeasurement(currentScaleType) != null) {
        tempChartData.add(ChartData(
            data.date,
            data.getMeasurement(currentScaleType).toInt(),
            data.getColor(currentScaleType)));
      }
    }
    this._chartData = tempChartData;
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
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in this.scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.very_low) {
        tempChartData.add(ChartData(
            data.date,
            data.getMeasurement(currentScaleType).toInt(),
            data.getColor(currentScaleType)));
      }
    }
    this._chartVeryLow = tempChartData;
    notifyListeners();
  }

  List<ChartData> get chartLow => _chartLow;

  void setChartLow() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in this.scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.low) {
        tempChartData.add(ChartData(
            data.date,
            data.getMeasurement(currentScaleType).toInt(),
            data.getColor(currentScaleType)));
      }
    }
    this._chartLow = tempChartData;
    notifyListeners();
  }

  List<ChartData> get chartTarget => _chartTarget;

  void setChartTarget() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in this.scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.target) {
        tempChartData.add(ChartData(
            data.date,
            data.getMeasurement(currentScaleType).toInt(),
            data.getColor(currentScaleType)));
      }
    }
    this._chartTarget = tempChartData;
    notifyListeners();
  }

  List<ChartData> get chartHigh => _chartHigh;

  void setChartHigh() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in this.scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.high) {
        tempChartData.add(ChartData(
            data.date,
            data.getMeasurement(currentScaleType).toInt(),
            data.getColor(currentScaleType)));
      }
    }
    this._chartHigh = tempChartData;
    notifyListeners();
  }

  List<ChartData> get chartVeryHigh => _chartVeryHigh;

  void setChartVeryHigh() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in this.scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.very_high) {
        tempChartData.add(ChartData(
            data.date,
            data.getMeasurement(currentScaleType).toInt(),
            data.getColor(currentScaleType)));
      }
    }
    this._chartVeryHigh = tempChartData;
    notifyListeners();
  }

  void setChartAverageDataPerDay() {
    this.scaleMeasurementsDailyData = scaleMeasurements;
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
    notifyListeners();
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
    notifyListeners();
  }

  updateScaleMeasurement() async {
    if (selected == TimePeriodFilter.DAILY) {
      fetchScaleMeasurements();
    } else {
      fetchScaleMeasurementsInDateRange(
          startDate, endDate.add(Duration(days: 1)));
    }

    if (selected == TimePeriodFilter.DAILY ||
        selected == TimePeriodFilter.SPECIFIC) {
      fetchScrolledDailyData();
    } else {
      setChartAverageDataPerDay();
    }
  }

  resetFilterState() {
    _colorFilterState = Map<ScaleMarginsFilter, bool>();
    notifyListeners();
  }

  List<ScatterSeries<ChartData, DateTime>> getDataScatterSeries() {
    return <ScatterSeries<ChartData, DateTime>>[
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLow,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_low,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.circle)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLow,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.low,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 15,
              width: 15,
              shape: DataMarkerType.circle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTarget,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.target,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              color: R.color.very_low,
              height: 15,
              width: 15,
              shape: DataMarkerType.circle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHigh,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.high,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              color: R.color.high,
              height: 15,
              width: 15,
              borderColor: R.color.very_high,
              shape: DataMarkerType.circle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHigh,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.very_high,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              color: R.color.very_high,
              height: 15,
              width: 15,
              isVisible: true,
              shape: DataMarkerType.circle)),
    ];
  }

  showScaleTagger(BuildContext context) {
    Atom.show(ScaleTagger(),
        barrierDismissible: false, barrierColor: Colors.transparent);
  }

  Future<void> setSelectedItem(TimePeriodFilter s) async {
    resetFilterState();
    this._currentDateIndex = 0;
    notifyListeners();
    this._selectedItem = s;
    setCurrentGraph();
    notifyListeners();
    if (s == TimePeriodFilter.SPECIFIC) {
      fetchScaleMeasurements();
      fetchSpesificData();
    } else if (s == TimePeriodFilter.DAILY) {
      fetchScaleMeasurements();
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
    }
    if (s == TimePeriodFilter.WEEKLY) {
      setChartAverageDataPerDay();
    } else if (s == TimePeriodFilter.MONTHLY) {
      setChartAverageDataPerDay();
    } else if (s == TimePeriodFilter.MONTHLY_THREE) {
      setChartAverageDataPerDay();
    }
    notifyListeners();
  }

  void fetchSpesificData() {
    this.scaleMeasurementsDailyData.clear();
    for (var data in scaleMeasurements) {
      if (data.date.difference(_startDate).inDays >= 0 &&
          data.date.difference(_endDate).inDays <= 0) {
        this.scaleMeasurementsDailyData.add(data);
      }
    }
    setChartDailyData();
  }

  void fetchScaleMeasurements() {
    final result = getIt<ScaleStorageImpl>().getAll();
    this.scaleMeasurements.clear();
    this.scaleMeasurements =
        result.map((e) => ScaleMeasurementViewModel(scaleModel: e)).toList();
    this.scaleMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  List<DateTime> fetchScaleMeasurementsDateList() {
    bool isInclude = false;
    List<DateTime> scaleMeasurementDates = <DateTime>[];
    for (var data in scaleMeasurements) {
      for (var data2 in scaleMeasurementDates) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(data2.year, data2.month, data2.day))) {
          isInclude = true;
        }
      }
      if (!isInclude) {
        scaleMeasurementDates
            .add(DateTime(data.date.year, data.date.month, data.date.day));
      }
      isInclude = false;
      scaleMeasurementDates.sort((a, b) => a.compareTo(b));
    }
    return scaleMeasurementDates;
  }

  void fetchScaleMeasurementsInDateRange(DateTime start, DateTime end) {
    final result = getIt<ScaleStorageImpl>().getAll();
    this.scaleMeasurements.clear();
    for (var e in result) {
      DateTime measurementDate = ScaleMeasurementViewModel(scaleModel: e).date;
      if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
        scaleMeasurements.add(ScaleMeasurementViewModel(scaleModel: e));
      }
    }
    this.scaleMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  void showFilter(BuildContext context) {
    Atom.show(
      ScaleChartFilterPopup(
        height: context.HEIGHT * .52,
        width: context.WIDTH * .6,
      ),
    );
  }

  @override
  Widget largeWidget(Function() callBack) {
    return ScaleProgressPage(callBack: callBack);
  }

  @override
  Widget smallWidget(Function() callBack) {
    ScaleMeasurementViewModel lastMeasurement = ScaleMeasurementViewModel(
        scaleModel: getIt<ScaleStorageImpl>().getLatestMeasurement());

    return RbioSmallChronicWidget(
      callback: callBack,
      lastMeasurement:
          '${lastMeasurement?.weight ?? ''} ${lastMeasurement?.unit?.toStr ?? ''}',
      lastMeasurementDate: lastMeasurement?.date ?? DateTime.now(),
      imageUrl: rBio.R.image.ct_body_scale,
    );
  }

  @override
  void manuelEntry(BuildContext context) {
    showScaleTagger(context);
  }

  getNewItems() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((selected == TimePeriodFilter.DAILY) && !hasReachEnd) {
        scaleMeasurements.sort((a, b) => b.date.compareTo(a.date));

        getIt<ScaleStorageImpl>()
            .getAndWriteScaleData(endDate: scaleMeasurements.last.date)
            .then((value) => hasReachEnd = value);
      }
    });
  }
}
