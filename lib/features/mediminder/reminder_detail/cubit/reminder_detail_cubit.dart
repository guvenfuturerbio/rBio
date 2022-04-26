import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../core/utils/tz_helper.dart';
import '../../mediminder.dart';

part 'reminder_detail_cubit.freezed.dart';
part 'reminder_detail_state.dart';

class ReminderDetailCubit extends Cubit<ReminderDetailState> {
  ReminderDetailCubit(
    this.createdDate,
    this.notificationId,
    this.remindable,
    this.reminderManager,
  ) : super(const ReminderDetailState.initial());
  final int createdDate;
  final int notificationId;
  final Remindable remindable;
  final ReminderManager reminderManager;

  FutureOr<void> getDetail() {
    final result = reminderManager.getReminderDetailResult(
      remindable,
      createdDate,
      notificationId,
    );
    if (result != null) {
      emit(ReminderDetailState.success(result));
    }
  }

  Future<void> removeReminder(ReminderDetailResult result) async {
    try {
      await reminderManager.cancelAndAllRemoveNotification(
        remindable,
        createdDate,
      );
      emit(const ReminderDetailState.openListScreen());
    } catch (e) {
      LoggerUtils.instance.e('[ReminderDetailCubit] - removeReminder() | $e');
    }
  }

  FutureOr<void> changeTimeStatus(ReminderChangeTimeStatus model) async {
    if (remindable == Remindable.bloodGlucose &&
        model.bloodGlucoseModel != null) {
      final scheduledDate = _getScheduledDate(
        model.bloodGlucoseModel!.reminderPeriod!,
        model.bloodGlucoseModel!.dayIndex,
        model.dateTime,
      );

      if (scheduledDate != null) {
        await reminderManager.changeTimeStatus(
          remindable,
          model.notificationId,
          model.value,
          scheduledDate,
          model.bloodGlucoseModel!.reminderPeriod!,
          "",
        );
      }
    } else {
      final scheduledDate = _getScheduledDate(
        model.medicationModel!.reminderPeriod!,
        model.medicationModel!.dayIndex,
        model.dateTime,
      );

      if (scheduledDate != null) {
        await reminderManager.changeTimeStatus(
          remindable,
          model.notificationId,
          model.value,
          scheduledDate,
          model.medicationModel!.reminderPeriod!,
          model.medicationModel!.drugName ?? '',
        );
      }
    }

    await getDetail();
  }

  tz.TZDateTime? _getScheduledDate(
    ReminderPeriod? reminderPeriod,
    int? dayIndex,
    tz.TZDateTime dateTime,
  ) {
    tz.TZDateTime? scheduledDate;
    if (reminderPeriod == ReminderPeriod.everyDay) {
      scheduledDate = TZHelper.instance.nextSameTimeAfterDay(dateTime);
    } else if (reminderPeriod == ReminderPeriod.specificDays) {
      scheduledDate = TZHelper.instance.nextInstanceOfDay(dayIndex!, dateTime);
    }
    return scheduledDate;
  }

  Future<void> changePillarSmallAddMedicine(
    int createdDate,
    int drugCount,
  ) async {
    final result = await reminderManager.changePillarSmallMedicineCount(
        createdDate, drugCount);
    if (result) {
      emit(const ReminderDetailState.initial());
      await getDetail();
    }
  }
}
