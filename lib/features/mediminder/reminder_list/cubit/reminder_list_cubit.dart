import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
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

        final cancelSuccess =
            await reminderManager.cancelNotification(model.notificationId);
        if (!cancelSuccess) return;

        final isSuccess = await reminderManager.removeNotification(
          model.remindable,
          model.notificationId,
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

  // #region changeFilterResult
  void changeFilterResult(ReminderListFilterResult filterResult) {
    final currentState = state;
    currentState.whenOrNull(
      success: (successResult) async {
        final allList = successResult.allList;
        final filterList = _filterList(allList, filterResult);
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
  // #endregion

  // #region _filterList
  List<ReminderListModel> _filterList(
    List<ReminderListModel> allList,
    ReminderListFilterResult filterResult,
  ) {
    final relativeList = filterResult.relativeList
        .where((element) => element.isEnabled)
        .toList();
    var filterList = allList.where((element) {
      if (filterResult.isBloodGlucose) {
        if (element.remindable == Remindable.bloodGlucose) {
          return true;
        }
      }

      if (filterResult.isHbA1c) {
        if (element.remindable == Remindable.hbA1c) {
          return true;
        }
      }

      if (filterResult.isStrip) {
        if (element.remindable == Remindable.strip) {
          return true;
        }
      }

      if (filterResult.isMedication) {
        if (element.remindable == Remindable.medication) {
          return true;
        }
      }

      return false;
    }).toList();

    filterList = filterList.where((element) {
      for (var relative in relativeList) {
        if (relative.id == element.entegrationId) {
          return true;
        }
      }

      return false;
    }).toList();

    return filterList;
  }
  // #endregion
}
