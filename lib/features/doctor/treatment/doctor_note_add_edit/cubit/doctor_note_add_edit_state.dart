part of 'doctor_note_add_edit_cubit.dart';

@freezed
class DoctorNoteAddEditState with _$DoctorNoteAddEditState {
  const factory DoctorNoteAddEditState.initial() = _Initial;
  const factory DoctorNoteAddEditState.loadInProgress() = _LoadInProgress;
  const factory DoctorNoteAddEditState.success(DoctorNoteAddEditResult result) = _Success;
  const factory DoctorNoteAddEditState.failure() = _Failure;
  const factory DoctorNoteAddEditState.openListScreen() = _OpenListScreen;
}

class DoctorNoteAddEditResult {
  final ScaleTreatmentDetailResponse? response;
  final ScaleTreatmentScreenEditMode editMode;
  final bool isLoading;

  DoctorNoteAddEditResult({
    this.response,
    this.editMode = ScaleTreatmentScreenEditMode.readOnly,
    this.isLoading = false,
  });

  DoctorNoteAddEditResult copyWith({
    ScaleTreatmentDetailResponse? response,
    ScaleTreatmentScreenEditMode? editMode,
    bool? isLoading,
  }) {
    return DoctorNoteAddEditResult(
      response: response ?? this.response,
      editMode: editMode ?? this.editMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
