import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../core/core.dart';
import '../../mediminder.dart';

part 'blood_glucose_reminder_add_edit_cubit.freezed.dart';
part 'blood_glucose_reminder_add_edit_state.dart';

class BloodGlucoseReminderAddEditCubit
    extends Cubit<BloodGlucoseReminderAddEditState> {
  BloodGlucoseReminderAddEditCubit(this.reminderManager)
      : super(const BloodGlucoseReminderAddEditState.initial());
  late final ReminderManager reminderManager;

  // #region setInitState
  void setInitState(int? createdDate) {
    if (createdDate != null) {
      final editResult = reminderManager.getBloodGlucoseDetailResult(
        createdDate,
      );
      if (editResult != null) {
        Future.microtask(
          () => emit(BloodGlucoseReminderAddEditState.success(editResult)),
        );
        return;
      }
    }

    final days = reminderManager.getSelectableDays();
    Future.microtask(
      () => emit(
        BloodGlucoseReminderAddEditState.success(
          BloodGlucoseReminderAddEditResult(
            isCreated: true,
            days: days,
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region setUsageType
  void setUsageType(UsageType value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          BloodGlucoseReminderAddEditState.success(
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
          BloodGlucoseReminderAddEditState.success(
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
          BloodGlucoseReminderAddEditState.success(
            result.copyWith(
              dailyDose: value,
              doseTimeStatus: List.filled(value, true),
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
          BloodGlucoseReminderAddEditState.success(result.resetDailDose()),
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
          BloodGlucoseReminderAddEditState.success(
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
          BloodGlucoseReminderAddEditState.success(
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
            await reminderManager.createOrEditBgReminderPlan(result);
        if (isSuccess) {
          emit(const BloodGlucoseReminderAddEditState.openListScreen());
        }
      },
    );
  }
  // #endregion

  // #region _checkValidation
  bool _checkValidation(BloodGlucoseReminderAddEditResult result) {
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
    }

    return true;
  }
  // #endregion

  // #region _showWarningDialog
  void _showWarningDialog(String description) {
    final currentState = state;
    emit(BloodGlucoseReminderAddEditState.showWarningDialog(description));
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        emit(currentState);
      },
    );
  }
  // #endregion
}
