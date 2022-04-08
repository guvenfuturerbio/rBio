part of 'strip_reminder_add_edit_cubit.dart';

@freezed
class StripReminderAddEditCubitState with _$StripReminderAddEditCubitState {
  const factory StripReminderAddEditCubitState.initial() = _InitialState;
  const factory StripReminderAddEditCubitState.loadInProgress() = _LoadInProgress;
  const factory StripReminderAddEditCubitState.success(StripReminderAddEditResult result) = _SuccessState;
  const factory StripReminderAddEditCubitState.failure() = _Failure;
  const factory StripReminderAddEditCubitState.showSuccessMessage() = _ShowSuccessMessage;
}

class StripReminderAddEditResult {
  int alarmCount;
  int stripCount;
  int usedStripCount;

  StripReminderAddEditResult({
    this.alarmCount = 0,
    this.stripCount = 0,
    this.usedStripCount = 0,
  });

  StripReminderAddEditResult copyWith({
    int? alarmCount,
    int? stripCount,
    int? usedStripCount,
  }) {
    return StripReminderAddEditResult(
      alarmCount: alarmCount ?? this.alarmCount,
      stripCount: stripCount ?? this.stripCount,
      usedStripCount: usedStripCount ?? this.usedStripCount,
    );
  }
}
