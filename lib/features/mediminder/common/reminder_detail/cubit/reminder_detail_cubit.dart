import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../mediminder.dart';

part 'reminder_detail_cubit.freezed.dart';
part 'reminder_detail_state.dart';

class ReminderDetailCubit extends Cubit<ReminderDetailState> {
  ReminderDetailCubit(
    this.notificationId,
    this.remindable,
    this.reminderRepository,
  ) : super(const ReminderDetailState.initial());
  final int notificationId;
  final Remindable remindable;
  final ReminderRepository reminderRepository;

  FutureOr<void> getDetail() {
    final result = reminderRepository.getReminderDetailResult(
      remindable,
      notificationId,
    );
    if (result != null) {
      emit(ReminderDetailState.success(result));
    }
  }

  Future<void> removeReminder(ReminderDetailResult result) async {
    try {
      result.when(
        hba1C: (model) async {
          await _cancelAndRemoveNotification(model);
        },
        bloodGlucose: (model) async {
          await _cancelAndRemoveNotification(model);
        },
        medication: (model) async {
          await _cancelAndRemoveNotification(model);
        },
      );
      emit(const ReminderDetailState.openListScreen());
    } catch (e) {
      LoggerUtils.instance.e('[ReminderDetailCubit] - removeReminder() | $e');
    }
  }

  FutureOr<void> _cancelAndRemoveNotification(ReminderEntity entity) async {
    await reminderRepository.cancelAndRemoveNotification(
      entity.remindable,
      entity.notificationId,
      entity.scheduledDate,
      entity.createdDate,
      entity.entegrationId,
    );
  }
}
