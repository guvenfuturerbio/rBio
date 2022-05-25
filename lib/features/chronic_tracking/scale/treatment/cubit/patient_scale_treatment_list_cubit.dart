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

  FutureOr<void> fetchAll() async {
    emit(const PatientScaleTreatmentListState.loadInProgress());
    try {
      final result = await repository.getTreatmentNoteWithDiet(
        entegrationId,
        ScaleTreatmentRequest(
          count: 1,
          start_Date: DateTime.now()
              .subtract(const Duration(days: 365))
              .toIso8601String(),
          end_Date: DateTime.now().toIso8601String(),
        ),
      );
      emit(
        PatientScaleTreatmentListState.success(
          PatientScaleTreatmentListResult(
            startCurrentDate:
                DateTime.now().subtract(const Duration(days: 365)),
            endCurrentDate: DateTime.now(),
            list: result,
          ),
        ),
      );
    } catch (error) {
      emit(const PatientScaleTreatmentListState.failure());
    }
  }

  FutureOr<void> filterTypeChange(TreatmentFilterType type) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        await fetchHistory(
          ScaleTreatmentRequest(
            count: type == TreatmentFilterType.current ? 1 : null,
            start_Date: result.startCurrentDate.toIso8601String(),
            end_Date: result.endCurrentDate.toIso8601String(),
          ),
          result.startCurrentDate,
          result.endCurrentDate,
        );
      },
    );
  }

  FutureOr<void> setStartDate(DateTime date) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        await fetchHistory(
          ScaleTreatmentRequest(
            count: null,
            start_Date: date.toIso8601String(),
            end_Date: result.endCurrentDate.toIso8601String(),
          ),
          date,
          result.endCurrentDate,
        );
      },
    );
  }

  FutureOr<void> setEndDate(DateTime date) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        await fetchHistory(
          ScaleTreatmentRequest(
            count: null,
            start_Date: result.startCurrentDate.toIso8601String(),
            end_Date: date.toIso8601String(),
          ),
          result.startCurrentDate,
          date,
        );
      },
    );
  }

  FutureOr<void> fetchHistory(
    ScaleTreatmentRequest request,
    DateTime startCurrentDate,
    DateTime endCurrentDate,
  ) async {
    late final PatientScaleTreatmentListResult stateResult;
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        try {
          stateResult = result.copyWith(
            isLoading: true,
            startCurrentDate: startCurrentDate,
            endCurrentDate: endCurrentDate,
          );
          emit(PatientScaleTreatmentListState.success(stateResult));
          final list =
              await repository.getTreatmentNoteWithDiet(entegrationId, request);
          emit(
            PatientScaleTreatmentListState.success(
              stateResult.copyWith(
                isLoading: false,
                list: list,
              ),
            ),
          );
        } catch (error) {
          emit(const PatientScaleTreatmentListState.failure());
        }
      },
    );
  }
}
