import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../patient_relatives/model/user_relative_patient_model.dart';

part 'add_patient_relatives_cubit.freezed.dart';
part 'add_patient_relatives_state.dart';

class AddPatientRelativesCubit extends Cubit<AddPatientRelativesState> {
  AddPatientRelativesCubit(this._repository, this._analyticsManager)
      : super(
          AddPatientRelativesState(model: UserRelativePatientModel()),
        );
  late final Repository _repository;
  late final FirebaseAnalyticsManager _analyticsManager;

  void updateModel(UserRelativePatientModel model) =>
      emit(state.copyWith(model: model));

  void addPatientRelative(UserRelativePatientModel model) async {
    emit(state.copyWith(status: AddPatientRelativesStatus.loadingInProgress));
    try {
      final response = await _repository.addNewPatientRelative(model);

      if (response.isSuccessful == true) {
        _analyticsManager.logEvent(YakinEklemeBasariliEvent(0));
        emit(state.copyWith(status: AddPatientRelativesStatus.done));
      } else if (response.datum == 0) {
        _analyticsManager.logEvent(YakinEklemeBasariliEvent(0));
        emit(state.copyWith(status: AddPatientRelativesStatus.datum0));
      } else if (response.datum == 1) {
        _analyticsManager.logEvent(YakinEklemeBasariliEvent(1));
        emit(state.copyWith(status: AddPatientRelativesStatus.datum1));
      } else {
        _analyticsManager.logEvent(YakinEklemeBasariliEvent(-1));
        emit(state.copyWith(status: AddPatientRelativesStatus.failure));
      }
    } catch (error) {
      LoggerUtils.instance.w(error);
      _analyticsManager.logEvent(YakinEklemeHataEvent());
      emit(state.copyWith(status: AddPatientRelativesStatus.failure));
    }
  }
}
