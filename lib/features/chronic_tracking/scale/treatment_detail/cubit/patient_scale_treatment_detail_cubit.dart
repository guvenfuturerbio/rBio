import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../scale.dart';

part 'patient_scale_treatment_detail_cubit.freezed.dart';
part 'patient_scale_treatment_detail_state.dart';

class PatientScaleTreatmentDetailCubit
    extends Cubit<PatientScaleTreatmentDetailState> {
  PatientScaleTreatmentDetailCubit(this.profileStorage, this.repository)
      : super(const PatientScaleTreatmentDetailState.initial()) {
    final user = profileStorage.getFirst();
    entegrationId = user.id;
  }
  late final int? entegrationId;
  late final ProfileStorageImpl profileStorage;
  late final ChronicTrackingRepository repository;

  FutureOr<void> fetchAll(int itemId) async {
    emit(const PatientScaleTreatmentDetailState.loadInProgress());
    try {
      final response = await repository.treatmentGetDetail(itemId);
      emit(
        PatientScaleTreatmentDetailState.success(
          PatientScaleTreatmentDetailResult(response: response),
        ),
      );
    } catch (error, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(error, stackTrace: stackTrace);
      emit(const PatientScaleTreatmentDetailState.failure());
    }
  }

  void changeScreenMode() {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          PatientScaleTreatmentDetailState.success(
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
        emit(
          PatientScaleTreatmentDetailState.success(
            result.copyWith(isLoading: true),
          ),
        );
        try {
          await repository.addTreatmentNote(
            entegrationId,
            PatientTreatmentAddRequest(
              title: result.response.treatmentNoteTitle,
              text: text,
              treatmentNoteTypeId: 1,
            ),
          );
          emit(const PatientScaleTreatmentDetailState.openListScreen());
        } catch (error, stackTrace) {
          getIt<IAppConfig>()
              .platform
              .sentryManager
              .captureException(error, stackTrace: stackTrace);
          emit(const PatientScaleTreatmentDetailState.failure());
        }
      },
    );
  }
}
