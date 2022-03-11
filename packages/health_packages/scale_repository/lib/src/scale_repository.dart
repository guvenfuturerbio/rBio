import 'dart:async';

import 'package:guven_service/guven_service.dart';
import 'package:scale_api/scale_api.dart';
import 'package:scale_health_impl/scale_health_impl.dart';
import 'package:scale_hive_impl/scale_hive_impl.dart';

class ScaleRepository {
  final GuvenService _guvenService;
  final ScaleHiveImpl _scaleHiveImpl;
  final ScaleHealthImpl _scaleHealthImpl;

  ScaleRepository(
    this._guvenService,
    this._scaleHiveImpl,
    this._scaleHealthImpl,
  );

  final firstLoadCount = 30;

  // #region init
  Future<void> init(String boxKey) async {
    await _scaleHiveImpl.init(boxKey);
  }
  // #endregion

  // Future<void> getAll() async {
  //   final networkResponse = await _guvenService
  //       .getScaleMasurement(GetScaleMasurementBody(count: 1));
  //   final networkList =
  //       networkResponse.xGetModel<List<ScaleNetworkModel>, ScaleNetworkModel>(
  //           ScaleNetworkModel());

  //   final localList = await _scaleHiveImpl.readScaleData();

  //   if (localList.isNotEmpty && (networkList?.isNotEmpty ?? false)) {
  //     if (!(localList.last.occurrenceTime ==z
  //         networkList!.last.occurrenceTime)) {
  //       final networkBigResponse = await _guvenService
  //           .getScaleMasurement(GetScaleMasurementBody(count: 20));
  //       final networkBigList = networkBigResponse.xGetModel<
  //           List<ScaleNetworkModel>, ScaleNetworkModel>(ScaleNetworkModel());
  //       if (networkBigList != null) {
  //         for (var item in networkBigList) {
  //           final isExist = localList.any(
  //               (element) => element.occurrenceTime == item.occurrenceTime);
  //           if (!isExist) {
  //             await _scaleHiveImpl.writeScaleData(
  //               item.xToScaleHiveModel(),
  //             );
  //           }
  //         }
  //       }
  //     }
  //   }
  // }

  Future<bool> fetchScaleData(int entegrationId) async {
    try {
      final list = await _fetchNetworkFirstLoad(entegrationId);
      await _scaleHiveImpl.clear();
      await _scaleHiveImpl.addScaleListMeasurement(list.xToHiveList);

      final args = <String, dynamic>{
        "guvenService": _guvenService,
        "entegrationId": entegrationId,
        "endDate": list.last.occurrenceTime
      };
      fetchOtherLoad(args).then((value) async {
        await _scaleHiveImpl.addScaleListMeasurement(value.xToHiveList);
      });
      return true;
    } catch (e) {
      return false;
    }
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

Future<List<ScaleNetworkModel>> fetchOtherLoad(
  Map<String, dynamic> args,
) async {
  final GuvenResponseModel response =
      await args["guvenService"].getScaleMasurement(
    GetScaleMasurementBody(
      entegrationId: args["entegrationId"],
      beginDate: DateTime(2000),
      endDate: DateTime.parse(args["endDate"]),
    ),
  );
  final list = (response.xGetModel<List<ScaleNetworkModel>, ScaleNetworkModel>(
          ScaleNetworkModel())) ??
      [];
  return list;
}
