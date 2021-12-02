import 'package:flutter/cupertino.dart';
import '../../../../core/core.dart';
import '../../../../core/data/service/chronic_service/chronic_storage_service.dart';

import '../models/bg_measurement/bg_measurement_view_model.dart';

enum BgMeasurementState { loading, loaded, error }

class BgMeasurementsNotifier extends ChangeNotifier {
  static final BgMeasurementsNotifier _instance =
      BgMeasurementsNotifier._internal();

  factory BgMeasurementsNotifier() {
    return _instance;
  }

  BgMeasurementsNotifier._internal() {}

  BgMeasurementState state;

  List<BgMeasurementViewModel> bgMeasurements = [];

  List<DateTime> bgMeasurementDates = [];

  Future<void> fetchBgMeasurements() async {
    final result = getIt<GlucoseStorageImpl>().getAll();
    this.bgMeasurements.clear();
    this.bgMeasurements =
        result.map((e) => BgMeasurementViewModel(bgMeasurement: e)).toList();
    this.bgMeasurements.sort((a, b) => a.date.compareTo(b.date));
    fetchBgMeasurementsDateList(bgMeasurements);
    notifyListeners();
  }

  Future<void> fetchBgMeasurementsInDateRange(
      DateTime start, DateTime end) async {
    final result = getIt<GlucoseStorageImpl>().getAll();
    this.bgMeasurements.clear();
    for (var e in result) {
      DateTime measurementDate = BgMeasurementViewModel(bgMeasurement: e).date;
      if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
        bgMeasurements.add(BgMeasurementViewModel(bgMeasurement: e));
      }
    }
    this.bgMeasurements.sort((a, b) => a.date.compareTo(b.date));
    fetchBgMeasurementsDateList(bgMeasurements);
    notifyListeners();
  }

  void fetchBgMeasurementsDateList(
      List<BgMeasurementViewModel> bgMeasurements) {
    bool isInclude = false;
    this.bgMeasurementDates.clear();
    for (var data in bgMeasurements) {
      for (var data2 in bgMeasurementDates) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(data2.year, data2.month, data2.day))) {
          isInclude = true;
        }
      }
      if (!isInclude) {
        this
            .bgMeasurementDates
            .add(DateTime(data.date.year, data.date.month, data.date.day));
      }
      isInclude = false;
      this.bgMeasurementDates.sort((a, b) => a.compareTo(b));
    }
    notifyListeners();
  }
}
