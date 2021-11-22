import 'dart:ui';

import '../../core/services/enum/selected_scale_type.dart';
import '../../database/datamodels/scale_data.dart';
import '../../types/unit.dart';

class ScaleMeasurementViewModel {
  final ScaleModel scaleModel;
  ScaleMeasurementViewModel({this.scaleModel});

  bool get isDeleted => scaleModel.isDeleted;
  int get id => scaleModel.time;
  String get note => scaleModel.note ?? '';
  bool get isManuel => scaleModel.isManuel ?? false;
  int get measurementId => scaleModel.measurementId;
  DateTime get date => scaleModel.dateTime;
  double get weight => scaleModel.weight;
  double getMeasurement(SelectedScaleType type) =>
      scaleModel.getReleatedMeasurement(type);
  Color getColor(SelectedScaleType type) => scaleModel.getColor(type);
  List<String> get imageUrl => scaleModel.images;
  ScaleUnit get unit => scaleModel.unit;
  int minRange(SelectedScaleType selected) => scaleModel.getTargetMin(selected);
  int maxRange(SelectedScaleType selected) => scaleModel.getTargetMax(selected);
}
