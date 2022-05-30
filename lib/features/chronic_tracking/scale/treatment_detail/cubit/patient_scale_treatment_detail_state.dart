part of 'patient_scale_treatment_detail_cubit.dart';

@freezed
class PatientScaleTreatmentDetailState with _$PatientScaleTreatmentDetailState {
  const factory PatientScaleTreatmentDetailState.initial() = _Initial;
  const factory PatientScaleTreatmentDetailState.loadInProgress() =
      _LoadInProgress;
  const factory PatientScaleTreatmentDetailState.success(
      PatientScaleTreatmentDetailResult result) = _Success;
  const factory PatientScaleTreatmentDetailState.failure() = _Failure;
  const factory PatientScaleTreatmentDetailState.openListScreen() = _OpenListScreen;
}

class PatientScaleTreatmentDetailResult {
  final ScaleTreatmentDetailResponse response;
  final ScaleTreatmentScreenMode screenMode;
  final bool isLoading;

  PatientScaleTreatmentDetailResult({
    required this.response,
    this.screenMode = ScaleTreatmentScreenMode.readOnly,
    this.isLoading = false,
  });

  PatientScaleTreatmentDetailResult copyWith({
    ScaleTreatmentDetailResponse? response,
    ScaleTreatmentScreenMode? screenMode,
    bool? isLoading,
  }) {
    return PatientScaleTreatmentDetailResult(
      response: response ?? this.response,
      screenMode: screenMode ?? this.screenMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
