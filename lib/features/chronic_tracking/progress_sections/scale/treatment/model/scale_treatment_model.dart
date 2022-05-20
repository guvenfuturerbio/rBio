import 'package:freezed_annotation/freezed_annotation.dart';

part 'scale_treatment_model.freezed.dart';
part 'scale_treatment_model.g.dart';

@freezed
class ScaleResponseModel with _$ScaleResponseModel {
  const factory ScaleResponseModel({
    @JsonKey(name: 'treatmentNoteList')
        List<ScaleTreatmentModel>? treatmentNoteList,
    @JsonKey(name: 'dietList') List<ScaleTreatmentDietModel>? dietList,
    @JsonKey(name: 'doctorNoteList') bool? doctorNoteList,
  }) = _ScaleResponseModel;

  const ScaleResponseModel._();

  factory ScaleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ScaleResponseModelFromJson(json);
}

@freezed
class ScaleTreatmentModel with _$ScaleTreatmentModel {
  const factory ScaleTreatmentModel({
    @JsonKey(name: 'treatmentNoteTitle') String? treatmentNoteTitle,
    @JsonKey(name: 'treatmentNoteCreateDate') DateTime? treatmentNoteCreateDate,
    @JsonKey(name: 'treatmentNoteId') int? treatmentNoteId,
    @JsonKey(name: 'createdByName') String? createdByName,
  }) = _ScaleTreatmentModel;

  const ScaleTreatmentModel._();

  factory ScaleTreatmentModel.fromJson(Map<String, dynamic> json) =>
      _$ScaleTreatmentModelFromJson(json);
}

@freezed
class ScaleTreatmentDietModel with _$ScaleTreatmentDietModel {
  const factory ScaleTreatmentDietModel({
    @JsonKey(name: 'dietTitle') String? dietTitle,
    @JsonKey(name: 'dietCreateDate', nullable: true) DateTime? dietCreateDate,
    @JsonKey(name: 'dietId') int? dietId,
    @JsonKey(name: 'createdByName') String? createdByName,
    @JsonKey(name: 'dietBreakfast') String? dietBreakfast,
    @JsonKey(name: 'dietRefreshment') String? dietRefreshment,
    @JsonKey(name: 'dietLunch') String? dietLunch,
    @JsonKey(name: 'dietDinner') String? dietDinner,
  }) = _ScaleTreatmentDietModel;

  const ScaleTreatmentDietModel._();

  factory ScaleTreatmentDietModel.fromJson(Map<String, dynamic> json) =>
      _$ScaleTreatmentDietModelFromJson(json);
}
