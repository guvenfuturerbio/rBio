import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';
import '../model/doctor_diet_list_add_request.dart';

part 'doctor_scale_diet_detail_state.dart';
part 'doctor_scale_diet_detail_cubit.freezed.dart';

class DoctorScaleDietDetailCubit extends Cubit<DoctorScaleDietDetailState> {
  DoctorScaleDietDetailCubit(this.patientId, this.itemId, this.repository)
      : super(const DoctorScaleDietDetailState.initial());
  late final int itemId;
  late final int patientId;
  late final DoctorRepository repository;

  FutureOr<void> fetchAll() async {
    emit(const DoctorScaleDietDetailState.loadInProgress());
    try {
      final response = await repository.treatmentDietGetDetail(itemId);
      emit(
        DoctorScaleDietDetailState.success(
          DoctorScaleDietDetailResult(response: response),
        ),
      );
    } catch (error) {
      emit(const DoctorScaleDietDetailState.failure());
    }
  }

  void changeScreenMode() {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          DoctorScaleDietDetailState.success(
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
          DoctorScaleDietDetailState.success(
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
          emit(const DoctorScaleDietDetailState.openListScreen());
        } catch (error) {
          emit(const DoctorScaleDietDetailState.failure());
        }
      },
    );
  }

  FutureOr<void> deleteDietList() async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        emit(
          DoctorScaleDietDetailState.success(
            result.copyWith(isLoading: true),
          ),
        );
        try {
          await repository.deleteNoteDiet(TreatmentItemType.diet, itemId);
          emit(const DoctorScaleDietDetailState.openListScreen());
        } catch (error) {
          emit(const DoctorScaleDietDetailState.failure());
        }
      },
    );
  }
}
