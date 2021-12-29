import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/scale_progress/utils/scale_measurements/scale_measurement_vm.dart';

enum BmiMeasurementState { loading, loaded, error }

class BmiMesaurementDoc extends ChangeNotifier {
  BmiMeasurementState state;

  List<ScaleMeasurementViewModel> bgMeasurements =
      <ScaleMeasurementViewModel>[];

  List<DateTime> bmiMeasurementDates = <DateTime>[];
  List<ScaleModel> bloodGlucoseList = <ScaleModel>[];
}
