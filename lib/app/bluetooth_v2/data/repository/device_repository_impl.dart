import 'package:dartz/dartz.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  final DeviceLocalDataSource localDataSource;
  DeviceRepositoryImpl(this.localDataSource);

  @override
  Either<Failure, Stream<List<DeviceModel>>> searchDevices(
      DeviceType deviceType) {
    try {
      final result = localDataSource.searchDevices(deviceType);
      return Right(result);
    } catch (e) {
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<Failure, void> stopScan() {
    try {
      localDataSource.stopScan();
      return const Right(null);
    } catch (e) {
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<Failure, bool> connect(DeviceEntity device) {
    try {
      final result = localDataSource.connect(device as DeviceModel);
      return Right(result);
    } catch (e) {
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<Failure, bool> disconnect(DeviceEntity device) {
    try {
      final result = localDataSource.disconnect(device as DeviceModel);
      return Right(result);
    } catch (e) {
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<Failure, Stream<DeviceStatus>> readStatus(DeviceEntity device) {
    try {
      final result = localDataSource.readStatus(device as DeviceModel);
      return Right(result);
    } catch (e) {
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<Failure, Stream<ScaleEntity>> miScaleReadValues(
    DeviceEntity device,
    String field,
  ) {
    try {
      final miScaleStream =
          localDataSource.miScaleReadValues(device as DeviceModel, field);
      return Right(
        miScaleStream.map(
          (event) => event.xGetEntityWithCalculate(
            Utils.instance.getAge(),
            Utils.instance.getHeight(),
            Utils.instance.getGender(),
          ),
        ),
      );
    } catch (e) {
      return Left(BluetoothFailure());
    }
  }
}
