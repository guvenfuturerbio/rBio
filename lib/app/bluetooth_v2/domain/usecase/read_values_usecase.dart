import 'package:dartz/dartz.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../core/failures.dart';
import '../../core/usecases.dart';
import '../entity/device_entity.dart';
import '../repository/device_repository.dart';

class ReadValuesUseCase extends UseCase<void, ReadValuesParams> {
  final DeviceRepository repository;
  ReadValuesUseCase(this.repository);

  @override
  Either<Failure, Stream<ScaleEntity>> call(ReadValuesParams params) {
    return repository.miScaleReadValues(params.device, params.field);
  }
}

class ReadValuesParams {
  ReadValuesParams({required this.device, required this.field});
  final DeviceEntity device;
  final String field;
}
