part of 'patient_relatives_cubit.dart';

enum AddPatientRelativesStatus {
  initial,
  loadingInProgress,
  done,
  failure,
  datum0,
  datum1,
}

@freezed
class PatientRelativesState with _$PatientRelativesState {
  const factory PatientRelativesState.initial() = _Initial;
  const factory PatientRelativesState.loadInProgress() = _LoadInProgress;
  const factory PatientRelativesState.success(
      {required PatientRelativeInfoResponse response}) = _Success;
  const factory PatientRelativesState.failure() = _Failure;
}
