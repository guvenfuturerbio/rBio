import 'package:dartz/dartz.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../bluetooth_v2.dart';

class ReadValuesUseCase extends UseCase<void, ReadValuesParams> {
  final DeviceRepository repository;
  ReadValuesUseCase(this.repository);

  @override
  Either<BluetoothFailures, Stream<ScaleEntity>> call(ReadValuesParams params) {
    return repository.miScaleReadValues(params.device, params.field);
  }
}

class ReadValuesParams {
  ReadValuesParams({required this.device, required this.field});
  final DeviceEntity device;
  final String field;
}
