import 'package:flutter/material.dart';

import '../../../lib/database/repository/scale_repository.dart';
import '../utils/scale_measurements/scale_measurement_vm.dart';

enum ScaleMesurementState { loading, loaded, error }

class ScaleMeasurementNotifier extends ChangeNotifier {
  static final ScaleMeasurementNotifier _instance =
      ScaleMeasurementNotifier._internal();

  factory ScaleMeasurementNotifier() {
    return _instance;
  }

  ScaleMeasurementNotifier._internal() {}
  ScaleMesurementState state;

  List<ScaleMeasurementViewModel> _scaleModels = [];
  List<ScaleMeasurementViewModel> get scaleMeasurements => _scaleModels;

  List<DateTime> _scaleMeasurementDates = [];
  List<DateTime> get scaleMeasurementDates => _scaleMeasurementDates;
  Future<void> fetchScaleMeasurements() async {
    final result = ScaleRepository().currentUserData;
    this._scaleModels.clear();
    this._scaleModels =
        result.map((e) => ScaleMeasurementViewModel(scaleModel: e)).toList();
    this._scaleModels.sort((a, b) => a.date.compareTo(b.date));
    fetchScaleMeasurementsDateList();
    notifyListeners();
  }

  void fetchScaleMeasurementsDateList() {
    bool isInclude = false;
    this._scaleMeasurementDates.clear();
    for (var data in _scaleModels) {
      for (var data2 in _scaleMeasurementDates) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(data2.year, data2.month, data2.day))) {
          isInclude = true;
        }
      }
      if (!isInclude) {
        this
            ._scaleMeasurementDates
            .add(DateTime(data.date.year, data.date.month, data.date.day));
      }
      isInclude = false;
      this._scaleMeasurementDates.sort((a, b) => a.compareTo(b));
    }
    notifyListeners();
  }

  Future<void> fetchScaleMeasurementsInDateRange(
      DateTime start, DateTime end) async {
    final result = ScaleRepository().currentUserData;
    this.scaleMeasurements.clear();
    for (var e in result) {
      DateTime measurementDate = ScaleMeasurementViewModel(scaleModel: e).date;
      if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
        scaleMeasurements.add(ScaleMeasurementViewModel(scaleModel: e));
      }
    }
    this.scaleMeasurements.sort((a, b) => a.date.compareTo(b.date));
    fetchScaleMeasurementsDateList();
    notifyListeners();
  }
}
