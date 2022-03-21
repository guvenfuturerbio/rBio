import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../core/failures.dart';
import '../../core/usecases.dart';
import '../entity/device_entity.dart';
import '../repository/device_repository.dart';

class SearchDeviceUseCase extends UseCase<void, SearchParams> {
  final DeviceRepository repository;
  SearchDeviceUseCase(this.repository);

  @override
  Either<Failure, Stream<List<DeviceEntity>>> call(SearchParams params) {
    return repository.searchDevices(params.deviceType);
  }
}

class SearchParams {
  SearchParams({required this.deviceType});
  final DeviceType deviceType;
}
