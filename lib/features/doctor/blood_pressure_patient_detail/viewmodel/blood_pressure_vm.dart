import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/data/repository/doctor_repository.dart';
import '../../../../model/model.dart';
import '../../../chronic_tracking/lib/widgets/utils/time_period_filters.dart';
import '../../../chronic_tracking/progress_sections/pressure_progress/utils/bp_chart_filter/bp_chart_filter_pop_up.dart';
import '../../../chronic_tracking/progress_sections/pressure_progress/utils/pressure_tagger/pressure_tagger.dart';
import '../../../chronic_tracking/progress_sections/pressure_progress/view_model/pressure_measurement_view_model.dart';
import '../widget/charts/line_charts.dart';

class BloodPressurePatientDetailVm extends ChangeNotifier {
  List<BpMeasurementViewModel> bpMeasurements = [];
  List<BpMeasurementViewModel> bpMeasurementsDailyData = [];

  int _currentDateIndex = 0;
  int get currentDateIndex => _currentDateIndex ?? 0;

  bool hasReachEnd = false;

  final BuildContext context;
  final int patientId;

  BloodPressurePatientDetailVm({this.context, this.patientId}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isChartShow = false;
      update();
    });
  }
  bool isChartShow = false;
  changeChartShowStatus() {
    isChartShow = !isChartShow;
    notifyListeners();
  }

  update() async {
    _isDataLoading = true;
    notifyListeners();
    await fetchBpMeasurement();
    await fetchScrolledDailyData();

    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels != 0) {
        getNewItems();
      }
    });
    _isDataLoading = false;
    notifyListeners();
  }

  Widget get currentGraph => AnimatedPatientPulseChart();

  ScrollController controller = ScrollController();
  TimePeriodFilter _selected;
  TimePeriodFilter get selected => _selected ?? TimePeriodFilter.DAILY;

  Map<String, bool> _measurementFilters;

  Map<String, bool> get measurements =>
      _measurementFilters ??
      {
        '${LocaleProvider.current.sys}': true,
        '${LocaleProvider.current.dia}': true,
        '${LocaleProvider.current.pulse}': true,
      };

  bool _isDataLoading;
  bool get isDataLoading => _isDataLoading ?? false;

  fetchBpMeasurement() async {
    final result = await getIt<DoctorRepository>().getMyPatientBloodPressure(
      patientId,
      GetMyPatientFilter(end: null, start: null),
    );

    bpMeasurements =
        result.map((e) => BpMeasurementViewModel(bpModel: e)).toList();

    bpMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  void fetchScrolledDailyData() {
    this.bpMeasurementsDailyData.clear();
    List<DateTime> dateList = fetchBpMeasurementDates();
    //print(dateList.toString());
    List<DateTime> reversedList = dateList.reversed.toList();
    if (reversedList.isNotEmpty) {
      DateTime currentDate = reversedList[currentDateIndex];
      //print("current Date " + reversedList[currentDateIndex].toString());
      for (var data in bpMeasurements) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(
                currentDate.year, currentDate.month, currentDate.day))) {
          this.bpMeasurementsDailyData.add(data);
        }
      }
    }
    bpMeasurementsDailyData.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  DateTime _scrolledDate;
  void fetchScrolledData(DateTime date) {
    if (date != null && selected == TimePeriodFilter.DAILY) {
      var _temp = DateTime(_scrolledDate?.year ?? 2000,
          _scrolledDate?.month ?? 01, _scrolledDate?.day ?? 01);
      var _cross = DateTime(date.year, date.month, date.day);
      if (_scrolledDate == null || (_temp != _cross)) {
        _scrolledDate = date;
        this.bpMeasurementsDailyData.clear();

        //print("current Date " + reversedList[currentDateIndex].toString());
        for (var data in bpMeasurements) {
          if (DateTime(data.date.year, data.date.month, data.date.day)
              .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
            this.bpMeasurementsDailyData.add(data);
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
    this.bpMeasurements.clear();
    for (var e in result) {
      DateTime measurementDate = BpMeasurementViewModel(bpModel: e).date;

      if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
        bpMeasurements.add(BpMeasurementViewModel(bpModel: e));
      }
    }
    this.bpMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  DateTime _startDate;
  DateTime _endDate;

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    this._startDate = d;
    this._currentDateIndex = 0;
    await getIt<GlucoseStorageImpl>().getAndWriteGlucoseData(
        beginDate: _startDate, endDate: endDate.add(Duration(days: 1)));
    fetchBpMeasurementsInDateRange(startDate, endDate.add(Duration(days: 1)));

    notifyListeners();
  }

  changeStartDate(DateTime date) {
    _startDate = date;
    setSelectedItem(selected);
  }

  changeEndDate(DateTime date) {
    _endDate = date;
    setSelectedItem(selected);
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
    fetchBpMeasurementsInDateRange(startDate, endDate.add(Duration(days: 1)));

    notifyListeners();
  }

  Future<void> setSelectedItem(TimePeriodFilter timePeriod) async {
    this._currentDateIndex = 0;
    this._selected = timePeriod;
    if (timePeriod == TimePeriodFilter.SPECIFIC) {
      fetchBpMeasurement();
      fetchSpesificData();
    } else if (timePeriod == TimePeriodFilter.DAILY) {
      fetchBpMeasurement();
      fetchScrolledDailyData();
    } else {
      DateTime currentDateEnd = DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 23, 59, 00);
      DateTime currentDateStart = DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 00, 00);
      timePeriod == TimePeriodFilter.WEEKLY
          ? await setStartDate(currentDateStart.subtract(Duration(days: 7)))
          : timePeriod == TimePeriodFilter.MONTHLY
              ? await setStartDate(currentDateStart
                  .subtract(Duration(days: currentDateStart.day - 1)))
              : timePeriod == TimePeriodFilter.MONTHLY_THREE
                  ? await setStartDate(DateTime(
                      currentDateStart.year, currentDateStart.month - 3, 1))
                  : await setStartDate(currentDateStart);
      await setEndDate(currentDateEnd);
      setChartAverageDataPerDay();
    }
  }

  void fetchSpesificData() {
    this.bpMeasurementsDailyData.clear();
    for (var data in bpMeasurements) {
      if (data.date.difference(_startDate).inDays >= 0 &&
          data.date.difference(_endDate).inDays <= 0) {
        this.bpMeasurementsDailyData.add(data);
      }
    }
    notifyListeners();
  }

  void setChartAverageDataPerDay() {
    this.bpMeasurementsDailyData = bpMeasurements;
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

  getNewItems() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if ((selected == TimePeriodFilter.DAILY) && !hasReachEnd) {
          getIt<BloodPressureStorageImpl>()
              .getAndWriteBpData(endDate: bpMeasurements.first.date)
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

  showPressureTagger(_) {
    Atom.show(PressureTagger(),
        barrierDismissible: false, barrierColor: Colors.transparent);
  }

  @override
  void changeGraphType() => null;

  void showFilter(_) => Atom.show(BpChartFilterPopUp(
        height: context.HEIGHT * .52,
        width: context.WIDTH * .6,
        measurements: measurements,
        callback: changeFilterType,
      ));

  void changeFilterType(Map<String, bool> selectedMeasurement) {
    _measurementFilters = selectedMeasurement;
    notifyListeners();
  }
}
