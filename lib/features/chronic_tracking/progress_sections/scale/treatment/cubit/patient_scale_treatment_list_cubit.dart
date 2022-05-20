import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/core.dart';
import '../model/scale_treatment_request.dart';
import '../model/treatment_filter_type.dart';
import '../model/treatment_type.dart';

part 'patient_scale_treatment_list_cubit.freezed.dart';
part 'patient_scale_treatment_list_state.dart';

class PatientScaleTreatmentListCubit
    extends Cubit<PatientScaleTreatmentListState> {
  PatientScaleTreatmentListCubit(this.profileStorage, this.repository)
      : super(const PatientScaleTreatmentListState.initial()) {
    final user = profileStorage.getFirst();
    entegrationId = user.id;
  }
  late final int? entegrationId;
  late final ProfileStorageImpl profileStorage;
  late final ChronicTrackingRepository repository;

  FutureOr<void> fetchAll(ScaleTreatmentRequest request) async {
    emit(const PatientScaleTreatmentListState.loadInProgress());
    try {
      final result =
          await repository.getTreatmentNoteWithDiet(entegrationId, request);
      emit(PatientScaleTreatmentListState.success(mockResult));
    } catch (error) {
      // emit(const PatientScaleTreatmentListState.failure());
      emit(PatientScaleTreatmentListState.success(mockResult));
    }
  }

  FutureOr<void> filterTypeChange(TreatmentFilterType type) async {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          PatientScaleTreatmentListState.success(
            result.copyWith(
              filterType: type,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> setStartDate(DateTime date) async {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          PatientScaleTreatmentListState.success(
            result.copyWith(
              startCurrentDate: date,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> setEndDate(DateTime date) async {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          PatientScaleTreatmentListState.success(
            result.copyWith(
              endCurrentDate: date,
            ),
          ),
        );
      },
    );
  }
}

final mockResult = PatientScaleTreatmentListResult(
  startCurrentDate: DateTime.now().subtract(const Duration(days: 365)),
  endCurrentDate: DateTime.now(),
  list: [
    RbioTreatmentModel(
      dateTime: DateTime.now(),
      description: 'Dyt. Bengi Yeşil',
      title: 'Diyet Listesi',
      type: TreatmentType.diet,
    ),
    RbioTreatmentModel(
      dateTime: DateTime.now(),
      description: 'Dyt. Bengi Yeşil',
      title: 'Tedavi notları',
      type: TreatmentType.treatmentNote,
    ),
  ],
);
