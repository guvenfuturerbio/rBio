import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';
import '../model/doctor_diet_list_add_request.dart';

part 'doctor_scale_diet_add_edit_state.dart';
part 'doctor_scale_diet_add_edit_cubit.freezed.dart';

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
          DoctorScaleDietAddEditResult(isCreated: true),
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
      } catch (error) {
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
              screenMode: ScaleTreatmentScreenMode.update,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> saveDietList({
    required String title,
    required String breakfast,
    required String refreshment,
    required String lunch,
    required String dinner,
  }) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        emit(
          DoctorScaleDietAddEditState.success(
            result.copyWith(isLoading: true),
          ),
        );
        try {
          await repository.treatmentAddDiet(
            patientId,
            DoctorDietListAddRequest(
              title: title,
              breakfast: breakfast,
              refreshment: refreshment,
              lunch: lunch,
              dinner: dinner,
            ),
          );
          emit(const DoctorScaleDietAddEditState.openListScreen());
        } catch (error) {
          emit(const DoctorScaleDietAddEditState.failure());
        }
      },
    );
  }

  FutureOr<void> deleteDietList() async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        emit(
          DoctorScaleDietAddEditState.success(
            result.copyWith(isLoading: true),
          ),
        );
        try {
          await repository.deleteNoteDiet(TreatmentItemType.diet, itemId!);
          emit(const DoctorScaleDietAddEditState.openListScreen());
        } catch (error) {
          emit(const DoctorScaleDietAddEditState.failure());
        }
      },
    );
  }
}
