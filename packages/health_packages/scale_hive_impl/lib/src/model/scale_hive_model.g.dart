// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScaleHiveModelAdapter extends TypeAdapter<ScaleHiveModel> {
  @override
  final int typeId = 6;

  @override
  ScaleHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScaleHiveModel(
      entegrationId: fields[0] as int?,
      occurrenceTime: fields[1] as String,
      weight: fields[2] as double?,
      bmi: fields[3] as double?,
      measurementId: fields[4] as int?,
      water: fields[5] as double?,
      bodyFat: fields[6] as double?,
      visceralFat: fields[7] as double?,
      boneMass: fields[8] as double?,
      muscle: fields[9] as double?,
      bmh: fields[10] as double?,
      scaleUnit: fields[11] as int?,
      deviceId: fields[12] as String?,
      isManuel: fields[13] as bool?,
      bmiMeasurementsImageList: (fields[14] as List?)?.cast<String>(),
      note: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ScaleHiveModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.entegrationId)
      ..writeByte(1)
      ..write(obj.occurrenceTime)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.bmi)
      ..writeByte(4)
      ..write(obj.measurementId)
      ..writeByte(5)
      ..write(obj.water)
      ..writeByte(6)
      ..write(obj.bodyFat)
      ..writeByte(7)
      ..write(obj.visceralFat)
      ..writeByte(8)
      ..write(obj.boneMass)
      ..writeByte(9)
      ..write(obj.muscle)
      ..writeByte(10)
      ..write(obj.bmh)
      ..writeByte(11)
      ..write(obj.scaleUnit)
      ..writeByte(12)
      ..write(obj.deviceId)
      ..writeByte(13)
      ..write(obj.isManuel)
      ..writeByte(14)
      ..write(obj.bmiMeasurementsImageList)
      ..writeByte(15)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScaleHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
