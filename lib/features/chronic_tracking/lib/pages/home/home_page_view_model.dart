import 'package:flutter/cupertino.dart';

import '../../database/repository/glucose_repository.dart';
import '../../models/bg_measurement/bg_measurement_view_model.dart';

class HomePageViewModel extends ChangeNotifier {
  List<BgMeasurementViewModel> bgMeasurements =
      new List<BgMeasurementViewModel>();

  Future<void> fetchBgMeasurements() async {
    final result = GlucoseRepository().currentUserData;
    this.bgMeasurements =
        result.map((e) => BgMeasurementViewModel(bgMeasurement: e)).toList();
    notifyListeners();
  }

  Future<void> fetchBgMeasurementsInDateRange(
      DateTime start, DateTime end) async {
    final result = GlucoseRepository().currentUserData;
    bgMeasurements.clear();
    for (var e in result) {
      DateTime measurementDate = BgMeasurementViewModel(bgMeasurement: e).date;
      if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
        bgMeasurements.add(BgMeasurementViewModel(bgMeasurement: e));
      }
    }
    notifyListeners();
  }
}
