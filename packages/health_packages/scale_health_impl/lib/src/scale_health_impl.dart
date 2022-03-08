import 'package:health/health.dart';
import 'package:scale_api/scale_api.dart';

import '../scale_health_impl.dart';

part 'constants.dart';

class ScaleHealthImpl {
  final HealthFactory _health;
  ScaleHealthImpl() : _health = HealthFactory();

  Future<bool?> hasPermissions() async =>
      await HealthFactory.hasPermissions(
        Constants.instance.scaleTypes,
        permissions: [
          HealthDataAccess.READ_WRITE,
          HealthDataAccess.READ_WRITE,
          HealthDataAccess.READ_WRITE,
        ],
      );

  Future<bool> hasAuthorization() async => _health.requestAuthorization(
        Constants.instance.scaleTypes,
        permissions: [
          HealthDataAccess.READ_WRITE,
          HealthDataAccess.READ_WRITE,
          HealthDataAccess.READ_WRITE,
        ],
      );

  Future<bool> deleteScaleData(DateTime date) async {
    try {
      await _health.deleteData(
        HealthDataType.WEIGHT,
        date,
      );
      await _health.deleteData(
        HealthDataType.BODY_MASS_INDEX,
        date,
      );
      await _health.deleteData(
        HealthDataType.BODY_FAT_PERCENTAGE,
        date,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ScaleHealthModel>> readScaleData() async {
    List<HealthDataPoint> healthList = await _health.getHealthDataFromTypes(
      Constants.instance.startDate,
      Constants.instance.endDate,
      Constants.instance.scaleTypes,
    );

    List<ScaleHealthModel> result = <ScaleHealthModel>[];

    for (var item in healthList) {
      if (item.type == HealthDataType.WEIGHT) {
        result.add(
          ScaleHealthModel(
            isManuel: item.deviceId != 'manuel',
            deviceId: item.deviceId,
            // device: PairedDevice(
            //   deviceId: item.deviceId,
            //   modelName: item.sourceName,
            // ).toJson(),
            occurrenceTime: item.dateFrom.millisecondsSinceEpoch.toString(),
            scaleUnit: ScaleUnit.kg,
            weight: item.value.toDouble(),
          ),
        );
      }
    }

    for (var item in healthList) {
      if (item.type == HealthDataType.BODY_MASS_INDEX) {
        if (result.any((element) =>
            element.occurrenceTime ==
            item.dateFrom.millisecondsSinceEpoch.toString())) {
          result
              .firstWhere((element) =>
                  element.occurrenceTime ==
                  item.dateFrom.millisecondsSinceEpoch.toString())
              .bmi = item.value.toDouble();
        } else {
          result.add(
            ScaleHealthModel(
              isManuel: item.deviceId != 'manuel',
              deviceId: item.deviceId,
              occurrenceTime: item.dateFrom.millisecondsSinceEpoch.toString(),
              scaleUnit: ScaleUnit.kg,
              weight: item.value.toDouble(),
            ),
          );
        }
      }
    }

    for (var item in healthList) {
      if (item.type == HealthDataType.BODY_FAT_PERCENTAGE) {
        if (result.any((element) =>
            element.occurrenceTime ==
            item.dateFrom.millisecondsSinceEpoch.toString())) {
          result
              .firstWhere((element) =>
                  element.occurrenceTime ==
                  item.dateFrom.millisecondsSinceEpoch.toString())
              .bodyFat = item.value.toDouble();
        } else {
          result.add(
            ScaleHealthModel(
              isManuel: item.deviceId != 'manuel',
              deviceId: item.deviceId,
              occurrenceTime: item.dateFrom.millisecondsSinceEpoch.toString(),
              scaleUnit: ScaleUnit.kg,
              weight: item.value.toDouble(),
            ),
          );
        }
      }
    }

    return result;
  }

  Future<bool> updateScaleData(ScaleHealthModel newModel, DateTime date) async {
    final isDeleted = await deleteScaleData(date);
    if (isDeleted) {
      final hasWritten = await writeScaleData(newModel);
      return hasWritten;
    }

    return false;
  }

  Future<bool> writeScaleData(ScaleHealthModel model) async {
    try {
      if (model.weight != null) {
        await _health.writeHealthData(
          model.weight!,
          HealthDataType.WEIGHT,
          DateTime.fromMillisecondsSinceEpoch(int.parse(model.occurrenceTime)),
          DateTime.fromMillisecondsSinceEpoch(int.parse(model.occurrenceTime)),
        );
      }

      if (model.bmi != null) {
        await _health.writeHealthData(
          model.bmi!,
          HealthDataType.BODY_MASS_INDEX,
          DateTime.fromMillisecondsSinceEpoch(int.parse(model.occurrenceTime)),
          DateTime.fromMillisecondsSinceEpoch(int.parse(model.occurrenceTime)),
        );
      }

      if (model.bodyFat != null) {
        await _health.writeHealthData(
          model.bodyFat!,
          HealthDataType.BODY_FAT_PERCENTAGE,
          DateTime.fromMillisecondsSinceEpoch(int.parse(model.occurrenceTime)),
          DateTime.fromMillisecondsSinceEpoch(int.parse(model.occurrenceTime)),
        );
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
