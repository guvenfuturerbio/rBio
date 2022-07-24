import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class DisconnectDeviceUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository repository;
  DisconnectDeviceUseCase(this.repository);

  @override
  Either<BluetoothFailures, bool> call(DeviceParams params) {
    return repository.disconnect(params.device);
  }
}
