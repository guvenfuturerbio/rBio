part of 'patient_relatives_cubit.dart';

@freezed
class PatientRelativesState with _$PatientRelativesState {
  const factory PatientRelativesState.initial() = _Initial;
  const factory PatientRelativesState.loadInProgress() = _LoadInProgress;
  const factory PatientRelativesState.success({
    required PatientRelativeInfoResponse response,
  }) = _Success;
  const factory PatientRelativesState.failure() = _Failure;
}
