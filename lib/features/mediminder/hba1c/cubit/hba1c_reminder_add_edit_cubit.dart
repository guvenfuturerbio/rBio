import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';

part 'hba1c_reminder_add_edit_cubit.freezed.dart';
part 'hba1c_reminder_add_edit_state.dart';

class Hba1cReminderAddEditCubit extends Cubit<Hba1cReminderAddEditState> {
  Hba1cReminderAddEditCubit(this.reminderRepository)
      : super(const Hba1cReminderAddEditState.initial());
  late final ReminderRepository reminderRepository;

  void setInitState(
    int? notificationId,
  ) {
    if (notificationId != null) {
      final editResult =
          reminderRepository.getHba1CDetailResult(notificationId);
      if (editResult != null) {
        emit(Hba1cReminderAddEditState.success(editResult));
        return;
      }
    }

    emit(
      Hba1cReminderAddEditState.success(
        Hba1cReminderAddEditResult(isCreated: true),
      ),
    );
  }

  void setLastTestDate(DateTime date) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          Hba1cReminderAddEditState.success(
            result.copyWith(
              lastTestDate: date.toString(),
              scheduledDate: (DateTime.parse(date.toString())
                          .add(const Duration(days: 90)))
                      .isBefore(DateTime.now().add(const Duration(minutes: 5)))
                  ? DateTime.now().add(const Duration(minutes: 5)).toString()
                  : (DateTime.parse(date.toString())
                          .add(const Duration(days: 90)))
                      .toString(),
            ),
          ),
        );
      },
    );
  }

  void setLastTestValue(double testValue) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          Hba1cReminderAddEditState.success(
            result.copyWith(
              lastTestValue: testValue,
            ),
          ),
        );
      },
    );
  }

  void setScheduledDate(DateTime date) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          Hba1cReminderAddEditState.success(
            result.copyWith(
              scheduledDate: date.toString(),
            ),
          ),
        );
      },
    );
  }

  void setScheduledHour(TimeOfDay timeOfDay) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          Hba1cReminderAddEditState.success(
            result.copyWith(
              scheduledHour: timeOfDay,
            ),
          ),
        );
      },
    );
  }

  void setState() {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(Hba1cReminderAddEditState.success(result));
      },
    );
  }

  Future<void> createNotification(BuildContext context) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        final isValid = _checkValidation(context, result);
        if (!isValid) return;

        final isSuccess =
            await reminderRepository.createOrEditHba1CReminderPlan(result);
        if (isSuccess) {
          emit(const Hba1cReminderAddEditState.openListScreen());
        }
      },
    );
  }

  bool _checkValidation(
    BuildContext context,
    Hba1cReminderAddEditResult result,
  ) {
    if ((result.scheduledDate == null) ||
        (result.scheduledHour == null) ||
        (result.lastTestDate == null) ||
        (result.lastTestValue == null)) {
      _showWarningDialog(LocaleProvider.current.fill_all_field);
      return false;
    }

    final scheduledDate = DateTime.parse(result.scheduledDate!)
      ..add(Duration(hours: result.scheduledHour!.hour))
      ..add(Duration(minutes: result.scheduledHour!.minute));
    final now = DateTime.now();
    if (scheduledDate.isBefore(now)) {
      _showWarningDialog(LocaleProvider.current.reminders_past_create_message);
      return false;
    }

    return true;
  }

  // #region _showWarningDialog
  void _showWarningDialog(String description) {
    final currentState = state;
    emit(Hba1cReminderAddEditState.showWarningDialog(description));
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        emit(currentState);
      },
    );
  }
  // #endregion
}
