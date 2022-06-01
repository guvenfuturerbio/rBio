import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';

part 'doctor_note_add_edit_state.dart';
part 'doctor_note_add_edit_cubit.freezed.dart';

class DoctorNoteAddEditCubit extends Cubit<DoctorNoteAddEditState> {
  DoctorNoteAddEditCubit(this.patientId, this.itemId, this.repository)
      : super(const DoctorNoteAddEditState.initial());
  late final int? itemId;
  late final int patientId;
  late final DoctorRepository repository;

  FutureOr<void> setInitState() async {
    emit(const DoctorNoteAddEditState.loadInProgress());
    if (itemId == null) {
      emit(
        DoctorNoteAddEditState.success(
          DoctorNoteAddEditResult(
            editMode: ScaleTreatmentScreenEditMode.update,
          ),
        ),
      );
    } else {
      try {
        final response = await repository.treatmentGetDoctorNoteDetail(itemId!);
        emit(
          DoctorNoteAddEditState.success(
            DoctorNoteAddEditResult(response: response),
          ),
        );
      } catch (error) {
        emit(const DoctorNoteAddEditState.failure());
      }
    }
  }

  void changeScreenMode() {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          DoctorNoteAddEditState.success(
            result.copyWith(
              editMode: ScaleTreatmentScreenEditMode.update,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> saveTreatmentNote(
    String title,
    String description,
  ) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        emit(
          DoctorNoteAddEditState.success(
            result.copyWith(isLoading: true),
          ),
        );
        try {
          await repository.addTreatmentNote(
            patientId,
            PatientTreatmentAddRequest(
              title: title,
              text: description,
              treatmentNoteTypeId: 2,
            ),
          );
          emit(const DoctorNoteAddEditState.openListScreen());
        } catch (error) {
          emit(const DoctorNoteAddEditState.failure());
        }
      },
    );
  }

  FutureOr<void> deleteTreatmentNote() async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        emit(
          DoctorNoteAddEditState.success(
            result.copyWith(isLoading: true),
          ),
        );
        try {
          await repository.deleteTreatmentNote(itemId!);
          emit(const DoctorNoteAddEditState.openListScreen());
        } catch (error) {
          emit(const DoctorNoteAddEditState.failure());
        }
      },
    );
  }
}
