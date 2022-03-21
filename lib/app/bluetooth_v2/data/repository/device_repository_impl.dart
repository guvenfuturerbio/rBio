import 'package:dartz/dartz.dart';
import 'package:mi_scale/mi_scale.dart';

import '../../core/failures.dart';
import '../../domain/entity/device_entity.dart';
import '../../domain/repository/device_repository.dart';
import '../../domain/usecase/read_status_device_usecase.dart';
import '../local/bluetooth_device_local_data_source.dart';
import '../models/device_model.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  final DeviceLocalDataSource localDataSource;
  DeviceRepositoryImpl(this.localDataSource);

  @override
  Either<Failure, Stream<List<DeviceModel>>> searchDevices(
      List<String> searchTerms) {
    try {
      final result = localDataSource.searchDevices(searchTerms);
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
  Either<Failure, Stream<MiScaleModel>> miScaleReadValues(
    DeviceEntity device,
    String field,
  ) {
    try {
      final miScaleStream =
          localDataSource.miScaleReadValues(device as DeviceModel, field);
      return Right(miScaleStream);
    } catch (e) {
      return Left(BluetoothFailure());
    }
  }
}
