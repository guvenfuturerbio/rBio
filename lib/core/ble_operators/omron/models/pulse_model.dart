part of '../omron.dart';

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
      OmronConstants.instance.keyConst.dateKey: date,
      OmronConstants.instance.keyConst.pulseKey: pulse,
      OmronConstants.instance.keyConst.systolicKey: sys,
      OmronConstants.instance.keyConst.diastolicKey: dia,
    };
  }

  factory PulseModel.fromMap(LinkedHashMap<dynamic, dynamic> map) {
    return PulseModel(
      date: map[OmronConstants.instance.keyConst.dateKey],
      pulse: map[OmronConstants.instance.keyConst.pulseKey],
      sys: map[OmronConstants.instance.keyConst.systolicKey],
      dia: map[OmronConstants.instance.keyConst.diastolicKey],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PulseModel.fromJson(String source) =>
      PulseModel.fromMap(jsonDecode(source));

  @override
  String toString() =>
      'Date: $date,\n Pulse: $pulse, \n Sys: $sys, \n Dia: $dia\n ';
}
