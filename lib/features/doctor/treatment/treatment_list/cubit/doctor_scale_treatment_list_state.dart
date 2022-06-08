part of 'doctor_scale_treatment_list_cubit.dart';

@freezed
class DoctorScaleTreatmentListState with _$DoctorScaleTreatmentListState {
  const factory DoctorScaleTreatmentListState.initial() = _Initial;
  const factory DoctorScaleTreatmentListState.loadInProgress() = _LoadInProgress;
  const factory DoctorScaleTreatmentListState.success(ScaleTreatmentListResult result) = _Success;
  const factory DoctorScaleTreatmentListState.failure() = _Failure;
}
