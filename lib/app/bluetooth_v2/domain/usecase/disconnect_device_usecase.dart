import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/usecases.dart';
import '../repository/device_repository.dart';
import 'connect_device_usecase.dart';

class DisconnectDeviceUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository repository;
  DisconnectDeviceUseCase(this.repository);

  @override
  Either<Failure, bool> call(DeviceParams params) {
    return repository.disconnect(params.device);
  }
}
