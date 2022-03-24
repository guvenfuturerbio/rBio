part of 'mi_scale_cubit.dart';

@freezed
class MiScaleState with _$MiScaleState {
  const factory MiScaleState.initial() = MiScaleInitialState;
  const factory MiScaleState.showLoading(ScaleEntity scaleEntity) = MiScaleShowLoadingState;
  const factory MiScaleState.dismissLoading() = MiScaleDismissLoadingState;
  const factory MiScaleState.showScalePopup(ScaleEntity scaleEntity) = MiScaleShowScalePopupState;
}
