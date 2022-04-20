import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class BpMeasurementViewModel {
  final BloodPressureModel bpModel;

  BpMeasurementViewModel({required this.bpModel});

  DateTime get date => bpModel.dateTime ?? DateTime.now();
  set date(DateTime rhs) => bpModel.dateTime = rhs;

  int? get id => bpModel.dateTime?.millisecondsSinceEpoch;

  int? get sys => bpModel.sys;

  set sys(int? rhs) => bpModel.sys = rhs;

  int? get dia => bpModel.dia;

  set dia(int? rhs) => bpModel.dia = rhs;

  int? get pulse => bpModel.pulse;

  set pulse(int? rhs) => bpModel.pulse = rhs;

  String? get deviceId => bpModel.deviceUUID;

  set deviceId(String? rhs) => bpModel.deviceUUID = rhs;

  String get note => bpModel.note ?? '';

  bool get isManual => bpModel.isManual ?? false;

  int? get measurementId => bpModel.measurementId;

  set measurementId(int? rhs) => bpModel.measurementId = rhs;

  set note(String rhs) => bpModel.note = rhs;

  Color get systolicColor {
    if (sys == null) {
      return Colors.grey[300]!;
    }
    if (sys! > 89 && sys! < 120) {
      return getIt<IAppConfig>().theme.target;
    } else if (sys! > 119 && sys! < 139) {
      return getIt<IAppConfig>().theme.high;
    } else if (sys! >= 139) {
      return getIt<IAppConfig>().theme.veryHigh;
    } else if (90 > sys!) {
      return getIt<IAppConfig>().theme.low;
    } else {
      return Colors.grey[300]!;
    }
  }

  Color get diastolicColor {
    if (dia == null) {
      return Colors.grey[300]!;
    }
    if (dia! > 59 && dia! < 80) {
      return getIt<IAppConfig>().theme.target;
    } else if (dia! > 79 && dia! < 90) {
      return getIt<IAppConfig>().theme.high;
    } else if (dia! >= 89) {
      return getIt<IAppConfig>().theme.veryHigh;
    } else if (dia! < 60) {
      return getIt<IAppConfig>().theme.low;
    } else {
      return Colors.grey[300]!;
    }
  }

  Color get pulseColor {
    if (pulse == null) {
      return Colors.grey[300]!;
    }
    if (pulse! > 59 && pulse! < 101) {
      return getIt<IAppConfig>().theme.target;
    } else if (pulse! > 100 && pulse! < 121) {
      return getIt<IAppConfig>().theme.high;
    } else if (pulse! > 120) {
      return getIt<IAppConfig>().theme.veryHigh;
    } else if (pulse! < 60) {
      return getIt<IAppConfig>().theme.low;
    } else {
      return Colors.grey[300]!;
    }
  }
}
