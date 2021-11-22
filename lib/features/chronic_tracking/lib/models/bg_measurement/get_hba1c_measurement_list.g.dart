// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_hba1c_measurement_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHba1cMeasurementListModel _$GetHba1cMeasurementListModelFromJson(
    Map<String, dynamic> json) {
  return GetHba1cMeasurementListModel(
    start: (json['start'] as num)?.toDouble(),
    end: json['end'] as String,
    skip: json['skip'] as int,
    take: json['take'] as int,
  );
}

Map<String, dynamic> _$GetHba1cMeasurementListModelToJson(
        GetHba1cMeasurementListModel instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'skip': instance.skip,
      'take': instance.take,
    };
