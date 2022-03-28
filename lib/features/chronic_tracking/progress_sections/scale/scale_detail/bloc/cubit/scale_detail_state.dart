part of 'scale_detail_cubit.dart';

@freezed
class ScaleDetailState with _$ScaleDetailState {
  const factory ScaleDetailState.initial() = ScaleDetailInitial;
  const factory ScaleDetailState.loadInProgress() = ScaleDetailLoadInProgress;
  const factory ScaleDetailState.success(ScaleDetailSuccessResult result) = ScaleDetailSuccess;
  const factory ScaleDetailState.failure() = ScaleDetailFailure;
}

class ScaleDetailSuccessResult {
  final List<ScaleEntity> list;
  final double maximumWeight;
  final double minimumWeight;

  ScaleDetailSuccessResult({
    this.list = const [],
    this.maximumWeight = 0,
    this.minimumWeight = 0,
  });
}
