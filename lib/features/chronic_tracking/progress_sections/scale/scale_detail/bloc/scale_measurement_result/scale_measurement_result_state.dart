part of 'scale_measurement_result_cubit.dart';

@freezed
class ScaleMeasurementResultState with _$ScaleMeasurementResultState {
  const factory ScaleMeasurementResultState.initial(ScaleEntity scaleEntity) = _Initial;
  const factory ScaleMeasurementResultState.loadInProgress() = _LoadInProgress;
  const factory ScaleMeasurementResultState.failure() = _Failure;
  const factory ScaleMeasurementResultState.successAdded() = _SuccessAdded;
}
