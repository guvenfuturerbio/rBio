import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/usecases.dart';
import '../entity/device_entity.dart';
import '../repository/device_repository.dart';

class ConnectDeviceUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository repository;
  ConnectDeviceUseCase(this.repository);

  @override
  Either<Failure, bool> call(DeviceParams params) {
    return repository.connect(params.device);
  }
}

class DeviceParams {
  DeviceParams({required this.device});
  final DeviceEntity device;
}
