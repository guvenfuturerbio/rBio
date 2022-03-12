import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mi_scale/mi_scale.dart';
import 'package:scale_repository/scale_repository.dart';

part 'scale_subscribe_state.freezed.dart';

@freezed
class ScaleSubscribeState with _$ScaleSubscribeState {
  const factory ScaleSubscribeState.showMiScalePopUp(bool deviceAlreadyPaired) = _ScaleShowMiScalePopUp;
  const factory ScaleSubscribeState.sendEntity(ScaleEntity model) = _ScaleSendEntity;
  const factory ScaleSubscribeState.changeState(List<int> controlPointResponse, MiScaleDevice scaleDevice) = _ScaleChangeState;
}
