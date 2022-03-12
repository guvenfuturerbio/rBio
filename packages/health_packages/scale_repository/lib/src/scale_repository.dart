import 'dart:async';

import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:scale_health_impl/scale_health_impl.dart';
import 'package:scale_hive_impl/scale_hive_impl.dart';
import 'package:scale_repository/scale_repository.dart';

class ScaleRepository {
  final GuvenService _guvenService;
  final ScaleHiveImpl _scaleHiveImpl;
  final ScaleHealthImpl _scaleHealthImpl;
  final BluetoothConnector _connector;
  final BleReactorOps _reactor;

  ScaleRepository(
    this._guvenService,
    this._scaleHiveImpl,
    this._scaleHealthImpl,
    this._connector,
    this._reactor,
  );

  final firstLoadCount = 30;

  Future<void> init(String boxKey) async {
    await _scaleHiveImpl.init(boxKey);
  }

  Future<void> clear() async {
    await _scaleHiveImpl.clear();
  }

  Stream<ScaleSubscribeState> subscribeScale(
    PairedDevice pairedDevice,
    int age,
    int gender,
    int height,
  ) async* {
    await for (var event in _reactor.subscribeScale(pairedDevice)) {
      yield* event.when(showMiScalePopUp: (deviceAlreadyPaired) async* {
        yield ScaleSubscribeState.showMiScalePopUp(deviceAlreadyPaired);
      }, sendModel: (model) async* {
        final scaleEntity = ScaleEntity(
          dateTime: model.dateTime!,
          age: age,
          gender: gender,
          height: height,
          weight: model.weight,
          impedance: model.impedance,
          isManuel: false,
          unit: model.unit,
          weightRemoved: model.weightRemoved,
          measurementComplete: model.measurementComplete,
          weightStabilized: model.weightStabilized,
        );

        scaleEntity.calculateVariables();
        yield ScaleSubscribeState.sendEntity(scaleEntity);
      }, changeState: (_, __) async* {
        yield ScaleSubscribeState.changeState(_, __);
      });
    }
  }

  List<ScaleEntity> readLocalScaleData(int age, int gender, int height) {
    final list = _scaleHiveImpl.readScaleData();
    List<ScaleEntity> result = [];
    for (var item in list) {
      result.add(item.xToChronicEntity(age, gender, height));
    }
    return result;
  }

  Future<bool> fetchScaleData(int entegrationId) async {
    try {
      final list = await _fetchNetworkFirstLoad(entegrationId);
      await _scaleHiveImpl.clear();
      await _scaleHiveImpl.addScaleListMeasurement(list.xToHiveList);
      fetchOtherLoad(
              _guvenService, entegrationId, list.last.occurrenceTime ?? '')
          .then((value) async {
        await _scaleHiveImpl.addScaleListMeasurement(value.xToHiveList);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ScaleNetworkModel>> fetchOtherLoad(
    GuvenService _guvenService,
    int entegrationId,
    String occurrenceTime,
  ) async {
    final GuvenResponseModel response = await _guvenService.getScaleMasurement(
      GetScaleMasurementBody(
        entegrationId: entegrationId,
        beginDate: DateTime(2000),
        endDate: DateTime.parse(occurrenceTime),
      ),
    );
    final list =
        (response.xGetModel<List<ScaleNetworkModel>, ScaleNetworkModel>(
                ScaleNetworkModel())) ??
            [];
    return list;
  }

  bool _isFirstLoad() => (_scaleHiveImpl.readScaleData()).isEmpty;

  Future<List<ScaleNetworkModel>> _fetchNetworkFirstLoad(
      int entegrationId) async {
    final response = await _guvenService.getScaleMasurement(
      GetScaleMasurementBody(
        entegrationId: entegrationId,
        count: firstLoadCount,
      ),
    );
    final list =
        (response.xGetModel<List<ScaleNetworkModel>, ScaleNetworkModel>(
                ScaleNetworkModel())) ??
            [];
    return list;
  }

  // #region addScaleMeasurement
  Future<bool> addScaleMeasurement(AddScaleMasurementBody model) async {
    try {
      // Network
      final measurementId =
          (await _guvenService.addScaleMeasurement(model)).datum;

      if (measurementId != null) {
        // Hive
        await _scaleHiveImpl.addScaleMeasurement(
          model.xToScaleHiveModel(measurementId),
        );

        // Health
        final hasAuth = await _scaleHealthImpl.hasAuthorization();
        if (hasAuth) {
          await _scaleHealthImpl.addScaleMeasurement(model.xToScaleHealthModel);
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("[ScaleRepository] - addScale() - $e");
      return false;
    }
  }
  // #endregion

  // #region deleteScaleMeasurement
  Future<bool> deleteScaleMeasurement(
    DeleteScaleMasurementBody model,
    DateTime date,
  ) async {
    try {
      // Network
      final networkResult = await _guvenService.deleteScaleMeasurement(model);
      if (!networkResult) {
        // Hive
        await _scaleHiveImpl
            .deleteScaleMeasurement(date.millisecondsSinceEpoch.toString());

        // Health
        await _scaleHealthImpl.deleteScaleMeasurement(date);

        return true;
      }

      return false;
    } catch (e) {
      print("[ScaleRepository] - deleteScale() - $e");
      return false;
    }
  }
  // #endregion
}
