import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

abstract class DeviceRepository {
  Either<BluetoothFailures, Stream<BluetoothStatus>> readBluetoothStatus();

  Either<BluetoothFailures, Stream<List<DeviceModel>>> searchDevices(
    DeviceType deviceType,
  );

  Either<BluetoothFailures, bool> connect(DeviceEntity device);

  Either<BluetoothFailures, bool> disconnect(DeviceEntity device);

  Either<BluetoothFailures, Stream<DeviceStatus>> readStatus(
      DeviceEntity device);

  Either<BluetoothFailures, Stream<ScaleEntity>> miScaleReadValues(
      DeviceEntity device);

  Either<BluetoothFailures, void> stopScan();

  Either<BluetoothFailures, void> miScaleStopListen();

  Either<BluetoothFailures, Future<DeviceStatus>> deviceLastState(
      DeviceEntity device);

  Either<BluetoothFailures, Future<bool>> pillarSmallTrigger(
      DeviceEntity device);

  Either<BluetoothFailures, Future<bool>> accuCheckPair(DeviceEntity device);

  Either<BluetoothFailures, Stream<List<int>>> accuCheckReadValues(
      DeviceEntity device);
}
