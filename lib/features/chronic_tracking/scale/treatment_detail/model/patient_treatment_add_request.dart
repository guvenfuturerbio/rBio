import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_treatment_add_request.freezed.dart';
part 'patient_treatment_add_request.g.dart';

@freezed
class PatientTreatmentAddRequest with _$PatientTreatmentAddRequest {
  const factory PatientTreatmentAddRequest({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'treatmentNoteTypeId') int? treatmentNoteTypeId,
  }) = _PatientTreatmentAddRequest;

  const PatientTreatmentAddRequest._();

  factory PatientTreatmentAddRequest.fromJson(Map<String, dynamic> json) =>
      _$PatientTreatmentAddRequestFromJson(json);
}
