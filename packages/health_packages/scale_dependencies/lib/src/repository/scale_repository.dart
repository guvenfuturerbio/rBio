import 'dart:async';

import 'package:guven_service/guven_service.dart';
import 'package:scale_dependencies/scale_dependencies.dart';

class ScaleRepository {
  final GuvenService _guvenService;
  final ScaleHiveImpl _scaleHiveImpl;
  final ScaleHealthImpl _scaleHealthImpl;

  ScaleRepository(
    this._guvenService,
    this._scaleHiveImpl,
    this._scaleHealthImpl,
  );

  final _firstLoadCount = 30;

  // #region init
  Future<void> init(String boxKey) async {
    await _scaleHiveImpl.init(boxKey);
  }
  // #endregion

  // #region clear
  Future<void> clear() async {
    await _scaleHiveImpl.clear();
  }
  // #endregion

  // #region getLatestMeasurement
  ScaleEntity? getLatestMeasurement(
    int age,
    int gender,
    int height,
  ) {
    List<ScaleHiveModel> list = _scaleHiveImpl.readScaleData();
    list.sort((a, b) {
      return (DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(b.occurrenceTime) ?? 0))
          .compareTo(
        (DateTime.fromMillisecondsSinceEpoch(
            int.tryParse(a.occurrenceTime) ?? 0)),
      );
    });
    return list.isEmpty
        ? null
        : list.first.xToChronicEntity(age, gender, height);
  }
  // #endregion

  // #region readLocalScaleData
  List<ScaleEntity> readLocalScaleData(int age, int gender, int height) {
    final list = _scaleHiveImpl.readScaleData();
    List<ScaleEntity> result = [];
    for (var item in list) {
      result.add(item.xToChronicEntity(age, gender, height));
    }
    return result;
  }
  // #endregion

  // #region fetchScaleData
  Future<bool> fetchScaleData(int entegrationId) async {
    try {
      final list = await _fetchNetworkFirstLoad(entegrationId);
      await _scaleHiveImpl.clear();
      await _scaleHiveImpl.addScaleListMeasurement(list.xToNetworkToHiveList);
      fetchOtherLoad(
              _guvenService, entegrationId, list.last.occurrenceTime ?? '')
          .then((value) async {
        await _scaleHiveImpl
            .addScaleListMeasurement(value.xToNetworkToHiveList);
      });
      return true;
    } catch (e) {
      return false;
    }
  }
  // #endregion

  // #region fetchOtherLoad
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
  // #endregion

  // #region _fetchNetworkFirstLoad
  Future<List<ScaleNetworkModel>> _fetchNetworkFirstLoad(
      int entegrationId) async {
    final response = await _guvenService.getScaleMasurement(
      GetScaleMasurementBody(
        entegrationId: entegrationId,
        count: _firstLoadCount,
      ),
    );
    final list =
        (response.xGetModel<List<ScaleNetworkModel>, ScaleNetworkModel>(
                ScaleNetworkModel())) ??
            [];
    return list;
  }
  // #endregion

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
      if (networkResult) {
        // Hive
        await _scaleHiveImpl
            .deleteScaleMeasurement(date.millisecondsSinceEpoch.toString());

        // Health
        await _scaleHealthImpl.deleteScaleMeasurement(date);

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
  // #endregion
}
