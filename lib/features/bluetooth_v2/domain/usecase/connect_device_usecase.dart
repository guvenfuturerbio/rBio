import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class ConnectDeviceUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository repository;
  ConnectDeviceUseCase(this.repository);

  @override
  Either<BluetoothFailures, bool> call(DeviceParams params) {
    return repository.connect(params.device);
  }
}

class DeviceParams {
  DeviceParams({required this.device});
  final DeviceEntity device;
}
