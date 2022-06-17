import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  final DeviceLocalDataSource localDataSource;
  DeviceRepositoryImpl(this.localDataSource);

  @override
  Either<BluetoothFailures, Stream<BluetoothStatus>> readBluetoothStatus() {
    try {
      final result = localDataSource.readBluetoothStatus();
      return Right(result.map((event) => event.xGetStatus));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, Stream<List<DeviceModel>>> searchDevices(
      DeviceType deviceType) {
    try {
      final result = localDataSource.searchDevices(deviceType);
      return Right(result);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, void> stopScan() {
    try {
      localDataSource.stopScan();
      return const Right(null);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, bool> connect(DeviceEntity device) {
    try {
      final result = localDataSource.connect(device.xGetModel);
      return Right(result);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, bool> disconnect(DeviceEntity device) {
    try {
      final result = localDataSource.disconnect(device.xGetModel);
      return Right(result);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, Stream<DeviceStatus>> readStatus(
      DeviceEntity device) {
    try {
      final result = localDataSource.readStatus(device.xGetModel);
      return Right(result);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, Stream<ScaleEntity>> miScaleReadValues(
    DeviceEntity device,
  ) {
    try {
      final miScaleStream = localDataSource.miScaleReadValues(device.xGetModel);
      return Right(
        miScaleStream.map(
          (event) => event.xGetEntityWithCalculate(
            Utils.instance.getAge(),
            Utils.instance.getHeight()!,
            Utils.instance.getGender(),
          ),
        ),
      );
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, void> miScaleStopListen() {
    try {
      localDataSource.miScaleStopListen();
      return const Right(null);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, Future<DeviceStatus>> deviceLastState(
    DeviceEntity device,
  ) {
    try {
      return Right(localDataSource.getLastStateOfDevice(device.xGetModel));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, Future<bool>> pillarSmallTrigger(
      DeviceEntity device) {
    try {
      return Right(localDataSource.pillarSmallTrigger(device.xGetModel));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, Future<bool>> accuCheckPair(DeviceEntity device) {
    try {
      return Right(localDataSource.accuCheckPair(device.xGetModel));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<BluetoothFailures, Stream<List<int>>> accuCheckReadValues(
      DeviceEntity device) {
    try {
      return Right(localDataSource.accuCheckReadValues(device.xGetModel));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Left(BluetoothFailure());
    }
  }
}
