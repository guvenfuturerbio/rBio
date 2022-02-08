// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScaleModelAdapter extends TypeAdapter<ScaleModel> {
  @override
  final int typeId = 1;

  @override
  ScaleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScaleModel(
      device: (fields[0] as Map?)?.cast<String, dynamic>(),
      measurementId: fields[20] as int?,
      weight: fields[1] as double?,
      unit: fields[2] as ScaleUnit?,
      dateTime: fields[19] as DateTime,
      impedance: fields[14] as int?,
      isManuel: fields[12] as bool?,
      images: (fields[13] as List?)?.cast<String>(),
      note: fields[11] as String?,
      bmi: fields[3] as double?,
      bodyFat: fields[5] as double?,
      boneMass: fields[7] as double?,
      isDeleted: fields[10] as bool?,
      muscle: fields[8] as double?,
      time: fields[18] as int?,
      visceralFat: fields[6] as double?,
      water: fields[4] as double?,
      bmh: fields[9] as double?,
      gender: fields[16] as int?,
      height: fields[15] as int?,
      age: fields[17] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ScaleModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.device)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.bmi)
      ..writeByte(4)
      ..write(obj.water)
      ..writeByte(5)
      ..write(obj.bodyFat)
      ..writeByte(6)
      ..write(obj.visceralFat)
      ..writeByte(7)
      ..write(obj.boneMass)
      ..writeByte(8)
      ..write(obj.muscle)
      ..writeByte(9)
      ..write(obj.bmh)
      ..writeByte(10)
      ..write(obj.isDeleted)
      ..writeByte(11)
      ..write(obj.note)
      ..writeByte(12)
      ..write(obj.isManuel)
      ..writeByte(13)
      ..write(obj.images)
      ..writeByte(14)
      ..write(obj.impedance)
      ..writeByte(15)
      ..write(obj.height)
      ..writeByte(16)
      ..write(obj.gender)
      ..writeByte(17)
      ..write(obj.age)
      ..writeByte(18)
      ..write(obj.time)
      ..writeByte(19)
      ..write(obj.dateTime)
      ..writeByte(20)
      ..write(obj.measurementId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScaleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ScaleUnitAdapter extends TypeAdapter<ScaleUnit> {
  @override
  final int typeId = 5;

  @override
  ScaleUnit read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ScaleUnit.kg;
      case 1:
        return ScaleUnit.lbs;
      default:
        return ScaleUnit.kg;
    }
  }

  @override
  void write(BinaryWriter writer, ScaleUnit obj) {
    switch (obj) {
      case ScaleUnit.kg:
        writer.writeByte(0);
        break;
      case ScaleUnit.lbs:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScaleUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
