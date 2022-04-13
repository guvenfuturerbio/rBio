import 'package:flutter/material.dart';
import 'package:scale_repository/scale_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:scale_calculations/scale_calculations.dart';

import '../../../../../core/core.dart';
import '../../../../../model/model.dart';
import '../../../bottom_actions_of_graph.dart';
import '../../widgets/i_progress_screen.dart';
import '../../widgets/small_chronic_component.dart';
import '../view/scale_progress_screen.dart';
import '../widgets/charts/scale_bubble_chart.dart';
import '../widgets/charts/scale_line_chart.dart';
import '../widgets/scale_filter_pop_up/scale_filter_pop_up.dart';
import '../widgets/tagger/scale_tagger_pop_up.dart';

enum GraphType { bubble, line }

class ScaleProgressVm extends ChangeNotifier
    with IBaseBottomActionsOfGraph
    implements IProgressScreen {
  final controller = ScrollController();
  bool hasReachEnd = false;

  ScaleProgressVm() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      isChartShow = true;

      final heightCheck = Utils.instance.checkUserHeight();
      if (!heightCheck) return;

      scaleMeasurementsDailyData = getIt<ScaleRepository>().readLocalScaleData(
        Utils.instance.getAge(),
        Utils.instance.getGender(),
        Utils.instance.getHeight()!,
      );
      scaleMeasurements = scaleMeasurementsDailyData;

      // getIt<ScaleStorageImpl>().addListener(() async {
      //   LoggerUtils.instance.i("Triggered ScaleRepository Listener");
      //   setSelectedItem(selected);
      // });

      fetchScaleMeasurements();
      fetchScrolledDailyData();
      controller.addListener(() {
        if (controller.position.atEdge && controller.position.pixels != 0) {
          getNewItems();
        }
      });
    });
  }

  bool isChartShow = false;

  @override
  changeChartShowStatus() {
    isChartShow = !isChartShow;
    notifyListeners();
  }

  Widget get bubleChart => const ScaleBubbleChart();

  Widget? _currentGraph;

  GraphType? _currentGraphType;

  List<ScaleEntity> scaleMeasurementsDailyData = <ScaleEntity>[];

  List<ScaleEntity> scaleMeasurements = <ScaleEntity>[];

  List<ChartData>? _chartData;

  List<ChartData>? _chartVeryLow;

  List<ChartData>? _chartLow;

  List<ChartData>? _chartTarget;

  List<ChartData>? _chartHigh;

  List<ChartData>? _chartVeryHigh;

  int? _listLastIndex;

  TimePeriodFilter? _selectedItem;

  DateTime? _startDate, _endDate;

  int? _currentDateIndex;

  final Map<int, List<ChartData>> _chartDataTagged = <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartVeryLowTagged =
      <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartLowTagged = <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartTargetTagged = <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartHighTagged = <int, List<ChartData>>{};

  final Map<int, List<ChartData>> _chartVeryHighTagged =
      <int, List<ChartData>>{};

  final Map<Color, ScaleMarginsFilter> _colorInfo =
      <Color, ScaleMarginsFilter>{};

  Map<Color, ScaleMarginsFilter> get colorInfo {
    _colorInfo.putIfAbsent(R.color.very_low, () => ScaleMarginsFilter.veryLow);
    _colorInfo.putIfAbsent(R.color.low, () => ScaleMarginsFilter.low);
    _colorInfo.putIfAbsent(R.color.target, () => ScaleMarginsFilter.target);
    _colorInfo.putIfAbsent(R.color.high, () => ScaleMarginsFilter.high);
    _colorInfo.putIfAbsent(
        R.color.very_high, () => ScaleMarginsFilter.veryHigh);
    return _colorInfo;
  }

  DateTime? _scrolledDate;

  Map<ScaleMarginsFilter, bool> _colorFilterState =
      <ScaleMarginsFilter, bool>{};
  Map<ScaleMarginsFilter, bool> get colorFilterState {
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.veryLow, () => true);
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.low, () => true);
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.target, () => true);
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.high, () => true);
    _colorFilterState.putIfAbsent(ScaleMarginsFilter.other, () => true);
    return _colorFilterState;
  }

  bool? isFilterSelected(SelectedScaleType filter) {
    return colorFilterState[filter];
  }

  SelectedScaleType? _selectedScaleType;
  SelectedScaleType get currentScaleType =>
      _selectedScaleType ?? SelectedScaleType.weight;

  Map<int, List<ChartData>> get chartDataTagged => _chartDataTagged;

  Map<int, List<ChartData>> get chartVeryLowTagged => _chartVeryLowTagged;

  Map<int, List<ChartData>> get chartLowTagged => _chartLowTagged;

  Map<int, List<ChartData>> get chartTargetTagged => _chartTargetTagged;

  Map<int, List<ChartData>> get chartHighTagged => _chartHighTagged;

  Map<int, List<ChartData>> get chartVeryHighTagged => _chartVeryHighTagged;

  int? get targetMin {
    if (scaleMeasurements.isEmpty) {
      return 0;
    } else {
      return ScaleRanges.instance.getTargetMin(
        type: currentScaleType,
        age: scaleMeasurements[0].age,
        height: scaleMeasurements[0].height,
        water: scaleMeasurements[0].water,
        gender: scaleMeasurements[0].gender,
        visceralFat: scaleMeasurements[0].visceralFat,
      );
    }
  }

  int? get targetMax {
    if (scaleMeasurements.isEmpty) {
      return 0;
    } else {
      return ScaleRanges.instance.getTargetMax(
        type: currentScaleType,
        age: scaleMeasurements[0].age,
        height: scaleMeasurements[0].height,
        water: scaleMeasurements[0].water,
        gender: scaleMeasurements[0].gender,
        visceralFat: scaleMeasurements[0].visceralFat,
      );
    }
  }

  int get criticMin => getIt<ProfileStorageImpl>().getFirst().hypo!;

  int get criticMax => getIt<ProfileStorageImpl>().getFirst().hyper!;

  int get dailyHighestValue {
    int highest = scaleMeasurementsDailyData.isNotEmpty &&
            scaleMeasurements[0].getMeasurement(currentScaleType) != null
        ? (scaleMeasurementsDailyData[0].getMeasurement(currentScaleType) ?? 0)
            .toInt()
        : 70;
    for (var data in scaleMeasurementsDailyData) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType)!.toInt();
        if (_currentValue > highest) {
          highest = _currentValue;
        }
      }
    }
    return highest > (targetMax ?? 0) ? highest + 10 : targetMax ?? 0 + 10;
  }

  changeScaleType(SelectedScaleType type) {
    _selectedScaleType = type;
    setSelectedItem(selected);
  }

  int get dailyLowestValue {
    int lowest = scaleMeasurementsDailyData.isNotEmpty &&
            scaleMeasurements[0].getMeasurement(currentScaleType) != null
        ? (scaleMeasurementsDailyData[0].getMeasurement(currentScaleType) ?? 0)
            .toInt()
        : 50;

    for (var data in scaleMeasurementsDailyData) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType)!.toInt();
        if (_currentValue < lowest) {
          lowest = _currentValue;
        }
      }
    }
    return lowest < (targetMin ?? 0) ? (targetMin ?? 15) - 15 : lowest - 15;
  }

  int get highestValue {
    int highest = scaleMeasurements.isNotEmpty &&
            scaleMeasurements[0].getMeasurement(currentScaleType) != null
        ? scaleMeasurements[0].getMeasurement(currentScaleType)!.toInt()
        : 300;
    for (var data in scaleMeasurements) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType)!.toInt();
        if (_currentValue > highest) {
          highest = _currentValue;
        }
      }
    }
    return highest;
  }

  int get lowestValue {
    int lowest = scaleMeasurements.isNotEmpty &&
            scaleMeasurements[0].getMeasurement(currentScaleType) != null
        ? scaleMeasurements[0].getMeasurement(currentScaleType)!.toInt()
        : 50;
    for (var data in scaleMeasurements) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType)!.toInt();
        if (_currentValue < lowest) {
          lowest = _currentValue;
        }
      }
    }
    return lowest;
  }

  int get totalValuableCount {
    int totalCount = 0;
    if (_chartData != null) {
      for (var data in _chartData!) {
        if (data.y > 0) {
          totalCount++;
        }
      }
    }
    return totalCount;
  }

  void setCurrentGraph() {
    currentGraphType == GraphType.bubble
        ? _currentGraph = const ScaleBubbleChart()
        : _currentGraph = const ScaleLineChart();
    notifyListeners();
  }

  Widget get currentGraph => _currentGraph ?? const ScaleBubbleChart();

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

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate!.year, _startDate!.month, _startDate!.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    _startDate = d;
    _currentDateIndex = 0;

    // await getIt<ScaleStorageImpl>().getAndWriteScaleData(
    //   beginDate: _startDate,
    //   endDate: endDate.add(
    //     const Duration(days: 1),
    //   ),
    // );

    fetchScaleMeasurementsInDateRange(
      startDate,
      endDate.add(
        const Duration(days: 1),
      ),
    );

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

    // await getIt<ScaleStorageImpl>().getAndWriteScaleData(
    //   beginDate: _startDate,
    //   endDate: endDate.add(
    //     const Duration(days: 1),
    //   ),
    // );

    fetchScaleMeasurementsInDateRange(
      startDate,
      endDate.add(
        const Duration(days: 1),
      ),
    );

    notifyListeners();
  }

  int get listLastIndex => _listLastIndex ?? 0;

  void setListLastIndex(int index) {
    _listLastIndex = index;
  }

  int get currentDateIndex => _currentDateIndex ?? 0;

  void setCurrentDateIndex(int value) {
    currentDateIndex += value;
    if (_currentDateIndex! < 0) {
      _currentDateIndex = 0;
    }
  }

  changeStartDate(DateTime date) {
    _startDate = date;
    setSelectedItem(selected);
  }

  changeEndDate(DateTime date) {
    _endDate = date;
    setSelectedItem(selected);
  }

  set currentDateIndex(int val) => _currentDateIndex = val;

  void fetchScrolledData(DateTime? date) {
    if (date != null && selected == TimePeriodFilter.daily) {
      var _temp = DateTime(_scrolledDate?.year ?? 2000,
          _scrolledDate?.month ?? 01, _scrolledDate?.day ?? 01);
      var _cross = DateTime(date.year, date.month, date.day);
      if (_scrolledDate == null || (_temp != _cross)) {
        _scrolledDate = date;
        scaleMeasurementsDailyData.clear();

        for (var data in scaleMeasurements) {
          if (DateTime(
                  data.dateTime.year, data.dateTime.month, data.dateTime.day)
              .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
            scaleMeasurementsDailyData.add(data);
          }
        }

        setChartDailyData();
      }
    }
  }

  void fetchScrolledDailyData() {
    scaleMeasurementsDailyData.clear();
    List<DateTime> dateList = fetchScaleMeasurementsDateList();
    //LoggerUtils.instance.i(dateList.toString());
    List<DateTime> reversedList = dateList.reversed.toList();
    if (reversedList.isNotEmpty) {
      DateTime currentDate = reversedList[currentDateIndex];
      //LoggerUtils.instance.i("current Date " + reversedList[currentDateIndex].toString());
      for (var data in scaleMeasurements) {
        if (DateTime(data.dateTime.year, data.dateTime.month, data.dateTime.day)
            .isAtSameMomentAs(DateTime(
                currentDate.year, currentDate.month, currentDate.day))) {
          scaleMeasurementsDailyData.add(data);
        }
      }
    }
    setChartDailyData();
  }

  List<ChartData> get chartData => _chartData ?? [];

  void setChartDailyData() {
    List<ChartData> tempChartData = <ChartData>[];
    for (var data in scaleMeasurementsDailyData) {
      if (data.getMeasurement(currentScaleType) != null) {
        tempChartData.add(
          ChartData(
            data.dateTime,
            data.getMeasurement(currentScaleType)!.toInt(),
            data.getColor(currentScaleType),
          ),
        );
      }
    }
    _chartData = tempChartData;
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

  List<ChartData> get chartVeryLow => _chartVeryLow ?? [];

  void setChartVeryLow() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.very_low) {
        tempChartData.add(ChartData(
            data.dateTime,
            data.getMeasurement(currentScaleType)!.toInt(),
            data.getColor(currentScaleType)));
      }
    }
    _chartVeryLow = tempChartData;
    notifyListeners();
  }

  List<ChartData> get chartLow => _chartLow ?? [];

  void setChartLow() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.low) {
        tempChartData.add(ChartData(
            data.dateTime,
            data.getMeasurement(currentScaleType)!.toInt(),
            data.getColor(currentScaleType)));
      }
    }
    _chartLow = tempChartData;
    notifyListeners();
  }

  List<ChartData> get chartTarget => _chartTarget ?? [];

  void setChartTarget() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.target) {
        tempChartData.add(ChartData(
            data.dateTime,
            data.getMeasurement(currentScaleType)!.toInt(),
            data.getColor(currentScaleType)));
      }
    }
    _chartTarget = tempChartData;
    notifyListeners();
  }

  List<ChartData> get chartHigh => _chartHigh ?? [];

  void setChartHigh() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.high) {
        tempChartData.add(ChartData(
            data.dateTime,
            data.getMeasurement(currentScaleType)!.toInt(),
            data.getColor(currentScaleType)));
      }
    }
    _chartHigh = tempChartData;
    notifyListeners();
  }

  List<ChartData> get chartVeryHigh => _chartVeryHigh ?? [];

  void setChartVeryHigh() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in scaleMeasurementsDailyData) {
      if (data.getColor(currentScaleType) == R.color.very_high) {
        tempChartData.add(ChartData(
            data.dateTime,
            data.getMeasurement(currentScaleType)!.toInt(),
            data.getColor(currentScaleType)));
      }
    }
    _chartVeryHigh = tempChartData;
    notifyListeners();
  }

  void setChartAverageDataPerDay() {
    scaleMeasurementsDailyData = scaleMeasurements;
    setChartDailyData();
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
    notifyListeners();
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
    notifyListeners();
  }

  Future<void> updateScaleMeasurement() async {
    if (selected == TimePeriodFilter.daily) {
      fetchScaleMeasurements();
    } else {
      fetchScaleMeasurementsInDateRange(
          startDate, endDate.add(const Duration(days: 1)));
    }

    if (selected == TimePeriodFilter.daily ||
        selected == TimePeriodFilter.spesific) {
      fetchScrolledDailyData();
    } else {
      setChartAverageDataPerDay();
    }
  }

  void resetFilterState() {
    _colorFilterState = <ScaleMarginsFilter, bool>{};
    notifyListeners();
  }

  List<ScatterSeries<ChartData, DateTime>> getDataScatterSeries() {
    return <ScatterSeries<ChartData, DateTime>>[
      ScatterSeries<ChartData, DateTime>(
        dataSource: chartVeryLow,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: R.color.very_low,
        xAxisName: "Time",
        markerSettings: const MarkerSettings(
          height: 15,
          width: 15,
          isVisible: true,
          shape: DataMarkerType.circle,
        ),
      ),
      ScatterSeries<ChartData, DateTime>(
        dataSource: chartLow,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: R.color.low,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: const MarkerSettings(
          height: 15,
          width: 15,
          shape: DataMarkerType.circle,
          isVisible: true,
        ),
      ),
      ScatterSeries<ChartData, DateTime>(
        dataSource: chartTarget,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: R.color.target,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          color: R.color.very_low,
          height: 15,
          width: 15,
          shape: DataMarkerType.circle,
          isVisible: true,
        ),
      ),
      ScatterSeries<ChartData, DateTime>(
        dataSource: chartHigh,
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
          isVisible: true,
        ),
      ),
      ScatterSeries<ChartData, DateTime>(
        dataSource: chartVeryHigh,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: R.color.very_high,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          color: R.color.very_high,
          height: 15,
          width: 15,
          isVisible: true,
          shape: DataMarkerType.circle,
        ),
      ),
    ];
  }

  void showScaleTagger(BuildContext context) {
    Atom.show(
      const ScaleTaggerPopUp(),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
  }

  Future<void> setSelectedItem(TimePeriodFilter s) async {
    resetFilterState();
    _currentDateIndex = 0;
    notifyListeners();

    _selectedItem = s;
    setCurrentGraph();
    notifyListeners();

    if (s == TimePeriodFilter.spesific) {
      fetchScaleMeasurements();
      fetchSpesificData();
    } else if (s == TimePeriodFilter.daily) {
      fetchScaleMeasurements();
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
    }
    if (s == TimePeriodFilter.weekly) {
      setChartAverageDataPerDay();
    } else if (s == TimePeriodFilter.monthly) {
      setChartAverageDataPerDay();
    } else if (s == TimePeriodFilter.monthlyThree) {
      setChartAverageDataPerDay();
    }
    notifyListeners();
  }

  void fetchSpesificData() {
    scaleMeasurementsDailyData.clear();
    for (var data in scaleMeasurements) {
      if (data.dateTime.difference(_startDate!).inDays >= 0 &&
          data.dateTime.difference(_endDate!).inDays <= 0) {
        scaleMeasurementsDailyData.add(data);
      }
    }
    setChartDailyData();
  }

  void fetchScaleMeasurements() {
    final heightCheck = Utils.instance.checkUserHeight();
    if (!heightCheck) return;

    final result = getIt<ScaleRepository>().readLocalScaleData(
      Utils.instance.getAge(),
      Utils.instance.getGender(),
      Utils.instance.getHeight()!,
    );
    scaleMeasurements.clear();
    scaleMeasurements = result.map((e) => e).toList();
    scaleMeasurements.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  List<DateTime> fetchScaleMeasurementsDateList() {
    bool isInclude = false;
    List<DateTime> scaleMeasurementDates = <DateTime>[];
    for (var data in scaleMeasurements) {
      for (var data2 in scaleMeasurementDates) {
        if (DateTime(data.dateTime.year, data.dateTime.month, data.dateTime.day)
            .isAtSameMomentAs(DateTime(data2.year, data2.month, data2.day))) {
          isInclude = true;
        }
      }
      if (!isInclude) {
        scaleMeasurementDates.add(DateTime(
            data.dateTime.year, data.dateTime.month, data.dateTime.day));
      }
      isInclude = false;
      scaleMeasurementDates.sort((a, b) => a.compareTo(b));
    }
    return scaleMeasurementDates;
  }

  void fetchScaleMeasurementsInDateRange(DateTime start, DateTime end) {
    // final result = getIt<ScaleStorageImpl>().getAll();
    // scaleMeasurements.clear();
    for (var e in scaleMeasurements) {
      DateTime measurementDate = e.dateTime;
      if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
        //scaleMeasurements.add(ScaleMeasurementLogic(scaleModel: e));
      }
    }
    scaleMeasurements.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  void showFilter(BuildContext context) {
    Atom.show(
      ScaleChartFilterPopup(
        height: context.height * .52,
        width: context.width * .6,
        changeScaleType: changeScaleType,
      ),
    );
  }

  @override
  Widget largeWidget() => ScaleProgressScreen(callBack: changeChartShowStatus);

  @override
  Widget smallWidget(Function() callBack) {
    // ScaleMeasurementLogic? lastMeasurement =
    //     getIt<ScaleStorageImpl>().getLatestMeasurement() != null
    //         ? ScaleMeasurementLogic(
    //             scaleModel: getIt<ScaleStorageImpl>().getLatestMeasurement()!)
    //         : null;

    final heightCheck = Utils.instance.checkUserHeight();
    ScaleEntity? scaleEntity;
    if (heightCheck) {
      scaleEntity = getIt<ScaleRepository>().getLatestMeasurement(
        Utils.instance.getAge(),
        Utils.instance.getGender(),
        Utils.instance.getHeight()!,
      );
    }

    return SmallChronicComponent(
      callback: callBack,
      lastMeasurement: heightCheck == false
          ? LocaleProvider.current.no_measurement
          : scaleEntity == null
              ? LocaleProvider.current.no_measurement
              : '${(scaleEntity.weight ?? 0).xGetFriendyString} ${scaleEntity.getUnit}',
      lastMeasurementDate: heightCheck == false
          ? DateTime.now()
          : scaleEntity?.dateTime ?? DateTime.now(),
      imageUrl: R.image.bodyScale,
    );
  }

  @override
  void manuelEntry(BuildContext context) {
    showScaleTagger(context);
  }

  void getNewItems() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        if ((selected == TimePeriodFilter.daily) && !hasReachEnd) {
          scaleMeasurements.sort((a, b) => b.dateTime.compareTo(a.dateTime));

          // getIt<ScaleStorageImpl>()
          //     .getAndWriteScaleData(endDate: scaleMeasurements.last.dateTime)
          //     .then((value) => hasReachEnd = value);
        }
      },
    );
  }
}
