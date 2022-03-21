import 'dart:async';

import '../../../bluetooth_v2.dart';

class DeviceStatusCubit extends Cubit<DeviceStatus?> {
  final ReadStatusDeviceUseCase useCase;
  DeviceStatusCubit(this.useCase) : super(null);

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
      print("[DeviceStatusCubit] - Left - $l");
    }, (stream) {
      _streamSubs = stream.listen((event) {
        emit(event);
      });
    });
  }
}
