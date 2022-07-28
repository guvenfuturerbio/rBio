import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class StopScanUseCase extends UseCase<void, NoParams> {
  final DeviceRepository repository;
  StopScanUseCase(this.repository);

  @override
  Either<BluetoothFailures, void> call(NoParams params) {
    return repository.stopScan();
  }
}
