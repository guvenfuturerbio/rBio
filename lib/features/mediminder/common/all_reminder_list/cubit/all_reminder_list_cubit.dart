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
    final list = reminderRepository.getAllReminders();
    final allRelatives = reminderRepository.getAllRelatives();
    emit(
      AllReminderListState.success(
        AllReminderListResult(
          list,
          list,
          AllReminderListFilterResult(relativeList: allRelatives),
        ),
      ),
    );
  }

  Future<void> removeReminder(AllReminderListModel model) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (successResult) async {
        final allList = successResult.allList;
        final filterList = successResult.filterList;

        final isSuccess = await reminderRepository.cancelAndRemoveNotification(
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
            AllReminderListState.success(
              AllReminderListResult(
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

  void changeFilterResult(AllReminderListFilterResult filterResult) {
    final currentState = state;
    currentState.whenOrNull(
      success: (successResult) async {
        final allList = successResult.allList;
        final filterList = reminderRepository.filterList(
          allList,
          filterResult,
        );
        emit(
          AllReminderListState.success(
            AllReminderListResult(
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
