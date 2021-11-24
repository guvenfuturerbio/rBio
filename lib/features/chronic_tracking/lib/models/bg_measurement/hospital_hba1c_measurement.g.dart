// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_hba1c_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalHba1cMeasurementModel _$HospitalHba1cMeasurementModelFromJson(
    Map<String, dynamic> json) {
  return HospitalHba1cMeasurementModel(
    value: (json['value'] as num).toDouble(),
    date: json['date'] as String,
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$HospitalHba1cMeasurementModelToJson(
        HospitalHba1cMeasurementModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'date': instance.date,
      'note': instance.note,
    };
