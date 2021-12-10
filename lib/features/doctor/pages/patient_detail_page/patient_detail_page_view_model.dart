import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../../chronic_tracking/utils/glucose_margins_filter.dart';
import '../../notifiers/bg_measurements_notifiers.dart';
import '../../notifiers/patient_notifiers.dart';
import '../../utils/bgpickers/bgpicker.dart';
import '../../utils/chart_filter_popup.dart';
import '../../utils/charts/line/animated_line_chart.dart';
import '../../utils/charts/scatter/animated_bubble_chart.dart';
import '../../utils/hypo_hyper_edit/hypo_hyper_edit.dart';
import '../../utils/hypo_hyper_edit/hypo_hyper_edit_view_model.dart';
import '../../utils/sliders/range_setter_slider.dart';

enum GraphType { BUBBLE, LINE }

class PatientDetailPageViewModel with ChangeNotifier {
  BuildContext context;
  StateProcess _stateProcessPatientDetail;
  StateProcess _stateProcessPatientMeasurements;
  DoctorPatientDetailModel _patientDetail;
  int _patientId;
  get patientid => _patientId;
  bool _disposed = false;
  bool isDataLoading = false;
  DateTime _scrolledDate;

  PatientDetailPageViewModel({BuildContext context, int patientId}) {
    this.context = context;
    this._patientId = patientId;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await update();
    });
    // NotificationHandler().addListener(() async {
    //   if (!_disposed) {
    //     var message = NotificationHandler().message;
    //     if (patientId == int.parse(message['patient_id'])) {
    //       DropdownBanner.showBanner(
    //           text: message['name'] +
    //               " için kritik ölçüm " +
    //               message['value'] +
    //               " mg/dL",
    //           color:
    //               message['type'] == "4" ? R.color.veryLow : R.color.veryHigh);
    //       await update();
    //     } else {
    //       DropdownBanner.showBanner(
    //           tapCallback: () {
    //             this._patientId = int.parse(message['patient_id']);
    //             update();
    //           },
    //           text: message['name'] +
    //               " için kritik ölçüm " +
    //               message['value'] +
    //               " mg/dL",
    //           color:
    //               message['type'] == "4" ? R.color.veryLow : R.color.veryHigh);
    //     }
    //   }
    // });
  }

  update() async {
    isDataLoading = true;
    notifyListeners();
    await fetchPatientDetail();
    print('1');
    await fetchBgMeasurements();
    print('2');
    fetchScrolledDailyData();

    isDataLoading = false;
    notifyListeners();
  }

  void fetchScrolledData(DateTime date) {
    if (date != null && selected == LocaleProvider.current.daily) {
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

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  StateProcess get stateProcessPatientDetail => this._stateProcessPatientDetail;

  StateProcess get stateProcessPatientMeasurements =>
      this._stateProcessPatientMeasurements;

  fetchPatientDetail() async {
    _stateProcessPatientDetail = StateProcess.LOADING;
    notifyListeners();
    try {
      await Provider.of<PatientNotifiers>(context, listen: false)
          .fetchPatientDetail(patientId: _patientId);
      this._patientDetail =
          Provider.of<PatientNotifiers>(context, listen: false).patientDetail;
      _stateProcessPatientDetail = StateProcess.DONE;
      notifyListeners();
    } catch (e) {
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      dispose(); //Dispose if patient detail is not available.
      _stateProcessPatientDetail = StateProcess.ERROR;
      notifyListeners();
    }
  }

  DoctorPatientDetailModel get patientDetail => this._patientDetail;

  List<int> _tags = [1, 2, 3];

  Widget _currentGraph;

  GraphType _currentGlucoseGraphType;

  List<String> get items => [
        LocaleProvider.current.daily,
        LocaleProvider.current.weekly,
        LocaleProvider.current.monthly,
        LocaleProvider.current.three_months,
        LocaleProvider.current.specific
      ];

  String get selected => _selectedItem ?? items[0];

  List<BgMeasurementViewModel> bgMeasurementsDailyData = [];

  List<BgMeasurementViewModel> bgMeasurements = [];

  List<ChartData> _chartData;

  List<ChartData> _chartVeryLow;

  List<ChartData> _chartLow;

  List<ChartData> _chartTarget;

  List<ChartData> _chartHigh;

  List<ChartData> _chartVeryHigh;

  int _scrolledListIndex;

  int _listLastIndex;

  String _selectedItem;

  DateTime _startDate, _endDate;

  int _currentDateIndex = 0;

  Map<int, List<ChartData>> _chartDataTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartVeryLowTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartLowTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartTargetTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartHighTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartVeryHighTagged = Map<int, List<ChartData>>();

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

  Map<GlucoseMarginsFilter, bool> _filterState = <GlucoseMarginsFilter, bool>{};
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
      updateBgMeasurement();
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

  resetFilterValues() async {
    try {
      _filterState.forEach((key, value) {
        _filterState[key] = true;
      });
      updateBgMeasurement();

      notifyListeners();
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

  int get targetMin => PatientNotifiers()?.patientDetail?.rangeMin ?? 0;

  int get targetMax => PatientNotifiers()?.patientDetail?.rangeMax ?? 0;

  int get criticMin => PatientNotifiers()?.patientDetail?.hypo ?? 0;

  int get criticMax => PatientNotifiers()?.patientDetail?.hyper ?? 0;

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
    if (currentGlucoseGraphType == GraphType.BUBBLE) {
      this._currentGraph = AnimationScatterDefault();
    } else {
      this._currentGraph = AnimationLineDefault();
    }
    notifyListeners();
  }

  GraphType get currentGlucoseGraphType =>
      _currentGlucoseGraphType ?? GraphType.BUBBLE;

  void changeGraphType() {
    if (currentGlucoseGraphType == GraphType.BUBBLE) {
      this._currentGlucoseGraphType = GraphType.LINE;
    } else {
      this._currentGlucoseGraphType = GraphType.BUBBLE;
    }
    setCurrentGraph();
    notifyListeners();
  }

  Future<void> setSelectedItem(String s) async {
    print('data-----------> $s');
    if (s != _selectedItem) {
      resetFilterState();
      this._currentDateIndex = 0;
      notifyListeners();
      this._selectedItem = s;
      setCurrentGraph();
      notifyListeners();
      if (s == LocaleProvider.current.specific) {
        await fetchBgMeasurements();
        fetchScrolledDailyData();
      } else if (s == LocaleProvider.current.daily) {
        await fetchBgMeasurements();
        fetchScrolledDailyData();
      } else {
        DateTime currentDateEnd = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 23, 59, 00);
        DateTime currentDateStart = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 00, 00);
        s == LocaleProvider.current.weekly
            ? await setStartDate(currentDateStart.subtract(Duration(days: 7)))
            : s == LocaleProvider.current.monthly
                ? await setStartDate(currentDateStart
                    .subtract(Duration(days: currentDateStart.day - 1)))
                : s == LocaleProvider.current.three_months
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
  }

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    this._startDate = d;
    this._currentDateIndex = 0;
    await Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
        .fetchBgMeasurementsInDateRange(
            startDate, endDate.add(Duration(days: 1)));
    this.bgMeasurements =
        Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
            .bgMeasurements;
    print(bgMeasurements.length);
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
    await Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
        .fetchBgMeasurementsInDateRange(
            startDate, endDate.add(Duration(days: 1)));
    this.bgMeasurements =
        Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
            .bgMeasurements;
    //fetchScrolledDailyData();
    notifyListeners();
  }

  int get scrolledIndex => _scrolledListIndex;

  void setScrolledIndex(int index) {
    setListLastIndex(_scrolledListIndex ?? index);
    _scrolledListIndex = index;
    _scrolledListIndex > listLastIndex
        ? setCurrentDateIndex(1)
        : _scrolledListIndex < listLastIndex
            ? setCurrentDateIndex(-1)
            : setCurrentDateIndex(1);
    if (selected == LocaleProvider.current.daily ||
        selected == LocaleProvider.current.specific) {
      fetchScrolledDailyData();
    }
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

  void fetchScrolledDailyData() {
    this.bgMeasurementsDailyData.clear();
    List<DateTime> dateList =
        Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
            .bgMeasurementDates;
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

  List<ChartData> get chartData => _chartData;

  void setChartDailyData() {
    List<ChartData> chartData = [];
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
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

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
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartVeryLow = chartData;
    this._chartVeryLowTagged.putIfAbsent(1, () => chartDataAc);
    this._chartVeryLowTagged.putIfAbsent(2, () => chartDataTok);
    this._chartVeryLowTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  List<ChartData> get chartLow => _chartLow;

  void setChartLow() {
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

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
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartLow = chartData;
    this._chartLowTagged.putIfAbsent(1, () => chartDataAc);
    this._chartLowTagged.putIfAbsent(2, () => chartDataTok);
    this._chartLowTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  List<ChartData> get chartTarget => _chartTarget;

  void setChartTarget() {
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

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
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartTarget = chartData;
    this._chartTargetTagged.putIfAbsent(1, () => chartDataAc);
    this._chartTargetTagged.putIfAbsent(2, () => chartDataTok);
    this._chartTargetTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  List<ChartData> get chartHigh => _chartHigh;

  void setChartHigh() {
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

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
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartHigh = chartData;
    this._chartHighTagged.putIfAbsent(1, () => chartDataAc);
    this._chartHighTagged.putIfAbsent(2, () => chartDataTok);
    this._chartHighTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  List<ChartData> get chartVeryHigh => _chartVeryHigh;

  void setChartVeryHigh() {
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

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
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result), data.resultColor));
        }
      }
    }
    this._chartVeryHigh = chartData;
    this._chartVeryHighTagged.putIfAbsent(1, () => chartDataAc);
    this._chartVeryHighTagged.putIfAbsent(2, () => chartDataTok);
    this._chartVeryHighTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  Future<void> fetchBgMeasurements() async {
    await Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
        .fetchBgMeasurements(patientId: _patientId);
    this.bgMeasurements =
        Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
            .bgMeasurements;
    notifyListeners();
  }

  void setChartDataPerData() {
    this.bgMeasurementsDailyData = this.bgMeasurements;
    setChartGroupData();
  }

  void setChartAverageDataPerDay() {
    this.bgMeasurementsDailyData = bgMeasurements;
    setChartDailyData();
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

  updateBgMeasurement() async {
    if (selected == LocaleProvider.current.daily ||
        selected == LocaleProvider.current.specific) {
      await Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
          .fetchBgMeasurements(patientId: _patientId);
    } else {
      await Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
          .fetchBgMeasurementsInDateRange(
              startDate, endDate.add(Duration(days: 1)));
    }
    this.bgMeasurements =
        Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
            .bgMeasurements;
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
    Provider.of<BgMeasurementsNotifierDoc>(context, listen: false)
        .fetchBgMeasurementsDateList(bgMeasurements);
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
    if (selected == LocaleProvider.current.daily ||
        selected == LocaleProvider.current.specific) {
      fetchScrolledDailyData();
    } else {
      setChartAverageDataPerDay();
    }
  }

  resetFilterState() {
    _filterState = <GlucoseMarginsFilter, bool>{};
    notifyListeners();
  }

  showHypoHyperSetting() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return HypoHyperEdit();
        }).then((value) => value != null && value ? update() : null);
  }

  showHypoEdit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return HypoPicker();
        }).then((value) => value != null && value ? update() : null);
  }

  showHyperEdit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return HyperPicker();
        }).then((value) => value != null && value ? update() : null);
  }

  showNormalRangeEdit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RangeSelectionSlider();
        }).then((value) => value != null && value ? update() : null);
  }

  showRangeSetting() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return RangeSetterSlider();
        }).then((value) => value != null && value ? update() : null);
  }

  showInformationDialog(String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        }).then((value) => Navigator.pop(context));
  }

  showFilter(BuildContext tcontext) {
    showDialog(
      context: tcontext,
      barrierColor: Colors.black12,
      builder: (ctx) =>
          ChangeNotifierProvider<PatientDetailPageViewModel>.value(
        value: this,
        child: ChartFilterPopUp(
          height: ctx.HEIGHT * .52,
          width: ctx.WIDTH * .6,
        ),
      ),
    );
  }
}
