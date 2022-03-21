import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/usecases.dart';
import '../repository/device_repository.dart';
import 'connect_device_usecase.dart';

class ReadStatusDeviceUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository repository;
  ReadStatusDeviceUseCase(this.repository);

  @override
  Either<Failure, Stream<DeviceStatus>> call(DeviceParams params) {
    return repository.readStatus(params.device);
  }
}

enum DeviceStatus {
  disconnected,
  connecting,
  connected,
  disconnecting,
}
