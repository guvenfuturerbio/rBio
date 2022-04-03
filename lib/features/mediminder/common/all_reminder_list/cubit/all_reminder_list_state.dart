part of 'all_reminder_list_cubit.dart';

@freezed
class AllReminderListState with _$AllReminderListState {
  const factory AllReminderListState.initial() = AllReminderListInitial;
  const factory AllReminderListState.loadInProgress() =
      AllReminderListLoadInProgress;
  const factory AllReminderListState.success(AllReminderListResult result) =
      AllReminderListSuccess;
  const factory AllReminderListState.failure() = AllReminderListFailure;
}

class AllReminderListResult {
  final List<AllReminderListModel> allList;
  final List<AllReminderListModel> filterList;
  final AllReminderListFilterResult filterResult;
  AllReminderListResult(
    this.allList,
    this.filterList,
    this.filterResult,
  );
}

class AllReminderListFilterResult {
  final bool isCompleted;
  final bool isNotCompleted;
  final bool isMedication;
  final bool isBloodGlucose;
  final bool isStrip;
  final bool isHbA1c;
  final List<AllReminderRelativePerson> relativeList;

  AllReminderListFilterResult({
    this.isCompleted = true,
    this.isNotCompleted = true,
    this.isMedication = true,
    this.isBloodGlucose = true,
    this.isStrip = true,
    this.isHbA1c = true,
    required this.relativeList,
  });

  AllReminderListFilterResult copyWith({
    bool? isCompleted,
    bool? isNotCompleted,
    bool? isMedication,
    bool? isBloodGlucose,
    bool? isStrip,
    bool? isHbA1c,
    List<AllReminderRelativePerson>? relativeList,
  }) {
    return AllReminderListFilterResult(
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

class AllReminderRelativePerson {
  final int id;
  final String nameAndSurname;
  final bool isEnabled;

  AllReminderRelativePerson({
    required this.id,
    required this.nameAndSurname,
    required this.isEnabled,
  });
}
