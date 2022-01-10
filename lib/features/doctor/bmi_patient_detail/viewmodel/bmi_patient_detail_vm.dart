import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/core.dart';
import '../../../../core/data/repository/doctor_repository.dart';
import '../../../../model/model.dart';
import '../../../chronic_tracking/lib/widgets/utils/time_period_filters.dart';
import '../../../chronic_tracking/progress_sections/scale_progress/utils/scale_filter_pop_up/scale_filter_pop_up.dart';
import '../../../chronic_tracking/progress_sections/scale_progress/utils/scale_measurements/scale_measurement_vm.dart';
import '../../../chronic_tracking/progress_sections/scale_progress/view_model/scale_progress_page_view_model.dart';
import '../../../chronic_tracking/utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../../chronic_tracking/utils/selected_scale_type.dart';
import '../../notifiers/patient_notifiers.dart';
import '../widget/charts/animated_scale_buble_chart.dart';
import '../widget/charts/animated_scale_line_chart.dart';

class BmiPatientDetailVm extends ChangeNotifier
    with RbioVm, IBaseBottomActionsOfGraph {
  BmiPatientDetailVm(this.mContext, this.patientId) {
    update();
  }

  int patientId;

  bool _disposed = false;
  bool isDataLoading = false;
  DateTime _scrolledDate;

  LoadingProgress _stateProcessPatientDetail;
  LoadingProgress _stateProcessPatientMeasurements;
  DoctorPatientDetailModel _patientDetail;

  List<ScaleModel> scaleData = <ScaleModel>[];
  List<DateTime> scaleMeasurmentDates = <DateTime>[];

  List<ScaleMeasurementViewModel> scaleMeasurement =
      <ScaleMeasurementViewModel>[];

  List<ScaleMeasurementViewModel> bmiMeasurementsDailyData =
      <ScaleMeasurementViewModel>[];

  LoadingProgress get stateProcessPatientDetail =>
      this._stateProcessPatientDetail;

  LoadingProgress get stateProcessPatientMeasurements =>
      this._stateProcessPatientMeasurements;

  List<TimePeriodFilter> get items => [
        TimePeriodFilter.DAILY,
        TimePeriodFilter.WEEKLY,
        TimePeriodFilter.MONTHLY,
        TimePeriodFilter.MONTHLY_THREE,
        TimePeriodFilter.SPECIFIC
      ];

  List<ChartData> _chartData;

  List<ChartData> _chartVeryLow;

  List<ChartData> _chartLow;

  List<ChartData> _chartTarget;

  List<ChartData> _chartHigh;

  List<ChartData> _chartVeryHigh;

  List<ChartData> get chartData => _chartData;

  int get targetMin => scaleMeasurement.isEmpty
      ? 0
      : scaleMeasurement[0].minRange(currentScaleType);

  int get targetMax => scaleMeasurement.isEmpty
      ? 0
      : scaleMeasurement[0].maxRange(currentScaleType);

  int get dailyHighestValue {
    int highest = bmiMeasurementsDailyData.isNotEmpty &&
            scaleMeasurement[0].getMeasurement(currentScaleType) != null
        ? bmiMeasurementsDailyData[0].getMeasurement(currentScaleType).toInt()
        : 70;
    for (var data in bmiMeasurementsDailyData) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType).toInt();
        if (_currentValue > highest) {
          highest = _currentValue;
        }
      }
    }
    return highest > targetMax ? highest + 10 : targetMax + 10;
  }

  int get dailyLowestValue {
    int lowest = bmiMeasurementsDailyData.isNotEmpty &&
            scaleMeasurement[0].getMeasurement(currentScaleType) != null
        ? bmiMeasurementsDailyData[0].getMeasurement(currentScaleType).toInt()
        : 50;
    for (var data in bmiMeasurementsDailyData) {
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
    int highest = scaleMeasurement.isNotEmpty &&
            scaleMeasurement[0].getMeasurement(currentScaleType) != null
        ? scaleMeasurement[0].getMeasurement(currentScaleType).toInt()
        : 300;
    for (var data in scaleMeasurement) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType).toInt();
        if (_currentValue > highest) {
          highest = _currentValue;
        }
      }
    }
    return highest;
  }

  int get lowestValue {
    int lowest = scaleMeasurement.isNotEmpty &&
            scaleMeasurement[0].getMeasurement(currentScaleType) != null
        ? scaleMeasurement[0].getMeasurement(currentScaleType).toInt()
        : 50;
    for (var data in scaleMeasurement) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType).toInt();
        if (_currentValue < lowest) {
          lowest = _currentValue;
        }
      }
    }
    return lowest;
  }

  changeScaleType(SelectedScaleType type) {
    _selectedItem = type;
    setSelectedItem(selected);
  }

  TimePeriodFilter _selected;
  TimePeriodFilter get selected => _selected ?? items[0];

  SelectedScaleType _selectedItem;

  SelectedScaleType get currentScaleType =>
      _selectedItem ?? SelectedScaleType.WEIGHT;

  int _currentDateIndex;

  int get currentDateIndex => _currentDateIndex ?? 0;

  Future<void> update() async {
    isDataLoading = true;
    notifyListeners();

    await fetchPatientDetail();
    await fetchBmiMeasurements();
    fetchScrolledDailyData();

    isDataLoading = false;
    notifyListeners();
  }

  DateTime _startDate, _endDate;

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    this._startDate = d;
    this._currentDateIndex = 0;
    await fetchBpMeasurementsInDateRange(
        startDate, endDate.add(Duration(days: 1)));

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
    fetchBpMeasurementsInDateRange(startDate, endDate.add(Duration(days: 1)));

    notifyListeners();
  }

  Future<void> nextDate() async {
    await setStartDate(endDate);
    if (selected == LocaleProvider.current.weekly) {
      await setEndDate(endDate.add(Duration(days: 7)));
    } else if (selected == LocaleProvider.current.monthly) {
      await setEndDate(DateTime(endDate.year, endDate.month + 1, 1));
    } else if (selected == LocaleProvider.current.three_months) {
      await setEndDate(DateTime(endDate.year, endDate.month + 3, 1));
    }
    setChartAverageDataPerDay();
    notifyListeners();
  }

  Future<void> previousDate() async {
    await setEndDate(startDate);
    if (selected == LocaleProvider.current.weekly) {
      await setStartDate(startDate.subtract(Duration(days: 7)));
    } else if (selected == LocaleProvider.current.monthly) {
      await setStartDate(DateTime(startDate.year, startDate.month - 1, 1));
    } else if (selected == LocaleProvider.current.three_months) {
      await setStartDate(DateTime(startDate.year, startDate.month - 3, 1));
    }
    setChartAverageDataPerDay();
    notifyListeners();
  }

  void setChartAverageDataPerDay() {
    this.bmiMeasurementsDailyData = scaleMeasurement;
    setChartDailyData();
  }

  void setChartDailyData() {
    try {
      List<ChartData> tempChartData = <ChartData>[];
      for (var data in this.bmiMeasurementsDailyData) {
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
    } catch (e) {
      log(e);
    }
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

    for (var data in this.bmiMeasurementsDailyData) {
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

    for (var data in this.bmiMeasurementsDailyData) {
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

    for (var data in this.bmiMeasurementsDailyData) {
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

    for (var data in this.bmiMeasurementsDailyData) {
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

    for (var data in this.bmiMeasurementsDailyData) {
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

  Future<void> fetchPatientDetail() async {
    _stateProcessPatientDetail = LoadingProgress.LOADING;
    notifyListeners();
    try {
      await Provider.of<PatientNotifiers>(mContext, listen: false)
          .fetchPatientDetail(patientId: patientId);
      this._patientDetail =
          Provider.of<PatientNotifiers>(mContext, listen: false).patientDetail;
      _stateProcessPatientDetail = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      dispose(); //Dispose if patient detail is not available.
      _stateProcessPatientDetail = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  void fetchScrolledData(DateTime date) {
    print(date);
    if (date != null && selected == TimePeriodFilter.DAILY) {
      var _temp = DateTime(_scrolledDate?.year ?? 2000,
          _scrolledDate?.month ?? 01, _scrolledDate?.day ?? 01);
      var _cross = DateTime(date.year, date.month, date.day);
      if (_scrolledDate == null || (_temp != _cross)) {
        _scrolledDate = date;
        this.bmiMeasurementsDailyData.clear();

        for (var data in scaleMeasurement) {
          if (DateTime(data.date.year, data.date.month, data.date.day)
              .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
            this.bmiMeasurementsDailyData.add(data);
          }
        }

        setChartDailyData();
      }
    }
  }

  void fetchScrolledDailyData() {
    this.bmiMeasurementsDailyData.clear();
    List<DateTime> dateList = scaleMeasurmentDates;
    List<DateTime> reversedList = dateList.reversed.toList();
    if (reversedList.isNotEmpty) {
      DateTime currentDate = reversedList[currentDateIndex];
      for (var data in scaleMeasurement) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(
                currentDate.year, currentDate.month, currentDate.day))) {
          this.bmiMeasurementsDailyData.add(data);
        }
      }
    }
    setChartDailyData();
  }

  Future<void> setSelectedItem(TimePeriodFilter s) async {
    print('data-----------> $s');

    this._currentDateIndex = 0;
    notifyListeners();
    this._selected = s;
    notifyListeners();
    if (s == TimePeriodFilter.SPECIFIC) {
      await fetchBmiMeasurements();
      fetchScrolledDailyData();
    } else if (s == TimePeriodFilter.DAILY) {
      await fetchBmiMeasurements();
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
    if (s == LocaleProvider.current.weekly) {
      setChartAverageDataPerDay();
    } else if (s == LocaleProvider.current.monthly) {
      setChartAverageDataPerDay();
    } else if (s == LocaleProvider.current.three_months) {
      setChartAverageDataPerDay();
    }
    notifyListeners();
  }

  Widget _currentGraph;
  Widget get currentGraph =>
      _currentGraph ?? AnimationPatientScaleScatterDefault();

  GraphType _currentGraphType;

  GraphType get currentGraphType => _currentGraphType ?? GraphType.BUBBLE;

  @override
  void changeGraphType() {
    if (currentGraphType == GraphType.BUBBLE) {
      this._currentGraphType = GraphType.LINE;
    } else {
      this._currentGraphType = GraphType.BUBBLE;
    }
    setCurrentGraph();
    notifyListeners();
  }

  setCurrentGraph() {
    currentGraphType == GraphType.BUBBLE
        ? this._currentGraph = AnimationPatientScaleScatterDefault()
        : this._currentGraph = AnimationPatientScaleLineDefaultState();
  }

  @override
  BuildContext mContext;

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void showEditAlert(Widget child) {
    showDialog(
      context: mContext,
      builder: (BuildContext context) {
        return child;
      },
    ).then((value) => value != null && value ? update() : null);
  }

  void showInformationDialog(String text) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(
          LocaleProvider.current.warning,
          text,
        );
      },
    ).then((value) => Navigator.pop(mContext));
  }

  @override
  void showFilter(BuildContext tcontext) {
    Atom.show(
      ChangeNotifierProvider<BmiPatientDetailVm>.value(
        value: this,
        child: ScaleChartFilterPopup(
          selected: _selectedItem,
          height: tcontext.HEIGHT * .52,
          width: tcontext.WIDTH * .6,
          isDoctor: true,
          changeScaleType: (p0) {
            _selectedItem = p0;
            setSelectedItem(selected);
          },
        ),
      ),
      barrierColor: Colors.black12,
    );
  }

  Future fetchBmiMeasurements() async {
    final result = await getIt<DoctorRepository>().getMyPatientScale(
      patientId,
      GetMyPatientFilter(end: null, start: null),
    );

    this.scaleData = result;

    this.scaleMeasurement.clear();

    this.scaleMeasurement =
        scaleData.map((e) => ScaleMeasurementViewModel(scaleModel: e)).toList();
    scaleMeasurement.removeWhere(
        (element) => element.getMeasurement(currentScaleType) == null);
    var year = int.parse(_patientDetail.birthDay.split('.')[2]);
    for (var item in scaleMeasurement) {
      item.age = year < 10 ? 15 : year;
    }
    this.scaleMeasurement.sort((a, b) => a.date.compareTo(b.date));

    fetchBmiMeasurementsDateList();
  }

  Future<void> fetchBpMeasurementsInDateRange(
      DateTime start, DateTime end) async {
    scaleMeasurement.clear();
    for (var e in scaleData) {
      if (!scaleData.contains(ScaleMeasurementViewModel(scaleModel: e))) {
        DateTime measurementDate =
            ScaleMeasurementViewModel(scaleModel: e).date;
        if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
          scaleMeasurement.add(ScaleMeasurementViewModel(scaleModel: e));
        }
      }
    }
    this.scaleMeasurement.sort((a, b) => a.date.compareTo(b.date));
    fetchBmiMeasurementsDateList();
  }

  void fetchBmiMeasurementsDateList() {
    bool isInclude = false;
    this.scaleMeasurmentDates.clear();
    for (var data in scaleMeasurement) {
      for (var data2 in scaleMeasurmentDates) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(data2.year, data2.month, data2.day))) {
          isInclude = true;
        }
      }
      if (!isInclude) {
        this
            .scaleMeasurmentDates
            .add(DateTime(data.date.year, data.date.month, data.date.day));
      }
      isInclude = false;
      this.scaleMeasurmentDates.sort((a, b) => a.compareTo(b));
    }
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
}
