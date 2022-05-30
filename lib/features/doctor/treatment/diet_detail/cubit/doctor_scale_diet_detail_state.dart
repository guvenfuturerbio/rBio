part of 'doctor_scale_diet_detail_cubit.dart';

@freezed
class DoctorScaleDietDetailState with _$DoctorScaleDietDetailState {
  const factory DoctorScaleDietDetailState.initial() = _Initial;
  const factory DoctorScaleDietDetailState.loadInProgress() = _LoadInProgress;
  const factory DoctorScaleDietDetailState.success(
      DoctorScaleDietDetailResult result) = _Success;
  const factory DoctorScaleDietDetailState.failure() = _Failure;
  const factory DoctorScaleDietDetailState.openListScreen() = _OpenListScreen;
}

class DoctorScaleDietDetailResult {
  final ScaleTreatmentDietDetailResponse response;
  final ScaleTreatmentScreenMode screenMode;
  final bool isLoading;

  DoctorScaleDietDetailResult({
    required this.response,
    this.screenMode = ScaleTreatmentScreenMode.readOnly,
    this.isLoading = false,
  });

  DoctorScaleDietDetailResult copyWith({
    ScaleTreatmentDietDetailResponse? response,
    ScaleTreatmentScreenMode? screenMode,
    bool? isLoading,
  }) {
    return DoctorScaleDietDetailResult(
      response: response ?? this.response,
      screenMode: screenMode ?? this.screenMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
