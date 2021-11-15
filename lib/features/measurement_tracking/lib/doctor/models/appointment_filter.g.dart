// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentFilter _$AppointmentFilterFromJson(Map<String, dynamic> json) {
  return AppointmentFilter(
    type: json['type'] as String,
    start: json['start'] as String,
    end: json['end'] as String,
  );
}

Map<String, dynamic> _$AppointmentFilterToJson(AppointmentFilter instance) =>
    <String, dynamic>{
      'type': instance.type,
      'start': instance.start,
      'end': instance.end,
    };
