import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 3)
class BloodPressureModel extends HiveObject {
  @HiveField(0)
  DateTime dateTime;
  @HiveField(1)
  String deviceUUID;
  @HiveField(2)
  int dia;
  @HiveField(3)
  bool isManual;
  @HiveField(4)
  int measurementId;
  @HiveField(5)
  String note;
  @HiveField(6)
  int pulse;
  @HiveField(7)
  int sys;

  BloodPressureModel(
      {this.dateTime,
      this.deviceUUID,
      this.dia,
      this.isManual,
      this.measurementId,
      this.note,
      this.pulse,
      this.sys});

  factory BloodPressureModel.fromJson(Map<String, dynamic> map) =>
      BloodPressureModel(
        dateTime: DateTime.parse(map['date_time']),
        deviceUUID: map['device_uuid'],
        dia: map['dia'],
        isManual: map['is_manual'],
        measurementId: map['id'],
        note: map['note'],
        pulse: map['pulse'],
        sys: map['sys'],
      );

  Map<String, dynamic> toJson() => {
        'date_time': dateTime.toIso8601String(),
        'device_uuid': deviceUUID,
        'dia': dia,
        'is_manual': isManual,
        'id': measurementId,
        'note': note,
        'pulse': pulse,
        'sys': sys
      };

  @override
  String toString() {
    return "Time: ${dateTime} - Sys: ${sys} - Dia: ${dia} - Pulse: ${pulse} ";
  }

  @override
  bool operator ==(Object other) {
    if (other is BloodPressureModel) {
      if (measurementId == null || other.measurementId == null) {
        return dateTime.millisecondsSinceEpoch ==
            dateTime.millisecondsSinceEpoch;
      } else {
        return measurementId == other.measurementId;
      }
    } else {
      return false;
    }
  }

  bool isEqual(BloodPressureModel other) {
    return jsonEncode(this.toJson()) == jsonEncode(other.toJson());
  }
}

class BloodPressureModelAdapter extends TypeAdapter<BloodPressureModel> {
  @override
  BloodPressureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return BloodPressureModel(
      dateTime: DateTime.parse(fields[0] as String),
      deviceUUID: fields[1] as String,
      dia: fields[2] as int,
      isManual: fields[3] as bool,
      measurementId: fields[4] as int,
      note: fields[5] as String,
      pulse: fields[6] as int,
      sys: fields[7] as int,
    );
  }

  @override
  int get typeId => 3;

  @override
  void write(BinaryWriter writer, BloodPressureModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.dateTime.toIso8601String())
      ..writeByte(1)
      ..write(obj.deviceUUID)
      ..writeByte(2)
      ..write(obj.dia)
      ..writeByte(3)
      ..write(obj.isManual)
      ..writeByte(4)
      ..write(obj.measurementId)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
      ..write(obj.pulse)
      ..writeByte(7)
      ..write(obj.sys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
