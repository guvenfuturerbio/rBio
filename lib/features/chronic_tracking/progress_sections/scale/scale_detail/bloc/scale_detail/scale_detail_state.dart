part of 'scale_detail_cubit.dart';

@freezed
class ScaleDetailState with _$ScaleDetailState {
  const factory ScaleDetailState.initial() = _Initial;
  const factory ScaleDetailState.loadInProgress() = _LoadInProgress;
  const factory ScaleDetailState.success(ScaleDetailSuccessResult result) = _Success;
  const factory ScaleDetailState.failure() = _Failure;
}

class ScaleDetailSuccessResult {
  final ScaleChartFilterType filterType;
  final List<ScaleEntity> list;
  final double maximumWeight;
  final double minimumWeight;

  ScaleDetailSuccessResult({
    this.filterType = ScaleChartFilterType.weekly,
    this.list = const [],
    this.maximumWeight = 0,
    this.minimumWeight = 0,
  });

  ScaleDetailSuccessResult copyWith({
    ScaleChartFilterType? filterType,
    List<ScaleEntity>? list,
    double? maximumWeight,
    double? minimumWeight,
  }) {
    return ScaleDetailSuccessResult(
      filterType: filterType ?? this.filterType,
      list: list ?? this.list,
      maximumWeight: maximumWeight ?? this.maximumWeight,
      minimumWeight: minimumWeight ?? this.minimumWeight,
    );
  }
}
