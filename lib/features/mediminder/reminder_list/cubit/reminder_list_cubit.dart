import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../mediminder.dart';

part 'reminder_list_cubit.freezed.dart';
part 'reminder_list_state.dart';

class ReminderListCubit extends Cubit<ReminderListState> {
  ReminderListCubit(this.reminderManager)
      : super(const ReminderListState.initial());
  final ReminderManager reminderManager;

  FutureOr<void> fetchAll() async {
    emit(const ReminderListState.loadInProgress());
    final list = reminderManager.getAllReminders();
    final allRelatives = reminderManager.getAllRelatives();
    emit(
      ReminderListState.success(
        ReminderListResult(
          list,
          list,
          ReminderListFilterResult(relativeList: allRelatives),
        ),
      ),
    );
  }

  Future<void> removeReminder(ReminderListModel model) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (successResult) async {
        final allList = successResult.allList;
        final filterList = successResult.filterList;

        final isSuccess = await reminderManager.cancelAndRemoveNotification(
          model.remindable,
          model.notificationId,
          model.scheduledDate,
          model.createdDate,
          model.entegrationId,
        );
        if (isSuccess) {
          allList.removeWhere(
            (item) => item.notificationId == model.notificationId,
          );
          filterList.removeWhere(
            (item) => item.notificationId == model.notificationId,
          );

          emit(
            ReminderListState.success(
              ReminderListResult(
                allList,
                filterList,
                successResult.filterResult,
              ),
            ),
          );
        }
      },
    );
  }

  void changeFilterResult(ReminderListFilterResult filterResult) {
    final currentState = state;
    currentState.whenOrNull(
      success: (successResult) async {
        final allList = successResult.allList;
        final filterList = reminderManager.filterList(
          allList,
          filterResult,
        );
        emit(
          ReminderListState.success(
            ReminderListResult(
              allList,
              filterList,
              filterResult,
            ),
          ),
        );
      },
    );
  }
}
