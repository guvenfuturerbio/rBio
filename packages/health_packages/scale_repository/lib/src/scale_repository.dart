import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mi_scale/mi_scale.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/scale/scale.dart';
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

  listenMiScale(
      MiScaleDevice scaleDevice,
      bool deviceAlreadyPaired,
      DiscoveredDevice device,
      PairedDevice pairedDevice,
      Stream<List<int>> streamForMi) {
    try {
      streamForMi.listen(
        (event) async {
          if (!(Atom.isDialogShow)) {
            Atom.show(
              MiScalePopUp(
                hasAlreadyPair: deviceAlreadyPaired,
              ),
            );
          }

          if (scaleDevice.scaleData == null ||
              !scaleDevice.scaleData!.scaleModel.measurementComplete!) {
            final Uint8List data = Uint8List.fromList(event);
            scaleDevice.parseScaleData(pairedDevice, data);

            if (scaleDevice.scaleData!.scaleModel.measurementComplete! &&
                deviceAlreadyPaired) {
              scaleDevice.scaleData!.calculateVariables();
              if (Atom.isDialogShow) {
                Atom.dismiss();
              }
              await Future.delayed(const Duration(milliseconds: 350));
              await Atom.show(
                ScaleTaggerPopUp(
                  scaleModel: scaleDevice.scaleData!.scaleModel
                    ..isManuel = false,
                ),
                barrierDismissible: false,
              );
              scaleDevice.scaleData = null;
            }

            final popUpCanClose = (Atom.isDialogShow) &&
                (scaleDevice.scaleData!.scaleModel.weightRemoved)! &&
                !scaleDevice.scaleData!.scaleModel.measurementComplete!;

            if (popUpCanClose) {
              Atom.dismiss();
            }

            if ((scaleDevice.scaleData?.scaleModel.measurementComplete)! &&
                !deviceAlreadyPaired) {
              // Saving paired device Section
              controlPointResponse.add(1);
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                getIt<BleDeviceManager>().savePairedDevices(pairedDevice);
              });
            }
          }

          //notifyListeners();
        },
        onError: (e, stk) {
          LoggerUtils.instance.e(e);
        },
      );
    } catch (e, stk) {
      LoggerUtils.instance.e(e);
      debugPrintStack(stackTrace: stk);
    }
  }

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
      LoggerUtils.instance.e("[ScaleRepository] - addScale() - $e");
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
      LoggerUtils.instance.e("[ScaleRepository] - deleteScale() - $e");
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
