part of 'recorder_cubit.dart';

enum RecorderStatus {
  initial,
  onRecord,
  onPause,
  stopped,
  permissionDenied,
  failure,
}

@freezed
class RecorderState with _$RecorderState {
  const factory RecorderState({
    required RecorderStatus status,
  }) = _RecorderState;
}
