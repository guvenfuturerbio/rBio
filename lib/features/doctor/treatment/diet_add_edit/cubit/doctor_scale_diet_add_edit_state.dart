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
  final bool isLoading;

  DoctorScaleDietAddEditResult({
    this.response,
    this.editMode = ScaleTreatmentScreenEditMode.readOnly,
    this.isLoading = false,
  });

  DoctorScaleDietAddEditResult copyWith({
    ScaleTreatmentDietDetailResponse? response,
    ScaleTreatmentScreenEditMode? editMode,
    bool? isLoading,
  }) {
    return DoctorScaleDietAddEditResult(
      response: response ?? this.response,
      editMode: editMode ?? this.editMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
