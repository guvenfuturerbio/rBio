import 'dart:async';

import '../../../bluetooth_v2.dart';

part 'pillar_small_status.dart';

class PillarSmallCubit extends Cubit<PillarSmallStatus> {
  final PillarSmallTriggerUseCase useCase;
  final BluetoothLocalManager bluetoothLocalManager;

  PillarSmallCubit(this.useCase, this.bluetoothLocalManager)
      : super(PillarSmallStatus(device: null, status: null));

  FutureOr<void> trigger() async {
    final device = bluetoothLocalManager.anyPillarSmallConnect();
    if (device != null) {
      useCase.call(DeviceParams(device: device));
    }
  }
}
