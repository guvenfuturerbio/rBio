import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

abstract class DeviceRepository {
  Either<Failure, Stream<List<DeviceModel>>> searchDevices(
    DeviceType deviceType,
  );

  Either<Failure, bool> connect(DeviceEntity device);

  Either<Failure, bool> disconnect(DeviceEntity device);

  Either<Failure, Stream<DeviceStatus>> readStatus(DeviceEntity device);

  Either<Failure, Stream<MiScaleModel>> miScaleReadValues(
      DeviceEntity device, String field);

  Either<Failure, void> stopScan();
}
