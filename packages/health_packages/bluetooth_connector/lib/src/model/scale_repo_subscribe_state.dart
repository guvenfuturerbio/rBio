import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mi_scale/mi_scale.dart';

part 'scale_repo_subscribe_state.freezed.dart';

@freezed
class ScaleRepoSubscribeState with _$ScaleRepoSubscribeState {
  const factory ScaleRepoSubscribeState.showMiScalePopUp(bool deviceAlreadyPaired) = _ScaleRepoShowMiScalePopUp;
  const factory ScaleRepoSubscribeState.sendModel(MiScaleModel model) = _ScaleRepoSendModel;
  const factory ScaleRepoSubscribeState.changeState(List<int> controlPointResponse, MiScaleDevice scaleDevice) = _ScaleRepoChangeState;
}
