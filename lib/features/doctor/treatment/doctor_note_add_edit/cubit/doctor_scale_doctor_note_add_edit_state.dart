part of 'doctor_scale_doctor_note_add_edit_cubit.dart';

@freezed
class DoctorScaleDoctorNoteAddEditState
    with _$DoctorScaleDoctorNoteAddEditState {
  const factory DoctorScaleDoctorNoteAddEditState.initial() = _Initial;
  const factory DoctorScaleDoctorNoteAddEditState.loadInProgress() =
      _LoadInProgress;
  const factory DoctorScaleDoctorNoteAddEditState.success(
      DoctorScaleDoctorNoteAddEditResult result) = _Success;
  const factory DoctorScaleDoctorNoteAddEditState.failure() = _Failure;
  const factory DoctorScaleDoctorNoteAddEditState.openListScreen() =
      _OpenListScreen;
}

class DoctorScaleDoctorNoteAddEditResult {
  final ScaleTreatmentDetailResponse? response;
  final ScaleTreatmentScreenEditMode editMode;
  final RbioLoadingProgress status;

  DoctorScaleDoctorNoteAddEditResult({
    this.response,
    this.editMode = ScaleTreatmentScreenEditMode.readOnly,
    this.status = RbioLoadingProgress.initial,
  });

  DoctorScaleDoctorNoteAddEditResult copyWith({
    ScaleTreatmentDetailResponse? response,
    ScaleTreatmentScreenEditMode? editMode,
    RbioLoadingProgress? status,
  }) {
    return DoctorScaleDoctorNoteAddEditResult(
      response: response ?? this.response,
      editMode: editMode ?? this.editMode,
      status: status ?? this.status,
    );
  }
}
