part of 'patient_relatives_cubit.dart';

@freezed
class PatientRelativesState with _$PatientRelativesState {
  const factory PatientRelativesState.initial() = _Initial;
  const factory PatientRelativesState.loading() = _Loading;
  const factory PatientRelativesState.loaded() = _Loaded;
  const factory PatientRelativesState.error() = _Error;
}
