import 'package:health/health.dart';
import 'package:onedosehealth/core/core.dart';

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

    List<ScaleModel> _tempScaleModel = <ScaleModel>[];

    for (var item in data) {
      if (item.type == HealthDataType.WEIGHT) {
        _tempScaleModel.add(
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
        if (_tempScaleModel
            .any((element) => element.dateTime == item.dateFrom)) {
          _tempScaleModel
              .firstWhere((element) => element.dateTime == item.dateFrom)
              .bmi = item.value.toDouble();
        } else {
          _tempScaleModel.add(
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
        if (_tempScaleModel
            .any((element) => element.dateTime == item.dateFrom)) {
          _tempScaleModel
              .firstWhere((element) => element.dateTime == item.dateFrom)
              .bodyFat = item.value.toDouble();
        } else {
          _tempScaleModel.add(
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

    List<ScaleMeasurementViewModel> scaleData = _tempScaleModel
        .map(
          (e) => ScaleMeasurementViewModel(
            scaleModel: ScaleModel(
              isManuel: e.deviceId != 'manuel',
              device: PairedDevice(
                deviceId: e.deviceId,
                modelName: e.deviceName,
              ).toJson(),
              unit: ScaleUnit.kg,
              bmi: e.bmi,
              weight: e.weight,
              bodyFat: e.bodyFat,
              note: '',
              dateTime: e.date,
              isFromHealth: true,
              images: [],
            ),
          ),
        )
        .toList();

    if (scaleData.any((element) => element.bmi == null)) {
      for (var item
          in scaleData.where((element) => element.bmi == null).toList()) {
        item.calculateVariables();
      }
    }
  }

  @override
  Future<bool> updateScaleData(
      ScaleModel newModel, int millisecondsSinceEpoch) {
    // TODO: implement updateScaleData
    throw UnimplementedError();
  }

  @override
  Future<int> writeScaleData(ScaleModel model) {}
}
