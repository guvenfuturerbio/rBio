part of '../view/scale_patient_detail_screen.dart';

class ScalePatientDetailVm extends RbioVm with IBaseBottomActionsOfGraph {
  ScalePatientDetailVm(this.mContext, this.patientId) {
    isChartShow = false;
    update();
    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels != 0) {
        getNewItems();
      }
    });
  }

  getNewItems() async {
    if (!allDataLoaded) {
      await getMoreData();
      fetchScrolledDailyData();
    }
  }

  bool allDataLoaded = false;
  bool isChartShow = false;

  @override
  changeChartShowStatus() {
    isChartShow = !isChartShow;
    notifyListeners();
  }

  late int patientId;

  bool _disposed = false;
  bool isDataLoading = false;
  DateTime? _scrolledDate;

  final controller = ScrollController();

  LoadingProgress? _stateProcessPatientDetail;
  LoadingProgress? _stateProcessPatientMeasurements;
  late DoctorPatientDetailModel _patientDetail;

  List<ScaleModel> scaleData = <ScaleModel>[];
  List<DateTime> scaleMeasurmentDates = <DateTime>[];

  List<ScaleMeasurementLogic> scaleMeasurement = <ScaleMeasurementLogic>[];

  List<ScaleMeasurementLogic> bmiMeasurementsDailyData =
      <ScaleMeasurementLogic>[];

  LoadingProgress get stateProcessPatientDetail =>
      _stateProcessPatientDetail ?? LoadingProgress.loading;

  LoadingProgress get stateProcessPatientMeasurements =>
      _stateProcessPatientMeasurements ?? LoadingProgress.loading;

  List<TimePeriodFilter> get items => [
        TimePeriodFilter.daily,
        TimePeriodFilter.weekly,
        TimePeriodFilter.monthly,
        TimePeriodFilter.monthlyThree,
        TimePeriodFilter.spesific
      ];

  List<ChartData> _chartData = [];

  List<ChartData> _chartVeryLow = [];

  List<ChartData> _chartLow = [];

  List<ChartData> _chartTarget = [];

  List<ChartData> _chartHigh = [];

  List<ChartData> _chartVeryHigh = [];

  List<ChartData> get chartData => _chartData;

  int get targetMin {
    if (scaleMeasurement.isEmpty) {
      return 0;
    } else {
      return ScaleRanges.instance.getTargetMin(
            type: currentScaleType,
            age: scaleMeasurement[0].age,
            height: scaleMeasurement[0].height,
            water: scaleMeasurement[0].water,
            gender: scaleMeasurement[0].gender,
            visceralFat: scaleMeasurement[0].visceralFat,
          ) ??
          0;
    }
  }

  int get targetMax {
    if (scaleMeasurement.isEmpty) {
      return 0;
    } else {
      return ScaleRanges.instance.getTargetMax(
            type: currentScaleType,
            age: scaleMeasurement[0].age,
            height: scaleMeasurement[0].height,
            water: scaleMeasurement[0].water,
            gender: scaleMeasurement[0].gender,
            visceralFat: scaleMeasurement[0].visceralFat,
          ) ??
          0;
    }
  }

  int get dailyHighestValue {
    int highest = bmiMeasurementsDailyData.isNotEmpty &&
            scaleMeasurement[0].getMeasurement(currentScaleType) != null
        ? bmiMeasurementsDailyData[0].getMeasurement(currentScaleType)!.toInt()
        : 70;
    for (var data in bmiMeasurementsDailyData) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType)!.toInt();
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
        ? bmiMeasurementsDailyData[0].getMeasurement(currentScaleType)!.toInt()
        : 50;
    for (var data in bmiMeasurementsDailyData) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType)!.toInt();
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
        ? scaleMeasurement[0].getMeasurement(currentScaleType)!.toInt()
        : 300;
    for (var data in scaleMeasurement) {
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
    int lowest = scaleMeasurement.isNotEmpty &&
            scaleMeasurement[0].getMeasurement(currentScaleType) != null
        ? scaleMeasurement[0].getMeasurement(currentScaleType)!.toInt()
        : 50;
    for (var data in scaleMeasurement) {
      if (data.getMeasurement(currentScaleType) != null) {
        var _currentValue = data.getMeasurement(currentScaleType)!.toInt();
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

  TimePeriodFilter? _selected;
  TimePeriodFilter get selected => _selected ?? items[0];

  SelectedScaleType? _selectedItem;

  SelectedScaleType get currentScaleType =>
      _selectedItem ?? SelectedScaleType.weight;

  int? _currentDateIndex;

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

  DateTime? _startDate, _endDate;

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate!.year, _startDate!.month, _startDate!.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    _startDate = d;
    _currentDateIndex = 0;
    await fetchBMIMeasurementsInDateRange(
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
    fetchBMIMeasurementsInDateRange(
        startDate, endDate.add(const Duration(days: 1)));

    notifyListeners();
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

  void setChartAverageDataPerDay() {
    bmiMeasurementsDailyData = scaleMeasurement;
    setChartDailyData();
  }

  void setChartDailyData() {
    try {
      List<ChartData> tempChartData = <ChartData>[];
      for (var data in bmiMeasurementsDailyData) {
        if (data.getMeasurement(currentScaleType) != null) {
          tempChartData.add(ChartData(
              data.dateTime,
              data.getMeasurement(currentScaleType)!.toInt(),
              data.getColor(currentScaleType)));
        }
      }
      _chartData = tempChartData;
      setChartGroupData();
      notifyListeners();
    } catch (e) {
      LoggerUtils.instance.e(e);
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

    for (var data in bmiMeasurementsDailyData) {
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

  List<ChartData> get chartLow => _chartLow;

  void setChartLow() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in bmiMeasurementsDailyData) {
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

  List<ChartData> get chartTarget => _chartTarget;

  void setChartTarget() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in bmiMeasurementsDailyData) {
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

  List<ChartData> get chartHigh => _chartHigh;

  void setChartHigh() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in bmiMeasurementsDailyData) {
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

  List<ChartData> get chartVeryHigh => _chartVeryHigh;

  void setChartVeryHigh() {
    List<ChartData> tempChartData = <ChartData>[];

    for (var data in bmiMeasurementsDailyData) {
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

  Future<void> fetchPatientDetail() async {
    _stateProcessPatientDetail = LoadingProgress.loading;
    notifyListeners();
    try {
      await Provider.of<PatientNotifiers>(mContext, listen: false)
          .fetchPatientDetail(patientId: patientId);
      _patientDetail =
          Provider.of<PatientNotifiers>(mContext, listen: false).patientDetail;
      _stateProcessPatientDetail = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
      dispose(); //Dispose if patient detail is not available.
      _stateProcessPatientDetail = LoadingProgress.error;
      notifyListeners();
    }
  }

  void fetchScrolledData(DateTime? date) {
    LoggerUtils.instance.i(date);
    if (date != null && selected == TimePeriodFilter.daily) {
      var _temp = DateTime(_scrolledDate?.year ?? 2000,
          _scrolledDate?.month ?? 01, _scrolledDate?.day ?? 01);
      var _cross = DateTime(date.year, date.month, date.day);
      if (_scrolledDate == null || (_temp != _cross)) {
        _scrolledDate = date;
        bmiMeasurementsDailyData.clear();

        for (var data in scaleMeasurement) {
          if (DateTime(
                  data.dateTime.year, data.dateTime.month, data.dateTime.day)
              .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
            bmiMeasurementsDailyData.add(data);
          }
        }

        setChartDailyData();
      }
    }
  }

  void fetchScrolledDailyData() {
    bmiMeasurementsDailyData.clear();
    List<DateTime> dateList = scaleMeasurmentDates;
    List<DateTime> reversedList = dateList.reversed.toList();
    if (reversedList.isNotEmpty) {
      DateTime currentDate = reversedList[currentDateIndex];
      for (var data in scaleMeasurement) {
        if (DateTime(data.dateTime.year, data.dateTime.month, data.dateTime.day)
            .isAtSameMomentAs(DateTime(
                currentDate.year, currentDate.month, currentDate.day))) {
          bmiMeasurementsDailyData.add(data);
        }
      }
    }
    setChartDailyData();
  }

  Future<void> setSelectedItem(TimePeriodFilter s) async {
    LoggerUtils.instance.i('data-----------> $s');

    _currentDateIndex = 0;
    notifyListeners();
    _selected = s;
    notifyListeners();
    if (s == TimePeriodFilter.spesific) {
      await fetchBmiMeasurements();
      fetchScrolledDailyData();
    } else if (s == TimePeriodFilter.daily) {
      await fetchBmiMeasurements();
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

  Widget? _currentGraph;
  Widget get currentGraph => _currentGraph ?? const _ScaleBubbleChart();

  GraphType? _currentGraphType;

  GraphType get currentGraphType => _currentGraphType ?? GraphType.bubble;

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

  void setCurrentGraph() {
    currentGraphType == GraphType.bubble
        ? _currentGraph = const _ScaleBubbleChart()
        : _currentGraph = const _ScaleLineChart();
  }

  @override
  late BuildContext mContext;

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
          title: LocaleProvider.current.warning,
          text: text,
        );
      },
    ).then((value) => Navigator.pop(mContext));
  }

  @override
  void showFilter(BuildContext context) {
    Atom.show(
      ChangeNotifierProvider<ScalePatientDetailVm>.value(
        value: this,
        child: ScaleChartFilterPopup(
          selected: _selectedItem,
          height: context.height * .52,
          width: context.width * .6,
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

    scaleData = result;

    scaleMeasurement.clear();

    scaleMeasurement =
        scaleData.map((e) => ScaleMeasurementLogic(scaleModel: e)).toList();
    scaleMeasurement.removeWhere(
        (element) => element.getMeasurement(currentScaleType) == null);
    var year = int.parse(_patientDetail.birthDay!.split('.')[2]);
    for (var item in scaleMeasurement) {
      item.age = year < 10 ? 15 : year;
    }
    scaleMeasurement.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    fetchBmiMeasurementsDateList();
  }

  getMoreData() async {
    int addedItem = 0;
    final result = await getIt<DoctorRepository>().getMyPatientScale(
      patientId,
      GetMyPatientFilter(
          end: scaleMeasurement.first.dateTime.toIso8601String(), start: null),
    );
    for (var item in result) {
      bool alreadyInList = false;
      for (var localItem in scaleData) {
        if (item.isEqual(localItem)) {
          alreadyInList = true;
          break;
        }
      }
      if (!alreadyInList) {
        scaleData.add(item);
        addedItem++;
      }
    }
    if (addedItem == 0) {
      allDataLoaded = true;
    }

    scaleMeasurement =
        scaleData.map((e) => ScaleMeasurementLogic(scaleModel: e)).toList();
    scaleMeasurement.removeWhere(
        (element) => element.getMeasurement(currentScaleType) == null);
    var year = int.parse(_patientDetail.birthDay!.split('.')[2]);
    for (var item in scaleMeasurement) {
      item.age = year < 10 ? 15 : year;
    }
    scaleMeasurement.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    fetchBmiMeasurementsDateList();
  }

  Future<void> fetchBMIMeasurementsInDateRange(
      DateTime start, DateTime end) async {
    scaleMeasurement.clear();
    for (var e in scaleData) {
      if (!scaleData.contains(e)) {
        DateTime measurementDate =
            ScaleMeasurementLogic(scaleModel: e).dateTime;
        if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
          scaleMeasurement.add(ScaleMeasurementLogic(scaleModel: e));
        }
      }
    }
    scaleMeasurement.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    fetchBmiMeasurementsDateList();
  }

  void fetchBmiMeasurementsDateList() {
    bool isInclude = false;
    scaleMeasurmentDates.clear();
    for (var data in scaleMeasurement) {
      for (var data2 in scaleMeasurmentDates) {
        if (DateTime(data.dateTime.year, data.dateTime.month, data.dateTime.day)
            .isAtSameMomentAs(DateTime(data2.year, data2.month, data2.day))) {
          isInclude = true;
        }
      }
      if (!isInclude) {
        scaleMeasurmentDates.add(DateTime(
            data.dateTime.year, data.dateTime.month, data.dateTime.day));
      }
      isInclude = false;
      scaleMeasurmentDates.sort((a, b) => a.compareTo(b));
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
          markerSettings: const MarkerSettings(
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
          markerSettings: const MarkerSettings(
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
