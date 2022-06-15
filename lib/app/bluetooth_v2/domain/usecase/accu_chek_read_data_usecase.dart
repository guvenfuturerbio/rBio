import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class AccuChekReadDataUseCase extends UseCase<Future<bool>, DeviceParams> {
  final DeviceRepository repository;
  AccuChekReadDataUseCase(this.repository);

  @override
  Either<BluetoothFailures, Future<bool>> call(DeviceParams params) {
    return repository.accuCheckServices(params.device);
  }
}
