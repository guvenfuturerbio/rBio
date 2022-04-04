import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../core/core.dart';
import '../../../../core/utils/tz_helper.dart';
import '../../mediminder.dart';

part 'blood_glucose_reminder_add_edit_cubit.freezed.dart';
part 'blood_glucose_reminder_add_edit_state.dart';

class BloodGlucoseReminderAddEditCubit
    extends Cubit<BloodGlucoseReminderAddEditState> {
  BloodGlucoseReminderAddEditCubit(this.reminderRepository)
      : super(const BloodGlucoseReminderAddEditState.initial());
  late final ReminderRepository reminderRepository;

  // #region setInitState
  void setInitState(int? createdDate) {
    final days = ReminderHelper.instance.getSelectableDays();

    if (createdDate != null) {
      final editResult = reminderRepository.getBloodGlucoseDetailResult(
        createdDate,
        days,
      );
      if (editResult != null) {
        Future.microtask(
          () => emit(BloodGlucoseReminderAddEditState.success(editResult)),
        );
        return;
      }
    }

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

  // #region setMedicinePeriod
  void setMedicinePeriod(MedicinePeriod value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          BloodGlucoseReminderAddEditState.success(
            result.copyWith(
              medicinePeriod: value,
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
        final doseTimeList = _calculateDoseTimes(value);
        emit(
          BloodGlucoseReminderAddEditState.success(
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
            await reminderRepository.createOrEditBgReminderPlan(result);
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
        result.medicinePeriod == null ||
        result.dailyDose == null) {
      _showWarningDialog(
        LocaleProvider.current.fill_all_field,
      );
      return false;
    } else if (result.medicinePeriod == MedicinePeriod.specificDays) {
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

  // #region _calculateDoseTimes
  List<tz.TZDateTime>? _calculateDoseTimes(int dailyDose) {
    if (dailyDose == 0) return null;

    int perMinute = ((24 * 60) / dailyDose).round();
    int hour = perMinute < 60 ? perMinute : (perMinute / 60).round();
    int minute = perMinute < 60 ? 0 : perMinute - hour * 60;
    List<tz.TZDateTime> doseTimeList = [];

    doseTimeList.add(
      TZHelper.instance.currentDay(),
    );

    for (var i = 1; i < dailyDose; i++) {
      doseTimeList.add(
        doseTimeList.first.add(
          Duration(hours: i * hour, minutes: i * minute),
        ),
      );
    }
    return doseTimeList;
  }
  // #endregion
}
