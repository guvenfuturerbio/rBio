import 'package:dartz/dartz.dart';

import '../../bluetooth_v2.dart';

class SearchDeviceUseCase extends UseCase<void, SearchParams> {
  final DeviceRepository repository;
  SearchDeviceUseCase(this.repository);

  @override
  Either<BluetoothFailures, Stream<List<DeviceEntity>>> call(
      SearchParams params) {
    return repository.searchDevices(params.deviceType);
  }
}

class SearchParams {
  SearchParams({required this.deviceType});
  final DeviceType deviceType;
}
