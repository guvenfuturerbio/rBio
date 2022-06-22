part of 'blood_glucose_save_data_dialog_cubit.dart';

class BloodGlucoseSaveDataDialogState {
  final int totalItemsCount;
  final int savedItemsCount;
  final bool isDone;

  const BloodGlucoseSaveDataDialogState({
    this.totalItemsCount = 0,
    this.savedItemsCount = 0,
    this.isDone = false,
  });

  BloodGlucoseSaveDataDialogState incrementSavedItems({
    bool? isDone,
  }) {
    return BloodGlucoseSaveDataDialogState(
      totalItemsCount: totalItemsCount,
      savedItemsCount: savedItemsCount + 1,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BloodGlucoseSaveDataDialogState &&
        other.totalItemsCount == totalItemsCount &&
        other.savedItemsCount == savedItemsCount &&
        other.isDone == isDone;
  }

  @override
  int get hashCode =>
      totalItemsCount.hashCode ^ savedItemsCount.hashCode ^ isDone.hashCode;

  @override
  String toString() =>
      'BloodGlucoseSaveDataDialogState(totalItemsCount: $totalItemsCount, savedItemsCount: $savedItemsCount, isDone: $isDone)';
}
