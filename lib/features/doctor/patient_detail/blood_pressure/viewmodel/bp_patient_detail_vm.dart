part of '../view/bp_patient_detail_screen.dart';

class BpPatientDetailVm extends RbioVm with IBaseBottomActionsOfGraph {
  List<BpMeasurementViewModel> bpMeasurements = [];
  List<BpMeasurementViewModel> bpMeasurementsDailyData = [];

  Map<String, bool>? _measurementFilters;
  Map<String, bool> get measurements =>
      _measurementFilters ??
      {
        LocaleProvider.current.sys: true,
        LocaleProvider.current.dia: true,
        LocaleProvider.current.pulse: true,
      };

  int _currentDateIndex = 0;
  int get currentDateIndex => _currentDateIndex;

  bool hasReachEnd = false;

  @override
  final BuildContext mContext;
  final int patientId;

  BpPatientDetailVm({required this.mContext, required this.patientId}) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      isChartShow = false;
      update();
      controller!.addListener(() async {
        if (controller!.position.atEdge && controller!.position.pixels != 0) {
          await getMoreData();
          fetchScrolledDailyData();
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

  update() async {
    isDataLoading = true;
    notifyListeners();
    await fetchBpMeasurement();
    await fetchScrolledDailyData();

    isDataLoading = false;
    notifyListeners();
  }

  Widget get currentGraph => const _BpLineChart();

  ScrollController? controller = ScrollController();
  TimePeriodFilter? selected = TimePeriodFilter.daily;
  bool allDataLoaded = false;

  Map<String, bool>? measurementFilters;

  /* ??
      {
        LocaleProvider.current.sys: true,
        LocaleProvider.current.dia: true,
        LocaleProvider.current.pulse: true,
      };*/

  bool? isDataLoading;

  fetchBpMeasurement() async {
    final result = await getIt<DoctorRepository>().getMyPatientBloodPressure(
      patientId,
      GetMyPatientFilter(end: null, start: null),
    );

    bpMeasurements =
        result.map((e) => BpMeasurementViewModel(bpModel: e)).toList();

    bpMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  Future<void> getMoreData() async {
    int addedItem = 0;
    final result = await getIt<DoctorRepository>().getMyPatientBloodPressure(
      patientId,
      GetMyPatientFilter(
          end: bpMeasurements.first.date.toIso8601String(), start: null),
    );

    for (var item in result) {
      bool alreadyInList = false;
      for (var localItem in bpMeasurements) {
        if (item.isEqual(localItem.bpModel)) {
          alreadyInList = true;
          break;
        }
      }
      if (!alreadyInList) {
        bpMeasurements.add(BpMeasurementViewModel(bpModel: item));
        addedItem++;
      }
    }
    if (addedItem == 0) {
      allDataLoaded = true;
    }
    bpMeasurements =
        result.map((e) => BpMeasurementViewModel(bpModel: e)).toList();

    bpMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  fetchScrolledDailyData() {
    bpMeasurementsDailyData.clear();
    List<DateTime> dateList = fetchBpMeasurementDates();
    //LoggerUtils.instance.i(dateList.toString());
    List<DateTime> reversedList = dateList.reversed.toList();
    if (reversedList.isNotEmpty) {
      DateTime currentDate = reversedList[currentDateIndex];
      //LoggerUtils.instance.i("current Date " + reversedList[currentDateIndex].toString());
      for (var data in bpMeasurements) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(
                currentDate.year, currentDate.month, currentDate.day))) {
          bpMeasurementsDailyData.add(data);
        }
      }
    }
    bpMeasurementsDailyData.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  DateTime? _scrolledDate;
  void fetchScrolledData(DateTime date) {
    if (selected == TimePeriodFilter.daily) {
      var _temp = DateTime(
          _scrolledDate!.year, _scrolledDate!.month, _scrolledDate!.day);
      var _cross = DateTime(date.year, date.month, date.day);
      if ((_temp != _cross)) {
        _scrolledDate = date;
        bpMeasurementsDailyData.clear();

        //LoggerUtils.instance.i("current Date " + reversedList[currentDateIndex].toString());
        for (var data in bpMeasurements) {
          if (DateTime(data.date.year, data.date.month, data.date.day)
              .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
            bpMeasurementsDailyData.add(data);
          }
        }
        notifyListeners();
      }
    }
  }

  List<DateTime> fetchBpMeasurementDates() {
    List<DateTime> _bpMeasurementDates = <DateTime>[];
    bool isInclude = false;
    for (var data in bpMeasurements) {
      for (var data2 in _bpMeasurementDates) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(data2.year, data2.month, data2.day))) {
          isInclude = true;
        }
      }
      if (!isInclude) {
        _bpMeasurementDates
            .add(DateTime(data.date.year, data.date.month, data.date.day));
      }
      isInclude = false;
      _bpMeasurementDates.sort((a, b) => a.compareTo(b));
    }
    return _bpMeasurementDates;
  }

