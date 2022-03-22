import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class BluetoothStatusUseCase extends UseCase<void, NoParams> {
  final DeviceRepository repository;
  BluetoothStatusUseCase(this.repository);

  @override
  Either<BluetoothFailures, Stream<BluetoothStatus>> call(NoParams params) {
    return repository.readBluetoothStatus();
  }
}
