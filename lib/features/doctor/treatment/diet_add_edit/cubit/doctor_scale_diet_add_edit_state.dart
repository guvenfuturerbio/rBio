part of 'doctor_scale_diet_add_edit_cubit.dart';

@freezed
class DoctorScaleDietAddEditState with _$DoctorScaleDietAddEditState {
  const factory DoctorScaleDietAddEditState.initial() = _Initial;
  const factory DoctorScaleDietAddEditState.loadInProgress() = _LoadInProgress;
  const factory DoctorScaleDietAddEditState.success(DoctorScaleDietAddEditResult result) = _Success;
  const factory DoctorScaleDietAddEditState.failure() = _Failure;
  const factory DoctorScaleDietAddEditState.openListScreen() = _OpenListScreen;
}

class DoctorScaleDietAddEditResult {
  final ScaleTreatmentDietDetailResponse? response;
  final ScaleTreatmentScreenEditMode editMode;
  final RbioLoadingProgress status;

  DoctorScaleDietAddEditResult({
    this.response,
    this.editMode = ScaleTreatmentScreenEditMode.readOnly,
    this.status = RbioLoadingProgress.initial,
  });

  DoctorScaleDietAddEditResult copyWith({
    ScaleTreatmentDietDetailResponse? response,
    ScaleTreatmentScreenEditMode? editMode,
    RbioLoadingProgress? status,
  }) {
    return DoctorScaleDietAddEditResult(
      response: response ?? this.response,
      editMode: editMode ?? this.editMode,
      status: status ?? this.status,
    );
  }
}
