import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class PillarSmallTriggerUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository repository;
  PillarSmallTriggerUseCase(this.repository);

  @override
  Either<BluetoothFailures, Future<bool>> call(DeviceParams params) {
    return repository.pillarSmallTrigger(params.device);
  }
}
