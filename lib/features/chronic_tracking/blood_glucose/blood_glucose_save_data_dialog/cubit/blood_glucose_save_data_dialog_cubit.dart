import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../core/core.dart';

part 'blood_glucose_save_data_dialog_state.dart';

class BloodGlucoseSaveDataDialogCubit
    extends Cubit<BloodGlucoseSaveDataDialogState> {
  BloodGlucoseSaveDataDialogCubit(
    this.glucoseList,
    this.glucoseStorage,
  ) : super(
          BloodGlucoseSaveDataDialogState(
            totalItemsCount: glucoseList.length,
          ),
        );
  late final List<GlucoseData> glucoseList;
  late final GlucoseStorageImpl glucoseStorage;

  FutureOr<void> savedItems() async {
    for (var item in glucoseList) {
      LoggerUtils.instance.i(state);
      final isSuccess = await glucoseStorage.write(
        item,
        shouldSendToServer: true,
      );
      if (isSuccess) {
        LoggerUtils.instance.i(
          "Success: $state ${glucoseList.length == state.savedItemsCount + 1}",
        );
        emit(
          state.incrementSavedItems(
            isDone: glucoseList.length == state.savedItemsCount + 1,
          ),
        );
      }
    }
  }
}
