import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../mediminder.dart';

part 'all_reminder_list_cubit.freezed.dart';
part 'all_reminder_list_state.dart';

class AllReminderListCubit extends Cubit<AllReminderListState> {
  AllReminderListCubit(this.reminderRepository)
      : super(const AllReminderListState.initial());
  final ReminderRepository reminderRepository;

  FutureOr<void> fetchAll() async {
    emit(const AllReminderListState.loadInProgress());
    emit(
      AllReminderListState.success(
        AllReminderListResult(reminderRepository.getAllReminders()),
      ),
    );
  }

  Future<void> removeReminder(AllReminderListModel model) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (successResult) async {
        try {
          final currentList = successResult.list;

          currentList.removeWhere(
              (item) => item.notificationId == model.notificationId);

          await reminderRepository.cancelAndRemoveNotification(
            model.remindable,
            model.notificationId,
            model.scheduledDate,
            model.createdDate,
            model.entegrationId,
          );

          emit(
            AllReminderListState.success(
              AllReminderListResult(currentList),
            ),
          );
        } catch (e) {
          LoggerUtils.instance
              .e('[AllReminderListCubit] - removeReminder() - $e');
        }
      },
    );
  }
}
