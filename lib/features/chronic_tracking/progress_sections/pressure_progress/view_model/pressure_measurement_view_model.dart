import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/domain/blood_pressure_model.dart';

class BpMeasurementViewModel {
  final BloodPressureModel bpModel;

  BpMeasurementViewModel({this.bpModel});

  DateTime get date => bpModel?.dateTime;
  set date(DateTime rhs) => bpModel.dateTime = rhs;

  int get id => this.bpModel.dateTime.millisecondsSinceEpoch;

  int get sys => bpModel?.sys;

  set sys(int rhs) => bpModel.sys = rhs;

  int get dia => bpModel?.dia;

  set dia(int rhs) => bpModel.dia = rhs;

  int get pulse => bpModel?.pulse;

  set pulse(int rhs) => bpModel.pulse = rhs;

  String get deviceId => bpModel.deviceUUID;

  set deviceId(String rhs) => bpModel.deviceUUID = rhs;

  String get note => this.bpModel.note;

  bool get isManual => this.bpModel.isManual;

  int get measurementId => this.bpModel.measurementId;

  set measurementId(int rhs) => this.bpModel.measurementId = rhs;

  set note(String rhs) => bpModel.note = rhs;

  /* Map<String, int> get pulseRange {
    List<String> nums =
        getIt<ProfileStorageImpl>().getFirst().birthDate.split(".");
    var yearOfBirth = int.parse(nums[2]);

    int age = DateTime.now().year - yearOfBirth;
    if (age < 20) {
      age = 20;
    }
    Map<String, int> map = {};

    if (age >= 20 && age < 30) {
      map = {'min': 100, 'max': 170};
    } else if (age >= 30 && age < 35) {
      map = {'min': 95, 'max': 162};
    } else if (age >= 35 && age < 40) {
      map = {'min': 93, 'max': 157};
    } else if (age >= 40 && age < 45) {
      map = {'min': 90, 'max': 153};
    } else if (age >= 45 && age < 50) {
      map = {'min': 88, 'max': 149};
    } else if (age >= 50 && age < 55) {
      map = {'min': 85, 'max': 145};
    } else if (age >= 55 && age < 60) {
      map = {'min': 83, 'max': 140};
    } else if (age >= 60 && age < 65) {
      map = {'min': 80, 'max': 136};
    } else if (age >= 65 && age < 70) {
      map = {'min': 78, 'max': 132};
    } else if (age >= 70) {
      map = {'min': 75, 'max': 128};
    } 
    return map;
  } */

  Color get systolicColor {
    if (sys == null) {
      return Colors.grey[300];
    }
    if (sys > 89 && sys < 120) {
      return R.color.target;
    } else if (sys > 119 && sys < 139) {
      return R.color.high;
    } else if (sys >= 139) {
      return R.color.very_high;
    } else if (90 > sys) {
      return R.color.low;
    } else {
      return Colors.grey[300];
    }
  }

  Color get diastolicColor {
    if (dia == null) {
      return Colors.grey[300];
    }
    if (dia > 59 && dia < 80) {
      return R.color.target;
    } else if (dia > 79 && dia < 90) {
      return R.color.high;
    } else if (dia >= 89) {
      return R.color.very_high;
    } else if (dia < 60) {
      return R.color.low;
    } else {
      return Colors.grey[300];
    }
  }

  Color get pulseColor {
    if (pulse == null) {
      return Colors.grey[300];
    }
    if (pulse > 59 && pulse < 101) {
      return R.color.target;
    } else if (pulse > 100 && pulse < 121) {
      return R.color.high;
    } else if (pulse > 120) {
      return R.color.very_high;
    } else if (pulse < 60) {
      return R.color.low;
    } else {
      return Colors.grey[300];
    }
  }
}
