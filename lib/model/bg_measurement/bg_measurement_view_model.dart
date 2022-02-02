import 'package:flutter/material.dart';
import '../../../../../core/core.dart';

class BgMeasurementGlucoseViewModel {
  final GlucoseData bgMeasurement;

  BgMeasurementGlucoseViewModel(this.bgMeasurement);

  DateTime get date {
    final DateTime dateTime = DateTime(
      int.parse(bgMeasurement.date.substring(0, 4)),
      int.parse(bgMeasurement.date.substring(5, 7)),
      int.parse(bgMeasurement.date.substring(8, 10)),
      int.parse(bgMeasurement.date.substring(11, 13)),
      int.parse(bgMeasurement.date.substring(14, 16)),
      int.parse(bgMeasurement.date.substring(17, 19)),
    );
    return dateTime;
  }

  bool get isDeleted {
    return bgMeasurement.isDeleted;
  }

  int get id {
    return bgMeasurement.time;
  }

  String get imageURL {
    return bgMeasurement.imageURL;
  }

  set imageURL(String url) {
    bgMeasurement.imageURL = url;
  }

  String get result {
    return bgMeasurement.level;
  }

  Color get resultColor {
    return bgMeasurement.color;
  }

  int get tag {
    return bgMeasurement.tag;
  }

  String get note {
    return bgMeasurement.note;
  }

  bool get isManual {
    return bgMeasurement.manual;
  }

  int get measurementId {
    return bgMeasurement.measurementId;
  }
}
