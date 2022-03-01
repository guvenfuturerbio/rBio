import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:health/health.dart';
import 'package:scale_api/scale_api.dart';

part 'constants.dart';

class ScaleHealthImpl implements ScaleApi {
  final HealthFactory _health;
  ScaleHealthImpl() : _health = HealthFactory();

  @override
  Future<bool> deleteScaleData(int millisecondsSinceEpoch) {
    // TODO: implement deleteScaleData
    throw UnimplementedError();
  }

  @override
  Future<List<ScaleModel>> readScaleData() async {
    List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
      Constants.instance.startDate,
      Constants.instance.endDate,
      Constants.instance.scaleTypes,
    );

    List<ScaleModel> tempList = <ScaleModel>[];

    for (var item in data) {
      if (item.type == HealthDataType.WEIGHT) {
        tempList.add(
          ScaleModel(
            isManuel: item.deviceId != 'manuel',
            device: PairedDevice(
              deviceId: item.deviceId,
              modelName: item.sourceName,
            ).toJson(),
            dateTime: item.dateFrom,
            unit: ScaleUnit.kg,
            note: '',
            isFromHealth: true,
            images: [],
            weight: item.value.toDouble(),
          ),
        );
      }
    }

    for (var item in data) {
      if (item.type == HealthDataType.BODY_MASS_INDEX) {
        if (tempList.any((element) => element.dateTime == item.dateFrom)) {
          tempList
              .firstWhere((element) => element.dateTime == item.dateFrom)
              .bmi = item.value.toDouble();
        } else {
          tempList.add(
            ScaleModel(
              isManuel: item.deviceId != 'manuel',
              device: PairedDevice(
                deviceId: item.deviceId,
                modelName: item.sourceName,
              ).toJson(),
              dateTime: item.dateFrom,
              unit: ScaleUnit.kg,
              note: '',
              isFromHealth: true,
              images: [],
              bmi: item.value.toDouble(),
            ),
          );
        }
      }
    }

    for (var item in data) {
      if (item.type == HealthDataType.BODY_FAT_PERCENTAGE) {
        if (tempList.any((element) => element.dateTime == item.dateFrom)) {
          tempList
              .firstWhere((element) => element.dateTime == item.dateFrom)
              .bodyFat = item.value.toDouble();
        } else {
          tempList.add(
            ScaleModel(
              isManuel: item.deviceId != 'manuel',
              device: PairedDevice(
                deviceId: item.deviceId,
                modelName: item.sourceName,
              ).toJson(),
              dateTime: item.dateFrom,
              unit: ScaleUnit.kg,
              note: '',
              isFromHealth: true,
              images: [],
              bodyFat: item.value.toDouble(),
            ),
          );
        }
      }
    }

    List<ScaleMeasurementLogic> scaleData =
        tempList.map((e) => ScaleMeasurementLogic(scaleModel: e)).toList();

    if (scaleData.any((element) => element.bmi == null)) {
      for (var item
          in scaleData.where((element) => element.bmi == null).toList()) {
        item.calculateVariables();
      }
    }

    return tempList;
  }

  @override
  Future<bool> updateScaleData(
      ScaleModel newModel, int millisecondsSinceEpoch) {
    // TODO: implement updateScaleData
    throw UnimplementedError();
  }

  @override
  Future<int> writeScaleData(ScaleModel model) async {
    if (model.weight != null) {
      await _health.writeHealthData(
        model.weight!,
        HealthDataType.WEIGHT,
        model.dateTime,
        model.dateTime,
      );
    }

    if (model.bmi != null) {
      await _health.writeHealthData(
        model.bmi!,
        HealthDataType.BODY_MASS_INDEX,
        model.dateTime,
        model.dateTime,
      );
    }

    if (model.bodyFat != null) {
      await _health.writeHealthData(
        model.bodyFat!,
        HealthDataType.BODY_FAT_PERCENTAGE,
        model.dateTime,
        model.dateTime,
      );
    }

    return 0;
  }
}
