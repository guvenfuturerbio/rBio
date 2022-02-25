import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../bottom_actions_of_graph.dart';
import '../../widgets/i_progress_screen.dart';
import '../../widgets/small_chronic_component.dart';
import '../widgets/chart/bp_pulse_chart.dart';
import '../widgets/bp_chart_filter/bp_chart_filter_pop_up.dart';
import '../widgets/tagger/bp_tagger_pop_up.dart';
import '../view/bp_progres_screen.dart';
import 'bp_measurement_vm.dart';

class BpProgressVm
    with ChangeNotifier, IBaseBottomActionsOfGraph
    implements IProgressScreen {
  List<BpMeasurementViewModel> bpMeasurements = [];
  List<BpMeasurementViewModel> bpMeasurementsDailyData = [];

  int _currentDateIndex = 0;
  int get currentDateIndex => _currentDateIndex;

  bool hasReachEnd = false;

  BpProgressVm() {
    isChartShow = true;
    getIt<BloodPressureStorageImpl>().addListener(() {
      setSelectedItem(selected);
    });
    fetchBpMeasurement();
    fetchScrolledDailyData();
    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels != 0) {
        getNewItems();
      }
    });
  }
  bool isChartShow = false;

  @override
  void changeChartShowStatus() {
    isChartShow = !isChartShow;
    notifyListeners();
  }

  Widget get currentGraph => const BpPulseChart();

  ScrollController controller = ScrollController();
  TimePeriodFilter? _selected;
  TimePeriodFilter get selected => _selected ?? TimePeriodFilter.daily;

  Map<String, bool>? _measurementFilters;

  Map<String, bool> get measurements =>
      _measurementFilters ??
      {
        LocaleProvider.current.sys: true,
        LocaleProvider.current.dia: true,
        LocaleProvider.current.pulse: true,
      };

  void fetchBpMeasurement() {
    var _bpMeasurements = getIt<BloodPressureStorageImpl>().getAll();
    bpMeasurements = _bpMeasurements
        .map((model) => BpMeasurementViewModel(bpModel: model))
        .toList();
    bpMeasurements.sort((a, b) => a.date.compareTo(b.date));
  }

  void fetchScrolledDailyData() {
    bpMeasurementsDailyData.clear();
    List<DateTime> dateList = fetchBpMeasurementDates();

    List<DateTime> reversedList = dateList.reversed.toList();
    if (reversedList.isNotEmpty) {
      DateTime currentDate = reversedList[currentDateIndex];
      for (var data in bpMeasurements) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(
          DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
          ),
        )) {
          bpMeasurementsDailyData.add(data);
        }
      }
    }

    bpMeasurementsDailyData.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  DateTime? _scrolledDate;
  void fetchScrolledData(DateTime? date) {
    if (date != null && selected == TimePeriodFilter.daily) {
      var _temp = DateTime(_scrolledDate?.year ?? 2000,
          _scrolledDate?.month ?? 01, _scrolledDate?.day ?? 01);
      var _cross = DateTime(date.year, date.month, date.day);
      if (_scrolledDate == null || (_temp != _cross)) {
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
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> setStartDate(DateTime d) async {
    _startDate = d;
    _currentDateIndex = 0;
    await getIt<BloodPressureStorageImpl>().getAndWriteBpData(
        beginDate: _startDate, endDate: endDate.add(const Duration(days: 1)));
    fetchBpMeasurementsInDateRange(
        startDate, endDate.add(const Duration(days: 1)));

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
      ? DateTime(_endDate!.year, _endDate!.month, _endDate!.day)
      : DateTime(
          DateTime.now().add(const Duration(days: 1)).year,
          DateTime.now().add(const Duration(days: 1)).month,
          DateTime.now().add(const Duration(days: 1)).day);

  Future<void> setEndDate(DateTime d) async {
    _endDate = d;
    _currentDateIndex = 0;
    await getIt<BloodPressureStorageImpl>().getAndWriteBpData(
        beginDate: _startDate, endDate: endDate.add(const Duration(days: 1)));
    fetchBpMeasurementsInDateRange(
        startDate, endDate.add(const Duration(days: 1)));

    notifyListeners();
  }

  Future<void> setSelectedItem(TimePeriodFilter timePeriod) async {
    _currentDateIndex = 0;
    _selected = timePeriod;
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
      if (data.date.difference(_startDate!).inDays >= 0 &&
          data.date.difference(_endDate!).inDays <= 0) {
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

  getNewItems() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        try {
          if ((selected == TimePeriodFilter.daily) && !hasReachEnd) {
            getIt<BloodPressureStorageImpl>()
                .getAndWriteBpData(endDate: bpMeasurements.first.date)
                .then((value) {
              hasReachEnd = value;
            });
          }
        } catch (e, stk) {
          LoggerUtils.instance.e(e);
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
  Widget largeWidget() {
    return BpProgressScreen(
      callback: changeChartShowStatus,
    );
  }

  @override
  void manuelEntry(BuildContext ctx) {
    showPressureTagger(ctx);
  }

  @override
  Widget smallWidget(Function() callBack) {
    BpMeasurementViewModel? lastMeasurement;
    if (bpMeasurements.isNotEmpty) {
      lastMeasurement = BpMeasurementViewModel(
        bpModel: getIt<BloodPressureStorageImpl>().getLatestMeasurement() ??
            BloodPressureModel(),
      );
    }

    return SmallChronicComponent(
      callback: callBack,
      lastMeasurement: lastMeasurement == null
          ? LocaleProvider.current.no_measurement
          : 'Sys: ${lastMeasurement.sys ?? ''}, Dia: ${lastMeasurement.dia ?? ''}, Pulse: ${lastMeasurement.pulse ?? ''}',
      lastMeasurementDate: lastMeasurement?.date ?? DateTime.now(),
      imageUrl: R.image.bloodPressure,
    );
  }

  @override
  void changeGraphType() => throw UnimplementedError('Does not implemented');

  @override
  void showFilter(context) => Atom.show(
        BpChartFilterPopUp(
          width: context.width * .6,
        ),
      );

  void changeFilterType(Map<String, bool> selectedMeasurement) {
    _measurementFilters = selectedMeasurement;
    notifyListeners();
  }
}
