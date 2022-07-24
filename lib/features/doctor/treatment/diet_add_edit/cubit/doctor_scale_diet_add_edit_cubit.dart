import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/diet_detail/model/scale_treatment_diet_detail_response.dart';
import '../../../../chronic_tracking/scale/treatment_detail/model/scale_treatment_screen_edit_mode.dart';
import '../model/scale_diet_list_add_request.dart';

part 'doctor_scale_diet_add_edit_cubit.freezed.dart';
part 'doctor_scale_diet_add_edit_state.dart';

class DoctorScaleDietAddEditCubit extends Cubit<DoctorScaleDietAddEditState> {
  DoctorScaleDietAddEditCubit(this.patientId, this.itemId, this.repository)
      : super(const DoctorScaleDietAddEditState.initial());
  late final int? itemId;
  late final int patientId;
  late final DoctorRepository repository;

  FutureOr<void> setInitState() async {
    emit(const DoctorScaleDietAddEditState.loadInProgress());
    if (itemId == null) {
      emit(
        DoctorScaleDietAddEditState.success(
          DoctorScaleDietAddEditResult(
            editMode: ScaleTreatmentScreenEditMode.update,
          ),
        ),
      );
    } else {
      try {
        final response = await repository.treatmentDietGetDetail(itemId!);
        emit(
          DoctorScaleDietAddEditState.success(
            DoctorScaleDietAddEditResult(response: response),
          ),
        );
      } catch (error, stackTrace) {
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(error, stackTrace: stackTrace);
        emit(const DoctorScaleDietAddEditState.failure());
      }
    }
  }

  void changeScreenMode() {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          DoctorScaleDietAddEditState.success(
            result.copyWith(
              editMode: ScaleTreatmentScreenEditMode.update,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> saveDietList({
    required String title,
    required String breakfast,
    required String breakfastRefreshment,
    required String lunch,
    required String lunchRefreshment,
    required String dinner,
    required String dinnerRefreshment,
  }) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        try {
          _emitSuccessLoadInProgress(result);
          await repository.treatmentAddDiet(
            patientId,
            ScaleDietListAddRequest(
              title: title,
              breakfast: breakfast,
              refreshmentBreakfast: breakfastRefreshment,
              lunch: lunch,
              refreshmentLunch: lunchRefreshment,
              dinner: dinner,
              refreshmentDinner: dinnerRefreshment,
            ),
          );
          emit(const DoctorScaleDietAddEditState.openListScreen());
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

  FutureOr<void> deleteDietList() async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        try {
          _emitSuccessLoadInProgress(result);
          await repository.deleteNoteDiet(itemId!);
          emit(const DoctorScaleDietAddEditState.openListScreen());
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

  void _emitSuccessLoadInProgress(DoctorScaleDietAddEditResult result) {
    emit(
      DoctorScaleDietAddEditState.success(
        result.copyWith(status: RbioLoadingProgress.loadInProgress),
      ),
    );
  }

  void _emitSuccessFailure(DoctorScaleDietAddEditResult result) {
    emit(
      DoctorScaleDietAddEditState.success(
        result.copyWith(status: RbioLoadingProgress.failure),
      ),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(
          DoctorScaleDietAddEditState.success(
            result.copyWith(status: RbioLoadingProgress.initial),
          ),
        );
      },
    );
  }
}
