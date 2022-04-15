import 'dart:async';

import '../../../../bluetooth_v2.dart';

part 'mi_scale_status.dart';

class MiScaleStatusCubit extends Cubit<MiScaleStatus> {
  final ReadStatusDeviceUseCase useCase;
  MiScaleStatusCubit(this.useCase) : super(MiScaleStatus());

  StreamSubscription<DeviceStatus>? _streamSubs;

  @override
  Future<void> close() async {
    _streamSubs?.cancel();
    super.close();
  }

  void readStatus(DeviceEntity device) {
    _streamSubs?.cancel();
    final result = useCase.call(DeviceParams(device: device));
    result.fold((l) {
      LoggerUtils.instance.e("[DeviceStatusCubit] - Left - $l");
    }, (stream) {
      _streamSubs = stream.listen((event) {
        emit(
          MiScaleStatus(
            status: event,
            device: device,
          ),
        );
      });
    });
  }

  void resetState() {
    emit(MiScaleStatus());
  }
}
