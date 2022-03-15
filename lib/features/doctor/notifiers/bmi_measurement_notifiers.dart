import 'package:flutter/material.dart';

import '../../../core/core.dart';

enum BmiMeasurementState { loading, loaded, error }

class BmiMesaurementDoc extends ChangeNotifier {
  BmiMeasurementState? state;

  List<ScaleMeasurementLogic> bgMeasurements = <ScaleMeasurementLogic>[];

  List<DateTime> bmiMeasurementDates = <DateTime>[];
  List<ScaleModel> bloodGlucoseList = <ScaleModel>[];
}
