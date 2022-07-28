// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glucose_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GlucoseDataAdapter extends TypeAdapter<GlucoseData> {
  @override
  final int typeId = 0;

  @override
  GlucoseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GlucoseData(
      level: fields[1] as String,
      tag: fields[2] as int?,
      note: fields[3] as String,
      time: fields[4] as int,
      device: fields[5] as int,
      manual: fields[6] as bool,
      deviceUUID: fields[8] as String,
      deviceName: fields[7] as String,
      imageURL: fields[9] as String?,
      isDeleted: fields[10] as bool,
      userId: fields[11] as int?,
      measurementId: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, GlucoseData obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.measurementId)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.tag)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.device)
      ..writeByte(6)
      ..write(obj.manual)
      ..writeByte(7)
      ..write(obj.deviceName)
      ..writeByte(8)
      ..write(obj.deviceUUID)
      ..writeByte(9)
      ..write(obj.imageURL)
      ..writeByte(10)
      ..write(obj.isDeleted)
      ..writeByte(11)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlucoseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
