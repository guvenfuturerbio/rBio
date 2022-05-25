part of 'patient_scale_diet_detail_cubit.dart';

@freezed
class PatientScaleDietDetailState with _$PatientScaleDietDetailState {
  const factory PatientScaleDietDetailState.initial() = _Initial;
  const factory PatientScaleDietDetailState.loadInProgress() = _LoadInProgress;
  const factory PatientScaleDietDetailState.success(ScaleTreatmentDetailResponse response) = _Success;
  const factory PatientScaleDietDetailState.failure() = _Failure;
}
