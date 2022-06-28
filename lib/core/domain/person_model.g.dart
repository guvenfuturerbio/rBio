// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 2;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      id: fields[1] as int?,
      imageURL: fields[2] as String?,
      name: fields[3] as String?,
      gender: fields[5] as String?,
      birthDate: fields[4] as String?,
      weight: fields[7] as String?,
      height: fields[6] as String?,
      diabetesType: fields[8] as String?,
      rangeMin: fields[10] as int?,
      rangeMax: fields[12] as int?,
      hyper: fields[13] as int?,
      hypo: fields[9] as int?,
      target: fields[11] as int?,
      userId: fields[0] as int?,
      deviceUUID: fields[14] as String?,
      manufacturerId: fields[15] as int?,
      yearOfDiagnosis: fields[16] as int?,
      smoker: fields[17] as bool?,
      isFirstUser: fields[18] as bool?,
      treatmentList: (fields[19] as List?)?.cast<TreatmentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.imageURL)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.birthDate)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.diabetesType)
      ..writeByte(9)
      ..write(obj.hypo)
      ..writeByte(10)
      ..write(obj.rangeMin)
      ..writeByte(11)
      ..write(obj.target)
      ..writeByte(12)
      ..write(obj.rangeMax)
      ..writeByte(13)
      ..write(obj.hyper)
      ..writeByte(14)
      ..write(obj.deviceUUID)
      ..writeByte(15)
      ..write(obj.manufacturerId)
      ..writeByte(16)
      ..write(obj.yearOfDiagnosis)
      ..writeByte(17)
      ..write(obj.smoker)
      ..writeByte(18)
      ..write(obj.isFirstUser)
      ..writeByte(19)
      ..write(obj.treatmentList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
