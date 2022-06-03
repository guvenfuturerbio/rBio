import 'package:freezed_annotation/freezed_annotation.dart';

part 'scale_treatment_response.freezed.dart';
part 'scale_treatment_response.g.dart';

@freezed
class ScaleTreatmentResponse with _$ScaleTreatmentResponse {
  const factory ScaleTreatmentResponse({
    @JsonKey(name: 'treatmentNoteList')
        List<ScaleTreatmentModel>? treatmentNoteList,
    @JsonKey(name: 'dietList') List<ScaleTreatmentDietModel>? dietList,
    @JsonKey(name: 'doctorNoteList')
        List<ScaleTreatmentDoctorNoteModel>? doctorNoteList,
  }) = _ScaleTreatmentResponse;

  const ScaleTreatmentResponse._();

  factory ScaleTreatmentResponse.fromJson(Map<String, dynamic> json) =>
      _$ScaleTreatmentResponseFromJson(json);
}

@freezed
class ScaleTreatmentModel with _$ScaleTreatmentModel {
  const factory ScaleTreatmentModel({
    @JsonKey(name: 'treatmentNoteTitle') String? treatmentNoteTitle,
    @JsonKey(name: 'treatmentNoteCreateDate') DateTime? treatmentNoteCreateDate,
    @JsonKey(name: 'createdByName') String? createdByName,
    @JsonKey(name: 'id') int? id,
  }) = _ScaleTreatmentModel;

  const ScaleTreatmentModel._();

  factory ScaleTreatmentModel.fromJson(Map<String, dynamic> json) =>
      _$ScaleTreatmentModelFromJson(json);
}

@freezed
class ScaleTreatmentDoctorNoteModel with _$ScaleTreatmentDoctorNoteModel {
  const factory ScaleTreatmentDoctorNoteModel({
    @JsonKey(name: 'treatmentNoteTitle') String? treatmentNoteTitle,
    @JsonKey(name: 'treatmentNoteCreateDate') DateTime? treatmentNoteCreateDate,
    @JsonKey(name: 'createdByName') String? createdByName,
    @JsonKey(name: 'id') int? id,
  }) = _ScaleTreatmentDoctorNoteModel;

  const ScaleTreatmentDoctorNoteModel._();

  factory ScaleTreatmentDoctorNoteModel.fromJson(Map<String, dynamic> json) =>
      _$ScaleTreatmentDoctorNoteModelFromJson(json);
}

@freezed
class ScaleTreatmentDietModel with _$ScaleTreatmentDietModel {
  const factory ScaleTreatmentDietModel({
    @JsonKey(name: 'dietTitle') String? dietTitle,
    @JsonKey(name: 'dietCreateDate', nullable: true) DateTime? dietCreateDate,
    @JsonKey(name: 'createdByName') String? createdByName,
    @JsonKey(name: 'id') int? id,
  }) = _ScaleTreatmentDietModel;

  const ScaleTreatmentDietModel._();

  factory ScaleTreatmentDietModel.fromJson(Map<String, dynamic> json) =>
      _$ScaleTreatmentDietModelFromJson(json);
}
