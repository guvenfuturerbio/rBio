import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class AccuChekPairUseCase extends UseCase<Future<bool>, DeviceParams> {
  final DeviceRepository repository;
  AccuChekPairUseCase(this.repository);

  @override
  Either<BluetoothFailures, Future<bool>> call(DeviceParams params) {
    return repository.accuCheckPair(params.device);
  }
}
