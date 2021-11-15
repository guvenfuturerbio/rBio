import 'package:flutter/material.dart';
import 'package:onedosehealth/database/datamodels/glucose_data.dart';
import 'package:onedosehealth/models/bg_measurement/bg_measurement.dart';

class BgMeasurementViewModel {
  final GlucoseData bgMeasurement;

  BgMeasurementViewModel({this.bgMeasurement});

  DateTime get date {
    DateTime dateTime = new DateTime(
        int.parse(bgMeasurement.date.substring(0, 4)),
        int.parse(bgMeasurement.date.substring(5, 7)),
        int.parse(bgMeasurement.date.substring(8, 10)),
        int.parse(bgMeasurement.date.substring(11, 13)),
        int.parse(bgMeasurement.date.substring(14, 16)),
        int.parse(bgMeasurement.date.substring(17, 19)));
    return dateTime;
  }

  bool get isDeleted {
    return this.bgMeasurement.isDeleted;
  }

  int get id {
    return this.bgMeasurement.time;
  }

  String get imageURL {
    return this.bgMeasurement.imageURL;
  }

  set imageURL(String url) {
    this.bgMeasurement.imageURL = url;
  }

  String get result {
    return this.bgMeasurement.level;
  }

  Color get resultColor {
    return this.bgMeasurement.color;
  }

  int get tag {
    return this.bgMeasurement.tag;
  }

  String get note {
    return this.bgMeasurement.note;
  }

  bool get isManual {
    return this.bgMeasurement.manual;
  }

  int get measurementId {
    return this.bgMeasurement.measurementId;
  }
}
