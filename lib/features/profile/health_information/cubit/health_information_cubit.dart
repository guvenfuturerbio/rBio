import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

part 'health_information_state.dart';

class HealthInformationCubit extends Cubit<HealthInformationState> {
  HealthInformationCubit() : super(HealthInformationState()) {
    final currentState = state;
    currentState.selection = getIt<ProfileStorageImpl>().getFirst();
    key = currentState.selection?.key;
    currentState.selection = state.selection?.copy();
    emit(currentState);
  }
  dynamic key;

  Future<void> updateInformation(Person person) async {
    emit(state.copyWith(showProgressOverlay: true));

    try {
      person.isFirstUser = false;
      person.userId = -1;
      final response = await getIt<ChronicTrackingRepository>().updateProfile(
        person,
        person.id!,
      );

      if (response.xIsSuccessful) {
        getIt<ProfileStorageImpl>().update(state.selection!, key);
        changeSnackbarStatus(RbioLoadingProgress.success);
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      changeSnackbarStatus(RbioLoadingProgress.failure);
    }
  }

  void changeSnackbarStatus(RbioLoadingProgress value) {
    emit(state.copyWith(status: value, showProgressOverlay: false));
    Future.delayed(const Duration(milliseconds: 100), () {
      emit(state.copyWith(status: RbioLoadingProgress.initial));
    });
  }

  void changeDiabetsType(String type) {
    emit(
      state.copyWith(
        selection: state.selection!.copyWith(diabetesType: type),
      ),
    );
  }

  void changeHeight(int? height) {
    if (height != null && state.selection != null) {
      emit(
        state.copyWith(
          selection: state.selection!.copyWith(
            height: height.toString(),
          ),
        ),
      );
    }
  }

  // #region changeWeight
  void changeWeight(int? weight) {
    if (weight != null && state.selection != null) {
      emit(
        state.copyWith(
          selection: state.selection!.copyWith(
            weight: weight.toString(),
          ),
        ),
      );
    }
  }
  // #endregion

// #region changeNormalRange
  void changeNormalRange(Map<dynamic, dynamic> value) {
    if (value['min'] != null &&
        value['max'] != null &&
        state.selection != null) {
      emit(
        state.copyWith(
          selection: state.selection!.copyWith(
            rangeMax: value['max'],
            rangeMin: value['min'],
          ),
        ),
      );
    }
  }

  // #endregion
  // #region changeMaxRange
  void changeMaxRange(int? selectedHyper) async {
    if (selectedHyper != null && state.selection != null) {
      emit(
        state.copyWith(
          selection: state.selection!.copyWith(
              hyper: selectedHyper < (state.selection?.rangeMax ?? 0)
                  ? (state.selection?.rangeMax ?? 0) + 1
                  : selectedHyper),
        ),
      );
    }
  }

  // #endregion
  // #region changeMinRange
  void changeMinRange(int? selectedMinRange) {
    if (selectedMinRange != null && state.selection != null) {
      var _tempHypo = selectedMinRange * 10;
      emit(state.copyWith(
          selection: state.selection?.copyWith(
              hypo: _tempHypo > (state.selection?.rangeMin ?? 0)
                  ? (state.selection?.rangeMin ?? 1) - 1
                  : _tempHypo)));
    }
  }

  // #endregion
  // #region changeDiagnosis
  void changeDiagnosis(int? diagnosis) {
    if (diagnosis != null && state.selection != null) {
      emit(state.copyWith(
          selection: state.selection!.copyWith(yearOfDiagnosis: diagnosis)));
    }
  }
  // #endregion

  // #region _getMaxRangeList
  List<int> getMaxRangeList() {
    List<int> hyperWidget = [];
    for (int i = state.selection?.rangeMax ?? 50; i < 1000; i = i + 10) {
      hyperWidget.add(i);
    }
    return hyperWidget;
  }
  // #endregion

  // #region changeSmokerType
  void changeSmokerType(bool type) {
    if (state.selection != null) {
      emit(
        state.copyWith(
          selection: state.selection!.copyWith(smoker: type),
        ),
      );
    }
  }
  // #endregion

  // #region changeTextFiels
  void changeTextFiels({
    required TextEditingController diabetTypeController,
    required TextEditingController weightController,
    required TextEditingController normalRangeController,
    required TextEditingController heightController,
    required TextEditingController maxRangeController,
    required TextEditingController minRangeController,
    required TextEditingController smokerController,
    required TextEditingController yearofDiagnosisController,
  }) {
    if (state.selection != null) {
      diabetTypeController.text =
          state.selection!.diabetesType.xGetDiabetesType.xLocaleLabel;

      weightController.text = "${state.selection!.weight} kg";
      normalRangeController.text =
          "${state.selection!.rangeMin}-${state.selection!.rangeMax} mg/dl";
      heightController.text = "${state.selection!.height} cm";
      maxRangeController.text = "${state.selection!.hyper} mg/dl";
      minRangeController.text = "${state.selection!.hypo} mg/dl";
      smokerController.text = state.selection?.smoker ?? false
          ? LocaleProvider.current.smoker
          : LocaleProvider.current.non_smoker;
      yearofDiagnosisController.text = "${state.selection!.yearOfDiagnosis}";
    }
  }
  // #endregion

}
