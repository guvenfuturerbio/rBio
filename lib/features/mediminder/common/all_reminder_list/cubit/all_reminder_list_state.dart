part of 'all_reminder_list_cubit.dart';

@freezed
class AllReminderListState with _$AllReminderListState {
  const factory AllReminderListState.initial() = AllReminderListInitial;
  const factory AllReminderListState.loadInProgress() = AllReminderListLoadInProgress;
  const factory AllReminderListState.success(AllReminderListResult result) = AllReminderListSuccess;
  const factory AllReminderListState.failure() = AllReminderListFailure;
}

class AllReminderListResult {
  final List<AllReminderListModel> list;
  AllReminderListResult(this.list);
}