  Future<void> fetchBpMeasurementsInDateRange(
      DateTime start, DateTime end) async {
    final result = getIt<BloodPressureStorageImpl>().getAll();
    bpMeasurements.clear();
    for (var e in result) {
      DateTime measurementDate = BpMeasurementViewModel(bpModel: e).date;

      if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
        bpMeasurements.add(BpMeasurementViewModel(bpModel: e));
      }
    }
    bpMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  DateTime? _startDate;
  DateTime? _endDate;

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate!.year, _startDate!.month, _startDate!.day)
      : DateTime(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate!.year, _endDate!.month, _endDate!.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    _startDate = d;
    _currentDateIndex = 0;
    await getIt<GlucoseStorageImpl>().getAndWriteGlucoseData(
        beginDate: startDate, endDate: endDate.add(const Duration(days: 1)));
    fetchBpMeasurementsInDateRange(
        _startDate ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
        endDate.add(const Duration(days: 1)));

    notifyListeners();
  }

  changeStartDate(DateTime date) {
    _startDate = date;
    setSelectedItem(selected!);
  }

  changeEndDate(DateTime date) {
    _endDate = date;
    setSelectedItem(selected!);
  }

  /*DateTime get endDate => _endDate != null
      ? DateTime(_endDate!.year, _endDate!.month, _endDate!.day)
      : DateTime(
          DateTime.now().add(const Duration(days: 1)).year,
          DateTime.now().add(const Duration(days: 1)).month,
          DateTime.now().add(const Duration(days: 1)).day);*/

  Future<void> setEndDate(DateTime d) async {
    _endDate = d;
    _currentDateIndex = 0;
    await getIt<GlucoseStorageImpl>().getAndWriteGlucoseData(
        beginDate: startDate, endDate: endDate.add(const Duration(days: 1)));
    fetchBpMeasurementsInDateRange(
        startDate, endDate.add(const Duration(days: 1)));

    notifyListeners();
  }

  Future<void> setSelectedItem(TimePeriodFilter timePeriod) async {
    _currentDateIndex = 0;
    selected = timePeriod;
    if (timePeriod == TimePeriodFilter.spesific) {
      fetchBpMeasurement();
      fetchSpesificData();
    } else if (timePeriod == TimePeriodFilter.daily) {
      fetchBpMeasurement();
      fetchScrolledDailyData();
    } else {
      DateTime currentDateEnd = DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 23, 59, 00);
      DateTime currentDateStart = DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 00, 00);
      timePeriod == TimePeriodFilter.weekly
          ? await setStartDate(
              currentDateStart.subtract(const Duration(days: 7)))
          : timePeriod == TimePeriodFilter.monthly
              ? await setStartDate(currentDateStart
                  .subtract(Duration(days: currentDateStart.day - 1)))
              : timePeriod == TimePeriodFilter.monthlyThree
                  ? await setStartDate(DateTime(
                      currentDateStart.year, currentDateStart.month - 3, 1))
                  : await setStartDate(currentDateStart);
      await setEndDate(currentDateEnd);
      setChartAverageDataPerDay();
    }
  }

  void fetchSpesificData() {
    bpMeasurementsDailyData.clear();
    for (var data in bpMeasurements) {
      if (data.date.difference(startDate).inDays >= 0 &&
          data.date.difference(endDate).inDays <= 0) {
        bpMeasurementsDailyData.add(data);
      }
    }
    notifyListeners();
  }

  void setChartAverageDataPerDay() {
    bpMeasurementsDailyData = bpMeasurements;
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

  void getNewItems() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        try {
          if ((selected == TimePeriodFilter.daily) && !hasReachEnd) {
            getIt<BloodPressureStorageImpl>()
                .getAndWriteBpData(endDate: bpMeasurements.first.date)
                .then((value) {
              LoggerUtils.instance.i(value);
              hasReachEnd = value;
            });
          }
        } catch (e, stk) {
          LoggerUtils.instance.i(e);
          debugPrintStack(stackTrace: stk);
        }
      },
    );
  }

  void showPressureTagger(_) {
    Atom.show(
      const BpTaggerPopUp(),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
  }

  @override
  void changeGraphType() {
    throw UnimplementedError(
        'Error: Just one graph type for blood pressure graph type!!!!');
  }

  @override
  void showFilter(BuildContext context) => Atom.show(BpChartFilterPopUp(
        width: context.width * .6,
        measurements: measurementFilters!,
        callback: changeFilterType,
      ));

  void changeFilterType(Map<String, bool> selectedMeasurement) {
    measurementFilters = selectedMeasurement;
    notifyListeners();
  }
}
