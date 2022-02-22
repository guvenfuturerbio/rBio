import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../chronic_tracking/progress_sections/scale/viewmodel/scale_measurement_vm.dart';

enum BmiMeasurementState { loading, loaded, error }

class BmiMesaurementDoc extends ChangeNotifier {
  BmiMeasurementState? state;

  List<ScaleMeasurementViewModel> bgMeasurements =
      <ScaleMeasurementViewModel>[];

  List<DateTime> bmiMeasurementDates = <DateTime>[];
  List<ScaleModel> bloodGlucoseList = <ScaleModel>[];
}
