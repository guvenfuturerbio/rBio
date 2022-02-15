import 'package:flutter/material.dart';

import 'bg_measurement.dart';

class BgMeasurementViewModel {
  final BgMeasurement bgMeasurement;

  BgMeasurementViewModel(this.bgMeasurement);

  DateTime get date {
    final DateTime dateTime = DateTime(
      int.parse(bgMeasurement.date!.substring(0, 4)),
      int.parse(bgMeasurement.date!.substring(5, 7)),
      int.parse(bgMeasurement.date!.substring(8, 10)),
      int.parse(bgMeasurement.date!.substring(11, 13)),
      int.parse(bgMeasurement.date!.substring(14, 16)),
      int.parse(bgMeasurement.date!.substring(17, 19)),
    );
    return dateTime;
  }

  bool? get isDeleted {
    return bgMeasurement.isDeleted;
  }

  int? get id {
    return bgMeasurement.id;
  }

  String? get imageURL {
    return bgMeasurement.imageURL;
  }

  String? get result {
    return bgMeasurement.result;
  }

  Color? get resultColor {
    return bgMeasurement.color;
  }

  int? get tag {
    return bgMeasurement.tag;
  }

  String? get note {
    return bgMeasurement.notes;
  }

  bool? get isManual {
    return bgMeasurement.isManual;
  }
}
