import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../core/data/repository/cronic_tracking_repository.dart';
import '../model/scale_treatment_detail_response.dart';
import '../model/treatment_item_type.dart';

part 'patient_scale_diet_detail_state.dart';
part 'patient_scale_diet_detail_cubit.freezed.dart';

class PatientScaleDietDetailCubit extends Cubit<PatientScaleDietDetailState> {
  PatientScaleDietDetailCubit(this.repository)
      : super(const PatientScaleDietDetailState.initial());
  late final ChronicTrackingRepository repository;

  FutureOr<void> fetchAll(int itemId) async {
    emit(const PatientScaleDietDetailState.loadInProgress());
    try {
      final result = await repository.treatmentGetDetail(
        TreatmentItemType.diet,
        itemId,
      );
      emit(PatientScaleDietDetailState.success(result));
    } catch (error) {
      emit(const PatientScaleDietDetailState.failure());
    }
  }
}
