// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodPressureModelAdapter extends TypeAdapter<BloodPressureModel> {
  @override
  final int typeId = 3;

  @override
  BloodPressureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodPressureModel(
      dateTime: fields[0] as DateTime?,
      deviceUUID: fields[1] as String?,
      dia: fields[2] as int?,
      isManual: fields[3] as bool?,
      measurementId: fields[4] as int?,
      note: fields[5] as String?,
      pulse: fields[6] as int?,
      sys: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BloodPressureModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.dateTime)
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
