import 'package:health/health.dart';

import '../../scale_dependencies.dart';

class ScaleHealthImpl {
  final HealthFactory _health;
  ScaleHealthImpl() : _health = HealthFactory();

  final DateTime startDate = DateTime(1997, 11, 9);
  final DateTime endDate = DateTime.now();

  final scaleTypes = [
    HealthDataType.BODY_MASS_INDEX,
    HealthDataType.BODY_FAT_PERCENTAGE,
    HealthDataType.WEIGHT,
  ];

  Future<bool?> hasPermissions() async => await HealthFactory.hasPermissions(
        scaleTypes,
        permissions: [
          HealthDataAccess.READ_WRITE,
          HealthDataAccess.READ_WRITE,
          HealthDataAccess.READ_WRITE,
        ],
      );

  Future<bool> hasAuthorization() async => _health.requestAuthorization(
        scaleTypes,
        permissions: [
          HealthDataAccess.READ_WRITE,
          HealthDataAccess.READ_WRITE,
          HealthDataAccess.READ_WRITE,
        ],
      );

  Future<bool> deleteScaleMeasurement(DateTime date) async {
    var itemDate = date.toString();
    itemDate = itemDate.substring(0, itemDate.length - 1);
    final newDate = DateTime.parse(itemDate);

    try {
      await _health.deleteData(
        HealthDataType.WEIGHT,
        newDate,
      );
      await _health.deleteData(
        HealthDataType.BODY_MASS_INDEX,
        newDate,
      );
      await _health.deleteData(
        HealthDataType.BODY_FAT_PERCENTAGE,
        newDate,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ScaleHealthModel>> readScaleData() async {
    List<HealthDataPoint> healthList = await _health.getHealthDataFromTypes(
      startDate,
      endDate,
      scaleTypes,
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
    final isDeleted = await deleteScaleMeasurement(date);
    if (isDeleted) {
      final hasWritten = await addScaleMeasurement(newModel);
      return hasWritten;
    }

    return false;
  }

  Future<bool> addScaleMeasurement(ScaleHealthModel model) async {
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
