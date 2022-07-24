part of 'mi_scale_ops_cubit.dart';

@freezed
class MiScaleOpsState with _$MiScaleOpsState {
  const factory MiScaleOpsState.initial() = MiScaleOpsInitialState;
  const factory MiScaleOpsState.showLoading(ScaleEntity scaleEntity) = MiScaleOpsShowLoadingState;
  const factory MiScaleOpsState.dismissLoading() = MiScaleOpsDismissLoadingState;
  const factory MiScaleOpsState.showScalePopup(ScaleEntity scaleEntity) = MiScaleOpsShowScalePopupState;
}
