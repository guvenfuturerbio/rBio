import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../generated/l10n.dart';
import '../../mediminder.dart';

part 'medication_reminder_add_edit_state.dart';
part 'medication_reminder_add_edit_cubit.freezed.dart';

class MedicationReminderAddEditCubit
    extends Cubit<MedicationReminderAddEditState> {
  MedicationReminderAddEditCubit(this.reminderManager)
      : super(const MedicationReminderAddEditState.initial());
  late final ReminderManager reminderManager;

  // #region setInitState
  void setInitState(int? createdDate) {
    if (createdDate != null) {
      final editResult = reminderManager.getMedicationDetailResult(
        createdDate,
      );
      if (editResult != null) {
        Future.microtask(
          () => emit(MedicationReminderAddEditState.success(editResult)),
        );
        return;
      }
    }

    final days = reminderManager.getSelectableDays();
    Future.microtask(
      () => emit(
        MedicationReminderAddEditState.success(
          MedicationReminderAddEditResult(
            isCreated: true,
            days: days,
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region setDrugTracking
  void setDrugTracking(DrugTracking value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          MedicationReminderAddEditState.success(
            result.copyWith(
              drugTracking: value,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region setDrugName
  void setDrugName(String value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          MedicationReminderAddEditState.success(
            result.copyWith(
              drugName: value,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region setRemainingCountNotification
  void setRemainingCountNotification(int? value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        if (value == null) {
          emit(
            MedicationReminderAddEditState.success(
                result.resetRemainingCountNotification()),
          );
        } else {
          emit(
            MedicationReminderAddEditState.success(
              result.copyWith(
                remainingCountNotification: value,
              ),
            ),
          );
        }
      },
    );
  }
  // #endregion

  // #region setDrugCount
  void setDrugCount(int? value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        if (value == null) {
          emit(
            MedicationReminderAddEditState.success(
              result.resetDrugCount(),
            ),
          );
        } else {
          emit(
            MedicationReminderAddEditState.success(
              result.copyWith(
                drugCount: value,
              ),
            ),
          );
        }
      },
    );
  }
  // #endregion

  // #region setUsageType
  void setUsageType(UsageType value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          MedicationReminderAddEditState.success(
            result.copyWith(
              usageType: value,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region setReminderPeriod
  void setReminderPeriod(ReminderPeriod value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          MedicationReminderAddEditState.success(
            result.copyWith(
              reminderPeriod: value,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region setDailyDose
  Future<void> setDailyDose(int value) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        final doseTimeList = reminderManager.calculateDoseTimes(value);
        emit(
          MedicationReminderAddEditState.success(
            result.copyWith(
              dailyDose: value,
              doseTimes: doseTimeList,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region resetDailyDose
  Future<void> resetDailyDose() async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        emit(
          MedicationReminderAddEditState.success(result.resetDailDose()),
        );
      },
    );
  }
  // #endregion

  // #region setOneTimeDose
  void setOneTimeDose(int value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          MedicationReminderAddEditState.success(
            result.copyWith(
              oneTimeDose: value,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region setDoseTimes
  void setDoseTimes(TimeOfDay timeOfDay, int index) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        final doseTimes = result.doseTimes;
        doseTimes[index] = tz.TZDateTime(
          tz.local,
          doseTimes[index].year,
          doseTimes[index].month,
          doseTimes[index].day,
          timeOfDay.hour,
          timeOfDay.minute,
        );
        emit(
          MedicationReminderAddEditState.success(
            result.copyWith(
              doseTimes: doseTimes,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region selectedDayToggle
  Future<void> selectedDayToggle(int index) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        final days = result.days;
        days[index].selected = !days[index].selected;
        emit(
          MedicationReminderAddEditState.success(
            result.copyWith(
              days: days,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region createReminderPlan
  Future<void> createReminderPlan() async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        final isValid = _checkValidation(result);
        if (!isValid) return;

        final isSuccess =
            await reminderManager.createOrEditMedicationReminderPlan(result);
        if (isSuccess) {
          emit(const MedicationReminderAddEditState.openListScreen());
        }
      },
    );
  }
  // #endregion

  // #region _checkValidation
  bool _checkValidation(MedicationReminderAddEditResult result) {
    if (result.usageType == null ||
        result.reminderPeriod == null ||
        result.dailyDose == null) {
      _showWarningDialog(
        LocaleProvider.current.fill_all_field,
      );
      return false;
    } else if (result.reminderPeriod == ReminderPeriod.specificDays) {
      // Belirli Günler seçiminde gün kontrolü
      final anyDateSelected = result.days.any((item) => item.selected);
      if (!anyDateSelected) {
        _showWarningDialog(
          LocaleProvider.current.error_empty_specific_day_selected,
        );
        return false;
      }
    } else if (result.drugTracking == DrugTracking.pillarSmall) {
      if (result.drugCount == null ||
          result.remainingCountNotification == null) {
        _showWarningDialog(
          LocaleProvider.current.fill_all_field,
        );
        return false;
      }
    }

    return true;
  }
  // #endregion

  // #region _showWarningDialog
  void _showWarningDialog(String description) {
    final currentState = state;
    emit(MedicationReminderAddEditState.showWarningDialog(description));
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        emit(currentState);
      },
    );
  }
  // #endregion
}
