part of 'reminder_list_cubit.dart';

@freezed
class ReminderListState with _$ReminderListState {
  const factory ReminderListState.initial() = _InitialState;
  const factory ReminderListState.loadInProgress() = _LoadInProgressState;
  const factory ReminderListState.success(ReminderListResult result) = _SuccessState;
  const factory ReminderListState.failure() = _FailureState;
}

class ReminderListResult {
  final List<ReminderListModel> allList;
  final List<ReminderListModel> filterList;
  final ReminderListFilterResult filterResult;
  ReminderListResult(
    this.allList,
    this.filterList,
    this.filterResult,
  );
}

class ReminderListFilterResult {
  final bool isCompleted;
  final bool isNotCompleted;
  final bool isMedication;
  final bool isBloodGlucose;
  final bool isStrip;
  final bool isHbA1c;
  final List<ReminderRelativePerson> relativeList;

  ReminderListFilterResult({
    this.isCompleted = true,
    this.isNotCompleted = true,
    this.isMedication = true,
    this.isBloodGlucose = true,
    this.isStrip = true,
    this.isHbA1c = true,
    required this.relativeList,
  });

  ReminderListFilterResult copyWith({
    bool? isCompleted,
    bool? isNotCompleted,
    bool? isMedication,
    bool? isBloodGlucose,
    bool? isStrip,
    bool? isHbA1c,
    List<ReminderRelativePerson>? relativeList,
  }) {
    return ReminderListFilterResult(
      isCompleted: isCompleted ?? this.isCompleted,
      isNotCompleted: isNotCompleted ?? this.isNotCompleted,
      isMedication: isMedication ?? this.isMedication,
      isBloodGlucose: isBloodGlucose ?? this.isBloodGlucose,
      isStrip: isStrip ?? this.isStrip,
      isHbA1c: isHbA1c ?? this.isHbA1c,
      relativeList: relativeList ?? this.relativeList,
    );
  }
}

class ReminderRelativePerson {
  final int id;
  final String nameAndSurname;
  final bool isEnabled;

  ReminderRelativePerson({
    required this.id,
    required this.nameAndSurname,
    required this.isEnabled,
  });
}
