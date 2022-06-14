import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';

part 'doctor_scale_treatment_list_cubit.freezed.dart';
part 'doctor_scale_treatment_list_state.dart';

class DoctorScaleTreatmentListCubit
    extends Cubit<DoctorScaleTreatmentListState> {
  DoctorScaleTreatmentListCubit(this.patientId, this.repository)
      : super(const DoctorScaleTreatmentListState.initial());
  late final int patientId;
  late final DoctorRepository repository;

  FutureOr<void> fetchAll() async {
    emit(const DoctorScaleTreatmentListState.loadInProgress());
    try {
      final result = await repository.getTreatmentNoteWithDietDoctor(
        patientId,
        ScaleTreatmentRequest(
          count: 1,
          start_Date: DateTime.now()
              .subtract(const Duration(days: 365))
              .toIso8601String(),
          end_Date: DateTime.now().toIso8601String(),
        ),
      );
      emit(
        DoctorScaleTreatmentListState.success(
          ScaleTreatmentListResult(
            startCurrentDate:
                DateTime.now().subtract(const Duration(days: 365)),
            endCurrentDate: DateTime.now(),
            list: result,
          ),
        ),
      );
    } catch (error, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(error, stackTrace: stackTrace);
      emit(const DoctorScaleTreatmentListState.failure());
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
    late final ScaleTreatmentListResult stateResult;
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        try {
          stateResult = result.copyWith(
            isLoading: true,
            startCurrentDate: startCurrentDate,
            endCurrentDate: endCurrentDate,
          );
          emit(DoctorScaleTreatmentListState.success(stateResult));
          final list = await repository.getTreatmentNoteWithDietDoctor(
              patientId, request);
          emit(
            DoctorScaleTreatmentListState.success(
              stateResult.copyWith(
                isLoading: false,
                list: list,
              ),
            ),
          );
        } catch (error, stackTrace) {
          getIt<IAppConfig>()
              .platform
              .sentryManager
              .captureException(error, stackTrace: stackTrace);
          emit(const DoctorScaleTreatmentListState.failure());
        }
      },
    );
  }
}
