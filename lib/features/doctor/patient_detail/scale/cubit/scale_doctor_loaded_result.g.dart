// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_doctor_loaded_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScaleDoctorLoadedResult _$$_ScaleDoctorLoadedResultFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleDoctorLoadedResult(
      isChartVisible: json['isChartVisible'] as bool? ?? false,
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
      'patientScaleMeasurements': instance.patientScaleMeasurements,
    };
