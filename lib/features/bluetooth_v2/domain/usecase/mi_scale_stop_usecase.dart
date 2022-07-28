import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class MiScaleStopUseCase extends UseCase<void, NoParams> {
  final DeviceRepository repository;
  MiScaleStopUseCase(this.repository);

  @override
  Either<BluetoothFailures, void> call(NoParams params) {
    return repository.miScaleStopListen();
  }
}
