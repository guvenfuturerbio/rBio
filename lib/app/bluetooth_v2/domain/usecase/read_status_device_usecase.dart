import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class ReadStatusDeviceUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository repository;
  ReadStatusDeviceUseCase(this.repository);

  @override
  Either<BluetoothFailures, Stream<DeviceStatus>> call(DeviceParams params) {
    return repository.readStatus(params.device);
  }
}

enum DeviceStatus {
  disconnected,
  connecting,
  connected,
  disconnecting,
}
