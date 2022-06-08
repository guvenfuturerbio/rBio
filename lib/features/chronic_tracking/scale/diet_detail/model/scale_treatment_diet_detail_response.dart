import 'package:freezed_annotation/freezed_annotation.dart';

part 'scale_treatment_diet_detail_response.freezed.dart';
part 'scale_treatment_diet_detail_response.g.dart';

@freezed
class ScaleTreatmentDietDetailResponse with _$ScaleTreatmentDietDetailResponse {
  const factory ScaleTreatmentDietDetailResponse({
    @JsonKey(name: 'dietTitle') String? dietTitle,
    @JsonKey(name: 'dietCreateDate') String? dietCreateDate,
    @JsonKey(name: 'createdByName') String? createdByName,
    @JsonKey(name: 'dietBreakfast') String? dietBreakfast,
    @JsonKey(name: 'dietRefreshmentBreakfast') String? dietRefreshmentBreakfast,
    @JsonKey(name: 'dietLunch') String? dietLunch,
    @JsonKey(name: 'dietRefreshmentLunch') String? dietRefreshmentLunch,
    @JsonKey(name: 'dietDinner') String? dietDinner,
    @JsonKey(name: 'dietRefreshmentDinner') String? dietRefreshmentDinner,
    @JsonKey(name: 'id') int? id,
  }) = _ScaleTreatmentDietDetailResponse;

  const ScaleTreatmentDietDetailResponse._();

  factory ScaleTreatmentDietDetailResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ScaleTreatmentDietDetailResponseFromJson(json);
}
