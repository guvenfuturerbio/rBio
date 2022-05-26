import 'package:freezed_annotation/freezed_annotation.dart';

part 'scale_treatment_detail_response.freezed.dart';
part 'scale_treatment_detail_response.g.dart';

@freezed
class ScaleTreatmentDetailResponse with _$ScaleTreatmentDetailResponse {
  const factory ScaleTreatmentDetailResponse({
    @JsonKey(name: 'treatmentNoteTitle') String? treatmentNoteTitle,
    @JsonKey(name: 'treatmentNoteText') String? treatmentNoteText,
    @JsonKey(name: 'treatmentNoteCreateDate') String? treatmentNoteCreateDate,
    @JsonKey(name: 'createdByName') String? createdByName,
    @JsonKey(name: 'id') int? id,
  }) = _ScaleTreatmentDetailResponse;

  const ScaleTreatmentDetailResponse._();

  factory ScaleTreatmentDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ScaleTreatmentDetailResponseFromJson(json);
}
