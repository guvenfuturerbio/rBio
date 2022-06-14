import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';

part 'doctor_scale_doctor_note_add_edit_state.dart';
part 'doctor_scale_doctor_note_add_edit_cubit.freezed.dart';

class DoctorScaleDoctorNoteAddEditCubit
    extends Cubit<DoctorScaleDoctorNoteAddEditState> {
  DoctorScaleDoctorNoteAddEditCubit(
      this.patientId, this.itemId, this.repository)
      : super(const DoctorScaleDoctorNoteAddEditState.initial());
  late final int? itemId;
  late final int patientId;
  late final DoctorRepository repository;

  FutureOr<void> setInitState() async {
    emit(const DoctorScaleDoctorNoteAddEditState.loadInProgress());
    if (itemId == null) {
      emit(
        DoctorScaleDoctorNoteAddEditState.success(
          DoctorScaleDoctorNoteAddEditResult(
            editMode: ScaleTreatmentScreenEditMode.update,
          ),
        ),
      );
    } else {
      try {
        final response = await repository.treatmentGetDoctorNoteDetail(itemId!);
        emit(
          DoctorScaleDoctorNoteAddEditState.success(
            DoctorScaleDoctorNoteAddEditResult(response: response),
          ),
        );
      } catch (error, stackTrace) {
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(error, stackTrace: stackTrace);
        emit(const DoctorScaleDoctorNoteAddEditState.failure());
      }
    }
  }

  void changeScreenMode() {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          DoctorScaleDoctorNoteAddEditState.success(
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
        try {
          _emitSuccessLoadInProgress(result);
          await repository.addTreatmentNote(
            patientId,
            PatientTreatmentAddRequest(
              title: title,
              text: description,
              treatmentNoteTypeId: 2,
            ),
          );
          emit(const DoctorScaleDoctorNoteAddEditState.openListScreen());
        } catch (error, stackTrace) {
          getIt<IAppConfig>()
              .platform
              .sentryManager
              .captureException(error, stackTrace: stackTrace);
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
          emit(const DoctorScaleDoctorNoteAddEditState.openListScreen());
        } catch (error, stackTrace) {
          getIt<IAppConfig>()
              .platform
              .sentryManager
              .captureException(error, stackTrace: stackTrace);
          _emitSuccessFailure(result);
        }
      },
    );
  }

  void _emitSuccessLoadInProgress(DoctorScaleDoctorNoteAddEditResult result) {
    emit(
      DoctorScaleDoctorNoteAddEditState.success(
        result.copyWith(status: RbioLoadingProgress.loadInProgress),
      ),
    );
  }

  void _emitSuccessFailure(DoctorScaleDoctorNoteAddEditResult result) {
    emit(
      DoctorScaleDoctorNoteAddEditState.success(
        result.copyWith(status: RbioLoadingProgress.failure),
      ),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(
          DoctorScaleDoctorNoteAddEditState.success(
            result.copyWith(status: RbioLoadingProgress.initial),
          ),
        );
      },
    );
  }
}
