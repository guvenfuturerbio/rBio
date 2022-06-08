part of 'patient_scale_detail_cubit.dart';

@freezed
class ScaleDetailState with _$ScaleDetailState {
  const factory ScaleDetailState.initial() = _Initial;
  const factory ScaleDetailState.loadInProgress() = _LoadInProgress;
  const factory ScaleDetailState.success(ScaleDetailSuccessResult result) = _Success;
  const factory ScaleDetailState.failure() = _Failure;
}

class ScaleDetailSuccessResult {
  final ScaleChartFilterType filterType;
  final List<ScaleEntity> allList;
  final List<ScaleEntity> filterList;
  final double maximumWeight;
  final double minimumWeight;

  ScaleDetailSuccessResult({
    this.filterType = ScaleChartFilterType.weekly,
    this.allList = const [],
    this.filterList = const [],
    this.maximumWeight = 0,
    this.minimumWeight = 0,
  });

  ScaleDetailSuccessResult copyWith({
    ScaleChartFilterType? filterType,
    List<ScaleEntity>? allList,
    List<ScaleEntity>? filterList,
    double? maximumWeight,
    double? minimumWeight,
  }) {
    return ScaleDetailSuccessResult(
      filterType: filterType ?? this.filterType,
      allList: allList ?? this.allList,
      filterList: filterList ?? this.filterList,
      maximumWeight: maximumWeight ?? this.maximumWeight,
      minimumWeight: minimumWeight ?? this.minimumWeight,
    );
  }
}
