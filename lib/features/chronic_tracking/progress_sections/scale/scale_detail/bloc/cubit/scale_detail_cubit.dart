import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../../../../../../core/core.dart';

part 'scale_detail_cubit.freezed.dart';
part 'scale_detail_state.dart';

class ScaleDetailCubit extends Cubit<ScaleDetailState> {
  ScaleDetailCubit() : super(const ScaleDetailState.initial());

  FutureOr<void> fetchAll() async {
    emit(const ScaleDetailState.loadInProgress());
    try {
      final result = getIt<ScaleRepository>().readLocalScaleData(
        Utils.instance.getAge(),
        Utils.instance.getGender(),
        Utils.instance.getHeight(),
      );
      emit(ScaleDetailState.success(_getResult(result)));
    } catch (e) {
      emit(const ScaleDetailState.failure());
    }
  }

  FutureOr<void> deleteItem(
    ScaleEntity entity,
    ScaleDetailSuccess successState,
  ) async {
    successState.whenOrNull(
      success: (result) {
        final currentList = result.list;
        final item = currentList.firstWhereOrNull((element) =>
            element.dateTime.millisecondsSinceEpoch ==
            entity.dateTime.millisecondsSinceEpoch);
        if (item != null) {
          currentList.remove(entity);
          emit(ScaleDetailState.success(_getResult(currentList)));
        }
      },
    );
  }

  ScaleDetailSuccessResult _getResult(List<ScaleEntity> result) {
    if (result.isEmpty) {
      return ScaleDetailSuccessResult();
    } else {
      final list = result;
      list.sort((a, b) {
        return a.dateTime.isAfter(b.dateTime) ? -1 : 1;
      });
      final maximumWeight = (result
          .reduce((a, b) => (a.weight ?? 0) > (b.weight ?? 0) ? a : b)).weight;
      final minimumWeight = (result
          .reduce((a, b) => (a.weight ?? 0) < (b.weight ?? 0) ? a : b)).weight;
      return ScaleDetailSuccessResult(
        list: list,
        maximumWeight: (maximumWeight ?? 0) + 1,
        minimumWeight: (minimumWeight ?? 0) - 0.3,
      );
    }
  }
}
