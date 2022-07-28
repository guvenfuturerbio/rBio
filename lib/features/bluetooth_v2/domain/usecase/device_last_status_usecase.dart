import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class DeviceLastStatusUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository repository;
  DeviceLastStatusUseCase(this.repository);

  @override
  Either<BluetoothFailures, Future<DeviceStatus>> call(DeviceParams params) {
    return repository.deviceLastState(params.device);
  }
}
