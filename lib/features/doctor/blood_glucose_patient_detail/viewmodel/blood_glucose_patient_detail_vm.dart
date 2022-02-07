part of '../view/blood_glucose_patient_detail_screen.dart';

enum GraphType { bubble, line }

class BloodGlucosePatientDetailVm extends RbioVm
    with IBaseBottomActionsOfGraph {
  @override
  late BuildContext mContext;

  LoadingProgress? _stateProcessPatientDetail;
  LoadingProgress? _stateProcessPatientMeasurements;
  late DoctorPatientDetailModel _patientDetail;
  late int _patientId;
  get patientid => _patientId;
  bool _disposed = false;
  bool isDataLoading = false;
  DateTime? _scrolledDate;

  final controller = ScrollController();

  BloodGlucosePatientDetailVm({
    required BuildContext context,
    required int patientId,
  }) {
    mContext = context;
    _patientId = patientId;
    isChartShow = false;
    update();

    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels != 0) {
        getNewItems();
      }
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

  getNewItems() async {
    await Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
        .getMoreData(
            patientId: patientDetail.id!, date: bgMeasurements.last.date);
    filterDatas();
  }

  bool isChartShow = false;
  @override
  changeChartShowStatus() {
    isChartShow = !isChartShow;
    notifyListeners();
  }

  Future<void> update() async {
    isDataLoading = true;
    notifyListeners();

    await fetchPatientDetail();
    await fetchBgMeasurements();
    fetchScrolledDailyData();

    isDataLoading = false;
    notifyListeners();
  }

  void fetchScrolledData(DateTime? date) {
    if (date != null && selected == LocaleProvider.current.daily) {
      var _temp = DateTime(_scrolledDate?.year ?? 2000,
          _scrolledDate?.month ?? 01, _scrolledDate?.day ?? 01);
      var _cross = DateTime(date.year, date.month, date.day);
      if (_scrolledDate == null || (_temp != _cross)) {
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

  LoadingProgress get stateProcessPatientDetail =>
      _stateProcessPatientDetail ?? LoadingProgress.loading;

  LoadingProgress get stateProcessPatientMeasurements =>
      _stateProcessPatientMeasurements ?? LoadingProgress.loading;

  Future<void> fetchPatientDetail() async {
    _stateProcessPatientDetail = LoadingProgress.loading;
    notifyListeners();
    try {
      await Provider.of<PatientNotifiers>(mContext, listen: false)
          .fetchPatientDetail(patientId: _patientId);
      _patientDetail =
          Provider.of<PatientNotifiers>(mContext, listen: false).patientDetail;
      LoggerUtils.instance.e(patientDetail.toJson());
      _stateProcessPatientDetail = LoadingProgress.done;
      notifyListeners();
    } catch (e, stk) {
      LoggerUtils.instance.e(e.toString());
      debugPrintStack(stackTrace: stk);
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      dispose(); //Dispose if patient detail is not available.
      _stateProcessPatientDetail = LoadingProgress.error;
      notifyListeners();
    }
  }

  DoctorPatientDetailModel get patientDetail => _patientDetail;

  final List<int> _tags = [1, 2, 3];

  Widget? _currentGraph;

  GraphType? _currentGlucoseGraphType;

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

  List<ChartData> _chartData = [];

  List<ChartData> _chartVeryLow = [];

  List<ChartData> _chartLow = [];

  List<ChartData> _chartTarget = [];

  List<ChartData> _chartHigh = [];

  List<ChartData> _chartVeryHigh = [];

  int? _scrolledListIndex;

  int? _listLastIndex;

  String? _selectedItem;

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
      _filterState.update(key, (value) => !(filterState[key]!));
      updateBgMeasurement();
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
    return filterState[filter]!;
  }

  List<int> get tags => _tags;

  Map<int, List<ChartData>> get chartDataTagged => _chartDataTagged;

  Map<int, List<ChartData>> get chartVeryLowTagged => _chartVeryLowTagged;

  Map<int, List<ChartData>> get chartLowTagged => _chartLowTagged;

  Map<int, List<ChartData>> get chartTargetTagged => _chartTargetTagged;

  Map<int, List<ChartData>> get chartHighTagged => _chartHighTagged;

  Map<int, List<ChartData>> get chartVeryHighTagged => _chartVeryHighTagged;

  int get targetMin => PatientNotifiers().patientDetail.rangeMin ?? 0;

  int get targetMax => PatientNotifiers().patientDetail.rangeMax ?? 0;

  int get criticMin => PatientNotifiers().patientDetail.hypo ?? 0;

  int get criticMax => PatientNotifiers().patientDetail.hyper ?? 0;

  int get dailyHighestValue {
    int highest = bgMeasurementsDailyData.isNotEmpty
        ? int.parse(bgMeasurementsDailyData[0].result!)
        : 300;
    for (var data in bgMeasurementsDailyData) {
      if (int.parse(data.result!) > highest) {
        highest = int.parse(data.result!);
      }
    }
    return highest > targetMax ? highest + 50 : targetMax + 50;
  }

  int get dailyLowestValue {
    int lowest = bgMeasurementsDailyData.isNotEmpty
        ? int.parse(bgMeasurementsDailyData[0].result!)
        : 50;
    for (var data in bgMeasurementsDailyData) {
      if (int.parse(data.result!) < lowest) {
        lowest = int.parse(data.result!);
      }
    }
    return 0; //lowest < targetMin ?  targetMin - 50 : lowest;
  }

  int get highestValue {
    int highest =
        bgMeasurements.isNotEmpty ? int.parse(bgMeasurements[0].result!) : 300;
    for (var data in bgMeasurements) {
      if (int.parse(data.result!) > highest) {
        highest = int.parse(data.result!);
      }
    }
    return 300;
    //return targetMax + targetMin;
  }

  int get lowestValue {
    int lowest =
        bgMeasurements.isNotEmpty ? int.parse(bgMeasurements[0].result!) : 50;
    for (var data in bgMeasurements) {
      if (int.parse(data.result!) < lowest) {
        lowest = int.parse(data.result!);
      }
    }
    return 0;
    //return 0;
  }

  int get totalValuableCount {
    int totalCount = 0;
    if (_chartData.isNotEmpty) {
      for (var data in _chartData) {
        if (data.y > 0) {
          totalCount++;
        }
      }
    }
    return totalCount;
  }

  Widget get currentGraph => _currentGraph ?? BloodGlucosePatientScatter();

  void setCurrentGraph() {
    if (currentGlucoseGraphType == GraphType.bubble) {
      _currentGraph = BloodGlucosePatientScatter();
    } else {
      _currentGraph = BloodGlucosePatientLine();
    }
    notifyListeners();
  }

  GraphType get currentGlucoseGraphType =>
      _currentGlucoseGraphType ?? GraphType.bubble;

  @override
  void changeGraphType() {
    if (currentGlucoseGraphType == GraphType.bubble) {
      _currentGlucoseGraphType = GraphType.line;
    } else {
      _currentGlucoseGraphType = GraphType.bubble;
    }
    setCurrentGraph();
    notifyListeners();
  }

  Future<void> setSelectedItem(String s) async {
    LoggerUtils.instance.i('data-----------> $s');
    if (s != _selectedItem) {
      resetFilterState();
      _currentDateIndex = 0;
      notifyListeners();
      _selectedItem = s;
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
            ? await setStartDate(
                currentDateStart.subtract(const Duration(days: 7)))
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
      ? DateTime(_startDate!.year, _startDate!.month, _startDate!.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    _startDate = d;
    _currentDateIndex = 0;
    await Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
        .fetchBgMeasurementsInDateRange(
            startDate, endDate.add(const Duration(days: 1)));
    bgMeasurements =
        Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
            .bgMeasurements;
    LoggerUtils.instance.i(bgMeasurements.length);
    //fetchScrolledDailyData();
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
    await Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
        .fetchBgMeasurementsInDateRange(
            startDate, endDate.add(const Duration(days: 1)));
    bgMeasurements =
        Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
            .bgMeasurements;
    //fetchScrolledDailyData();
    notifyListeners();
  }

  int get scrolledIndex => _scrolledListIndex ?? 0;

  void setScrolledIndex(int index) {
    setListLastIndex(_scrolledListIndex ?? index);
    _scrolledListIndex = index;
    _scrolledListIndex! > listLastIndex
        ? setCurrentDateIndex(1)
        : _scrolledListIndex! < listLastIndex
            ? setCurrentDateIndex(-1)
            : setCurrentDateIndex(1);
    if (selected == LocaleProvider.current.daily ||
        selected == LocaleProvider.current.specific) {
      fetchScrolledDailyData();
    }
    notifyListeners();
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

  void fetchScrolledDailyData() {
    bgMeasurementsDailyData.clear();
    List<DateTime> dateList =
        Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
            .bgMeasurementDates;
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

  List<ChartData> get chartData => _chartData;

  void setChartDailyData() {
    List<ChartData> chartData = [];
    for (var data in bgMeasurementsDailyData) {
      chartData.add(
          ChartData(data.date, int.parse(data.result!), data.resultColor!));
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
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.very_low) {
        chartData.add(
            ChartData(data.date, int.parse(data.result!), data.resultColor!));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        }
      }
    }
    _chartVeryLow = chartData;
    _chartVeryLowTagged.putIfAbsent(1, () => chartDataAc);
    _chartVeryLowTagged.putIfAbsent(2, () => chartDataTok);
    _chartVeryLowTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  List<ChartData> get chartLow => _chartLow;

  void setChartLow() {
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.low) {
        chartData.add(
            ChartData(data.date, int.parse(data.result!), data.resultColor!));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        }
      }
    }
    _chartLow = chartData;
    _chartLowTagged.putIfAbsent(1, () => chartDataAc);
    _chartLowTagged.putIfAbsent(2, () => chartDataTok);
    _chartLowTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  List<ChartData> get chartTarget => _chartTarget;

  void setChartTarget() {
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.target) {
        chartData.add(
            ChartData(data.date, int.parse(data.result!), data.resultColor!));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        }
      }
    }
    _chartTarget = chartData;
    _chartTargetTagged.putIfAbsent(1, () => chartDataAc);
    _chartTargetTagged.putIfAbsent(2, () => chartDataTok);
    _chartTargetTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  List<ChartData> get chartHigh => _chartHigh;

  void setChartHigh() {
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.high) {
        chartData.add(
            ChartData(data.date, int.parse(data.result!), data.resultColor!));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        }
      }
    }
    _chartHigh = chartData;
    _chartHighTagged.putIfAbsent(1, () => chartDataAc);
    _chartHighTagged.putIfAbsent(2, () => chartDataTok);
    _chartHighTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  List<ChartData> get chartVeryHigh => _chartVeryHigh;

  void setChartVeryHigh() {
    List<ChartData> chartData = [];
    List<ChartData> chartDataAc = [];
    List<ChartData> chartDataTok = [];
    List<ChartData> chartDataUnTagged = [];

    for (var data in bgMeasurementsDailyData) {
      if (data.resultColor == R.color.very_high) {
        chartData.add(
            ChartData(data.date, int.parse(data.result!), data.resultColor!));
        if (data.tag == 1) {
          chartDataAc.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else if (data.tag == 2) {
          chartDataTok.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        } else {
          chartDataUnTagged.add(
              ChartData(data.date, int.parse(data.result!), data.resultColor!));
        }
      }
    }
    _chartVeryHigh = chartData;
    _chartVeryHighTagged.putIfAbsent(1, () => chartDataAc);
    _chartVeryHighTagged.putIfAbsent(2, () => chartDataTok);
    _chartVeryHighTagged.putIfAbsent(3, () => chartDataUnTagged);
    notifyListeners();
  }

  getNewDatas(DateTime oldestDate) {}

  Future<void> fetchBgMeasurements() async {
    await Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
        .fetchBgMeasurements(patientId: _patientId);
    bgMeasurements =
        Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
            .bgMeasurements;
    notifyListeners();
  }

  void setChartDataPerData() {
    bgMeasurementsDailyData = bgMeasurements;
    setChartGroupData();
  }

  void setChartAverageDataPerDay() {
    bgMeasurementsDailyData = bgMeasurements;
    setChartDailyData();
  }

  Future<void> nextDate() async {
    await setStartDate(endDate);
    if (selected == LocaleProvider.current.weekly) {
      await setEndDate(endDate.add(const Duration(days: 7)));
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
      await setStartDate(startDate.subtract(const Duration(days: 7)));
    } else if (selected == LocaleProvider.current.monthly) {
      await setStartDate(DateTime(startDate.year, startDate.month - 1, 1));
    } else if (selected == LocaleProvider.current.three_months) {
      await setStartDate(DateTime(startDate.year, startDate.month - 3, 1));
    }
    setChartAverageDataPerDay();
    notifyListeners();
  }

  Future<void> updateBgMeasurement() async {
    if (selected == LocaleProvider.current.daily ||
        selected == LocaleProvider.current.specific) {
      await Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
          .fetchBgMeasurements(patientId: _patientId);
    } else {
      await Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
          .fetchBgMeasurementsInDateRange(
              startDate, endDate.add(const Duration(days: 1)));
    }
    filterDatas();
  }

  filterDatas() {
    bgMeasurements =
        Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
            .bgMeasurements;
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
    Provider.of<BgMeasurementsNotifierDoc>(mContext, listen: false)
        .fetchBgMeasurementsDateList(bgMeasurements);
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
    if (selected == LocaleProvider.current.daily ||
        selected == LocaleProvider.current.specific) {
      fetchScrolledDailyData();
    } else {
      setChartAverageDataPerDay();
    }
  }

  void resetFilterState() {
    _filterState = <GlucoseMarginsFilter, bool>{};
    notifyListeners();
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
          title: LocaleProvider.current.warning,
          text: text,
        );
      },
    ).then((value) => Navigator.pop(mContext));
  }

  @override
  void showFilter(BuildContext context) {
    Atom.show(
      ChangeNotifierProvider<BloodGlucosePatientDetailVm>.value(
        value: this,
        child: _ChartFilter(
          height: context.height * .52,
          width: context.width * .6,
        ),
      ),
      barrierColor: Colors.black12,
    );
  }
}
