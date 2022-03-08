import 'package:onedosehealth/core/core.dart';
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

  Future<void> init() async {
    await _scaleHiveImpl.init("boxKey");
  }

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

  Future<bool> addScale(AddScaleMasurementBody model) async {
    try {
      // Network
      final measurementId =
          (await _guvenService.insertNewScaleValue(model)).datum;

      if (measurementId != null) {
        // Local
        await _scaleHiveImpl.writeScaleData(
          model.xToScaleHiveModel(measurementId),
        );

        // Health
        final hasAuth = await _scaleHealthImpl.hasAuthorization();
        if (hasAuth) {
          await _scaleHealthImpl.writeScaleData(model.xToScaleHealthModel);
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      LoggerUtils.instance.e("[ScaleRepository] - addScale() - $e");
      return false;
    }
  }

  Future<bool> deleteScale(
    DeleteScaleMasurementBody model,
    DateTime date,
  ) async {
    try {
      // Network
      final networkResult = await _guvenService.deleteScaleMeasurement(model);
      if (!networkResult) {
        // Hive
        await _scaleHiveImpl
            .deleteScaleData(date.millisecondsSinceEpoch.toString());

        // Health
        await _scaleHealthImpl.deleteScaleData(date);

        return true;
      }

      return false;
    } catch (e) {
      LoggerUtils.instance.e("[ScaleRepository] - deleteScale() - $e");
      return false;
    }
  }
}
