import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scale_repository/scale_repository.dart';

part 'mi_scale_state.freezed.dart';

@freezed
class MiScaleReadValuesState with _$MiScaleReadValuesState {
  const factory MiScaleReadValuesState.initial() = MiScaleReadValuesInitial;
  const factory MiScaleReadValuesState.showLoading(ScaleEntity scaleEntity) = MiScaleReadValuesShowLoading;
  const factory MiScaleReadValuesState.dismissLoading() = MiScaleReadValuesDismissLoading;
  const factory MiScaleReadValuesState.showScalePopup(ScaleEntity scaleEntity) = MiScaleReadValuesShowScalePopup;
}
