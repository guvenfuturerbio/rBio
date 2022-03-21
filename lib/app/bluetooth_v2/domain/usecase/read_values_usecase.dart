import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/usecases.dart';
import '../entity/device_entity.dart';
import '../repository/device_repository.dart';
import 'package:mi_scale/mi_scale.dart';

class ReadValuesUseCase extends UseCase<void, ReadValuesParams> {
  final DeviceRepository repository;
  ReadValuesUseCase(this.repository);

  @override
  Either<Failure, Stream<MiScaleModel>> call(ReadValuesParams params) {
    return repository.miScaleReadValues(params.device, params.field);
  }
}

class ReadValuesParams {
  ReadValuesParams({required this.device, required this.field});
  final DeviceEntity device;
  final String field;
}
