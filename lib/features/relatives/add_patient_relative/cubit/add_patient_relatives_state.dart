// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_patient_relatives_cubit.dart';

enum AddPatientRelativesStatus {
  initial,
  loadingInProgress,
  done,
  failure,
  datum0,
  datum1,
}

@freezed
class AddPatientRelativesState with _$AddPatientRelativesState {
  const factory AddPatientRelativesState({
    required UserRelativePatientModel model,
    @Default(AddPatientRelativesStatus.initial)
        AddPatientRelativesStatus status,
  }) = _AddPatientRelativesState;

  const AddPatientRelativesState._();
}
