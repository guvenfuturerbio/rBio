import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onedosehealth/core/data/service/model/patient_scale_measurement.dart';

part 'scale_doctor_loaded_result.freezed.dart';
part 'scale_doctor_loaded_result.g.dart';

@freezed
class ScaleDoctorLoadedResult with _$ScaleDoctorLoadedResult {
  const factory ScaleDoctorLoadedResult(
          {@Default(false) bool isChartVisible,
        required  List<PatientScaleMeasurement> patientScaleMeasurements}) =
      _ScaleDoctorLoadedResult;

  factory ScaleDoctorLoadedResult.fromJson(Map<String, dynamic> json) =>
      _$ScaleDoctorLoadedResultFromJson(json);
}
