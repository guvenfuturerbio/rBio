// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_doctor_loaded_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScaleDoctorLoadedResult _$$_ScaleDoctorLoadedResultFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleDoctorLoadedResult(
      isChartVisible: json['isChartVisible'] as bool? ?? false,
      graphType: $enumDecodeNullable(_$GraphTypesEnumMap, json['graphType']) ??
          GraphTypes.weight,
      patientScaleMeasurements:
          (json['patientScaleMeasurements'] as List<dynamic>)
              .map((e) =>
                  PatientScaleMeasurement.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$_ScaleDoctorLoadedResultToJson(
        _$_ScaleDoctorLoadedResult instance) =>
    <String, dynamic>{
      'isChartVisible': instance.isChartVisible,
      'graphType': _$GraphTypesEnumMap[instance.graphType],
      'patientScaleMeasurements': instance.patientScaleMeasurements,
    };

const _$GraphTypesEnumMap = {
  GraphTypes.weight: 'weight',
  GraphTypes.bmi: 'bmi',
};
