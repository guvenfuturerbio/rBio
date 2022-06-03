import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';

part 'doctor_scale_treatment_add_edit_state.dart';
part 'doctor_scale_treatment_add_edit_cubit.freezed.dart';

class DoctorScaleTreatmentAddEditCubit
    extends Cubit<DoctorScaleTreatmentAddEditState> {
  DoctorScaleTreatmentAddEditCubit(this.patientId, this.itemId, this.repository)
      : super(const DoctorScaleTreatmentAddEditState.initial());
  late final int? itemId;
  late final int patientId;
  late final DoctorRepository repository;

  FutureOr<void> setInitState() async {
    emit(const DoctorScaleTreatmentAddEditState.loadInProgress());
    if (itemId == null) {
      emit(
        DoctorScaleTreatmentAddEditState.success(
          DoctorScaleTreatmentAddEditResult(
            editMode: ScaleTreatmentScreenEditMode.update,
          ),
        ),
      );
    } else {
      try {
        final response = await repository.treatmentGetDetail(itemId!);
        emit(
          DoctorScaleTreatmentAddEditState.success(
            DoctorScaleTreatmentAddEditResult(response: response),
          ),
        );
      } catch (error) {
        emit(const DoctorScaleTreatmentAddEditState.failure());
      }
    }
  }

  void changeScreenMode() {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          DoctorScaleTreatmentAddEditState.success(
            result.copyWith(
              editMode: ScaleTreatmentScreenEditMode.update,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> saveTreatmentNote(String text) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        try {
          _emitSuccessLoadInProgress(result);
          await repository.addTreatmentNote(
            patientId,
            PatientTreatmentAddRequest(
              title: "",
              text: text,
              treatmentNoteTypeId: 1,
            ),
          );
          emit(const DoctorScaleTreatmentAddEditState.openListScreen());
        } catch (error) {
          _emitSuccessFailure(result);
        }
      },
    );
  }

  FutureOr<void> deleteTreatmentNote() async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        try {
          _emitSuccessLoadInProgress(result);
          await repository.deleteTreatmentNote(itemId!);
          emit(const DoctorScaleTreatmentAddEditState.openListScreen());
        } catch (error) {
          _emitSuccessFailure(result);
        }
      },
    );
  }

  void _emitSuccessLoadInProgress(DoctorScaleTreatmentAddEditResult result) {
    emit(
      DoctorScaleTreatmentAddEditState.success(
        result.copyWith(status: RbioLoadingProgress.loadInProgress),
      ),
    );
  }

  void _emitSuccessFailure(DoctorScaleTreatmentAddEditResult result) {
    emit(
      DoctorScaleTreatmentAddEditState.success(
        result.copyWith(status: RbioLoadingProgress.failure),
      ),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(
          DoctorScaleTreatmentAddEditState.success(
            result.copyWith(status: RbioLoadingProgress.initial),
          ),
        );
      },
    );
  }
}
