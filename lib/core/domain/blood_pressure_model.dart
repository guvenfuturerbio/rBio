import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

part 'blood_pressure_model.g.dart';

@HiveType(typeId: 3)
class BloodPressureModel extends HiveObject {
  @HiveField(0)
  DateTime? dateTime;
  @HiveField(1)
  String? deviceUUID;
  @HiveField(2)
  int? dia;
  @HiveField(3)
  bool? isManual;
  @HiveField(4)
  int? measurementId;
  @HiveField(5)
  String? note;
  @HiveField(6)
  int? pulse;
  @HiveField(7)
  int? sys;

  bool isFromHealth;

  BloodPressureModel(
      {this.dateTime,
      this.deviceUUID,
      this.dia,
      this.isManual,
      this.measurementId,
      this.note,
      this.pulse,
      this.sys,
      this.isFromHealth = false});

  factory BloodPressureModel.fromJson(Map<String, dynamic> map) =>
      BloodPressureModel(
        dateTime: DateTime.parse(map['occurrence_time'] as String),
        deviceUUID: map['device_uuid'] as String? ?? "",
        dia: map['dia_value'] as int?,
        isManual: map['is_manuel'] as bool? ?? false,
        measurementId: map['measurement_id'] as int? ?? 0,
        note: map['note'] as String? ?? "",
        pulse: map['pulse_value'] as int?,
        sys: map['sys_value'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'occurrence_time': dateTime?.toIso8601String(),
        'device_uuid': deviceUUID,
        'dia_value': dia,
        'is_manuel': isManual,
        'note': note,
        'pulse_value': pulse,
        'sys_value': sys,
        'measurement_id': measurementId
      };

  @override
  String toString() {
    return "Time: $dateTime - Sys: $sys - Dia: $dia - Pulse: $pulse ";
  }

  @override
  bool operator ==(Object other) {
    if (other is BloodPressureModel) {
      if (measurementId == null || other.measurementId == null) {
        return dateTime?.millisecondsSinceEpoch ==
            dateTime?.millisecondsSinceEpoch;
      } else {
        return measurementId == other.measurementId;
      }
    } else {
      return false;
    }
  }

  bool isEqual(BloodPressureModel other) {
    if (other.isFromHealth) {
      return sys == other.sys &&
          dia == other.dia &&
          pulse == other.pulse &&
          dateTime == other.dateTime;
    }
    return jsonEncode(toJson()) == jsonEncode(other.toJson());
  }

  BloodPressureModel copy() {
    return BloodPressureModel.fromJson(
        jsonDecode(jsonEncode(toJson())) as Map<String, dynamic>);
  }
}
