import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../model/model.dart';

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

  final _cancelToken = CancelToken();

  FutureOr<void> savedItems() async {
    try {
      for (var item in glucoseList) {
        final isSuccess = await glucoseStorage.write(
          item,
          shouldSendToServer: true,
          cancelToken: _cancelToken,
        );
        if (isSuccess) {
          emit(
            state.incrementSavedItems(
              isDone: glucoseList.length == state.savedItemsCount + 1,
            ),
          );
        }
      }
    } catch (e) {
      LoggerUtils.instance.e(
        "BloodGlucoseSaveDataDialogCubit-savedItems() : $e",
      );

      if (e is DioError) {
        if (e.type == DioErrorType.cancel) {
          emit(state.copyWith(isDone: true));
        }
      } else {
        emit(state.copyWith(isError: true));
      }
    }
  }

  void cancelOperations() {
    _cancelToken.cancel('cancelled');
    final currentState = state;
    if (currentState.savedItemsCount == currentState.totalItemsCount) {
      emit(currentState.copyWith(isDone: true));
    }
  }
}
