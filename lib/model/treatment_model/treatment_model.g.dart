// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TreatmentModelAdapter extends TypeAdapter<TreatmentModel> {
  @override
  final int typeId = 4;

  @override
  TreatmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TreatmentModel(
      treatment: fields[0] as String?,
      createDate: fields[1] as DateTime?,
      id: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TreatmentModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.treatment)
      ..writeByte(1)
      ..write(obj.createDate)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TreatmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
