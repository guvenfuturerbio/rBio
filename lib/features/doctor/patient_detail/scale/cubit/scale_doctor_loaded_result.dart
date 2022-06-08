import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import 'scale_doctor_cubit.dart';

part 'scale_doctor_loaded_result.freezed.dart';
part 'scale_doctor_loaded_result.g.dart';

@freezed
class ScaleDoctorLoadedResult with _$ScaleDoctorLoadedResult {
  const factory ScaleDoctorLoadedResult(
          {@Default(false) bool isChartVisible,
          @Default(GraphTypes.weight) GraphTypes graphType,
          required List<PatientScaleMeasurement> patientScaleMeasurements}) =
      _ScaleDoctorLoadedResult;

  factory ScaleDoctorLoadedResult.fromJson(Map<String, dynamic> json) =>
      _$ScaleDoctorLoadedResultFromJson(json);
}
