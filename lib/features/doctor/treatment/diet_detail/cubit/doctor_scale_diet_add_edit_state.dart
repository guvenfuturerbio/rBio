part of 'doctor_scale_diet_add_edit_cubit.dart';

@freezed
class DoctorScaleDietAddEditState with _$DoctorScaleDietAddEditState {
  const factory DoctorScaleDietAddEditState.initial() = _Initial;
  const factory DoctorScaleDietAddEditState.loadInProgress() = _LoadInProgress;
  const factory DoctorScaleDietAddEditState.success(
      DoctorScaleDietAddEditResult result) = _Success;
  const factory DoctorScaleDietAddEditState.failure() = _Failure;
  const factory DoctorScaleDietAddEditState.openListScreen() = _OpenListScreen;
}

class DoctorScaleDietAddEditResult {
  final bool isCreated;
  final ScaleTreatmentDietDetailResponse? response;
  final ScaleTreatmentScreenMode screenMode;
  final bool isLoading;

  DoctorScaleDietAddEditResult({
    this.isCreated = false,
    this.response,
    this.screenMode = ScaleTreatmentScreenMode.readOnly,
    this.isLoading = false,
  });

  DoctorScaleDietAddEditResult copyWith({
    bool? isCreated,
    ScaleTreatmentDietDetailResponse? response,
    ScaleTreatmentScreenMode? screenMode,
    bool? isLoading,
  }) {
    return DoctorScaleDietAddEditResult(
      isCreated: isCreated ?? this.isCreated,
      response: response ?? this.response,
      screenMode: screenMode ?? this.screenMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
