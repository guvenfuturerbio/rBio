import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../../../../../../core/core.dart';
import '../../scale_detail.dart';

part 'scale_detail_cubit.freezed.dart';
part 'scale_detail_state.dart';

class ScaleDetailCubit extends Cubit<ScaleDetailState> {
  ScaleDetailCubit() : super(const ScaleDetailState.initial());

  FutureOr<void> fetchAll() async {
    final heightCheck = Utils.instance.checkUserHeight();
    if (!heightCheck) return;

    emit(const ScaleDetailState.loadInProgress());
    try {
      final result = getIt<ScaleRepository>().readLocalScaleData(
        Utils.instance.getAge(),
        Utils.instance.getGender(),
        Utils.instance.getHeight()!,
      );
      final initState = _getResult(result, ScaleChartFilterType.weekly);
      emit(ScaleDetailState.success(initState));
    } catch (e) {
      emit(const ScaleDetailState.failure());
    }

    // BlocConsumer'un listener'ı tetiklenmesi için.
    Future.microtask(
      () {
        changeFilterType(ScaleChartFilterType.weekly);
      },
    );
  }

  FutureOr<void> deleteItem(ScaleEntity entity) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) async {
        final currentList = result.allList;
        final item = currentList.firstWhereOrNull((element) =>
            element.dateTime.millisecondsSinceEpoch ==
            entity.dateTime.millisecondsSinceEpoch);
        if (item != null) {
          await getIt<ScaleRepository>().deleteScaleMeasurement(
            DeleteScaleMasurementBody(
              entegrationId: entity.entegrationId,
              measurementId: entity.measurementId,
            ),
            entity.dateTime,
          );
          currentList.remove(entity);
          emit(
            ScaleDetailState.success(
              _getResult(
                currentList,
                result.filterType,
              ),
            ),
          );
        }
      },
    );
  }

  void changeFilterType(ScaleChartFilterType value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          ScaleDetailState.success(
            _getResult(
              result.allList,
              value,
            ),
          ),
        );
      },
    );
  }

  ScaleDetailSuccessResult _getResult(
    List<ScaleEntity> result,
    ScaleChartFilterType filterType,
  ) {
    if (result.isEmpty) {
      return ScaleDetailSuccessResult();
    } else {
      var list = result;
      list = list.where((element) {
        final date = element.dateTime;
        switch (filterType) {
          case ScaleChartFilterType.monthly:
            return now_1m().isBefore(date);

          case ScaleChartFilterType.sixMonths:
            return now_6m().isBefore(date);

          case ScaleChartFilterType.yearly:
            return now_1y().isBefore(date);

          case ScaleChartFilterType.weekly:
          default:
            return now_1w().isBefore(date);
        }
      }).toList();

      list.sort((a, b) {
        return a.dateTime.isAfter(b.dateTime) ? -1 : 1;
      });

      final maximumWeight = (result
          .reduce((a, b) => (a.weight ?? 0) > (b.weight ?? 0) ? a : b)).weight;
      final minimumWeight = (result
          .reduce((a, b) => (a.weight ?? 0) < (b.weight ?? 0) ? a : b)).weight;

      return ScaleDetailSuccessResult(
        filterType: filterType,
        allList: result,
        filterList: list,
        maximumWeight: (maximumWeight ?? 0) + 1,
        minimumWeight: (minimumWeight ?? 0) - 0.3,
      );
    }
  }

  DateTime now = DateTime.now();
  DateTime now_1w() => now.subtract(const Duration(days: 7));
  DateTime now_1m() => DateTime(now.year, now.month - 1, now.day);
  DateTime now_6m() => DateTime(now.year, now.month - 6, now.day);
  DateTime now_1y() => DateTime(now.year - 1, now.month, now.day);
}
