part of '../core.dart';

class PulseModel {
  String date;
  int pulse;
  int sys;
  int dia;

  PulseModel(
      {required this.date,
      required this.pulse,
      required this.dia,
      required this.sys});

  Map<String, dynamic> toMap() {
    return {
      KeyConst.dateKey: date,
      KeyConst.pulseKey: pulse,
      KeyConst.systolicKey: sys,
      KeyConst.diastolicKey: dia,
    };
  }

  factory PulseModel.fromMap(LinkedHashMap<dynamic, dynamic> map) {
    return PulseModel(
      date: map[KeyConst.dateKey],
      pulse: map[KeyConst.pulseKey],
      sys: map[KeyConst.systolicKey],
      dia: map[KeyConst.diastolicKey],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PulseModel.fromJson(String source) =>
      PulseModel.fromMap(jsonDecode(source));

  @override
  String toString() =>
      'Date: $date,\n Pulse: $pulse, \n Sys: $sys, \n Dia: $dia\n ';
}
