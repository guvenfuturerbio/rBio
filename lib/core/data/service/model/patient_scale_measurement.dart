import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_scale_measurement.freezed.dart';
part 'patient_scale_measurement.g.dart';

@freezed
class PatientScaleMeasurement with _$PatientScaleMeasurement {
  const factory PatientScaleMeasurement({
    @JsonKey(name: "entegration_id") int? entegrationId,
    @JsonKey(name: "occurrence_time") String? occurrenceTime,
    @JsonKey(name: "weight") double? weight,
    @JsonKey(name: "bmi") double? bmi,
    @JsonKey(name: "measurement_id") int? measurementId,
    @JsonKey(name: "water") double? water,
    @JsonKey(name: "body_fat") double? bodyFat,
    @JsonKey(name: "visceral_fat") double? visceralFat,
    @JsonKey(name: "bone_mass") double? boneMass,
    @JsonKey(name: "muscle") double? muscle,
    @JsonKey(name: "bmh") double? bmh,
    @JsonKey(name: "scale_unit") int? scaleUnit,
    @JsonKey(name: "device_id") String? deviceId,
    @JsonKey(name: "is_manuel") bool? isManuel,
    @JsonKey(name: "note") String? note,
        @JsonKey(name: "height") int? height,
    @JsonKey(name: "age") int? age,
    @JsonKey(name: "genderId") int? genderId,

  }) = _PatientScaleMeasurement;

  factory PatientScaleMeasurement.fromJson(Map<String, dynamic> json) =>
      _$PatientScaleMeasurementFromJson(json);
}
