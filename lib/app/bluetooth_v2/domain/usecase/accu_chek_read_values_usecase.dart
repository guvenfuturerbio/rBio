import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class AccuChekReadValuesUseCase
    extends UseCase<Stream<List<int>>, DeviceParams> {
  final DeviceRepository repository;
  AccuChekReadValuesUseCase(this.repository);

  @override
  Either<BluetoothFailures, Stream<List<int>>> call(DeviceParams params) {
    return repository.accuCheckReadValues(params.device);
  }
}
