part of 'doctor_scale_treatment_add_edit_cubit.dart';

@freezed
class DoctorScaleTreatmentAddEditState with _$DoctorScaleTreatmentAddEditState {
  const factory DoctorScaleTreatmentAddEditState.initial() = _Initial;
  const factory DoctorScaleTreatmentAddEditState.loadInProgress() =
      _LoadInProgress;
  const factory DoctorScaleTreatmentAddEditState.success(
      DoctorScaleTreatmentAddEditResult result) = _Success;
  const factory DoctorScaleTreatmentAddEditState.failure() = _Failure;
  const factory DoctorScaleTreatmentAddEditState.openListScreen() =
      _OpenListScreen;
}

class DoctorScaleTreatmentAddEditResult {
  final ScaleTreatmentDetailResponse? response;
  final ScaleTreatmentScreenEditMode editMode;
  final bool isLoading;

  DoctorScaleTreatmentAddEditResult({
    this.response,
    this.editMode = ScaleTreatmentScreenEditMode.readOnly,
    this.isLoading = false,
  });

  DoctorScaleTreatmentAddEditResult copyWith({
    ScaleTreatmentDetailResponse? response,
    ScaleTreatmentScreenEditMode? editMode,
    bool? isLoading,
  }) {
    return DoctorScaleTreatmentAddEditResult(
      response: response ?? this.response,
      editMode: editMode ?? this.editMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
