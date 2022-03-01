import 'package:health/health.dart';
import 'package:onedosehealth/core/core.dart';

part 'model/constants.dart';

class HealthService implements ScaleApi {
  final HealthFactory _health;
  HealthService() : _health = HealthFactory();

  Future<bool> requestAuthorization(
    List<HealthDataType> types, {
    List<HealthDataAccess>? permissions,
  }) async =>
      await _health.requestAuthorization(
        types,
        permissions: permissions,
      );

  Future<List<HealthDataPoint>> getScaleData() async =>
      await _health.getHealthDataFromTypes(
        Constants.instance.startDate,
        Constants.instance.endDate,
        Constants.instance.scaleTypes,
      );

  Future<bool> writeHealthData(
    double value,
    HealthDataType type,
    DateTime startTime,
    DateTime endTime,
  ) async =>
      _health.writeHealthData(
        value,
        type,
        startTime,
        endTime,
      );

  @override
  Future<bool> deleteScaleData(int millisecondsSinceEpoch) {
    // TODO: implement deleteScaleData
    throw UnimplementedError();
  }

  @override
  Future<List<ScaleModel>> readScaleData() {
    // TODO: implement readScaleData
    throw UnimplementedError();
  }

  @override
  Future<bool> updateScaleData(
      ScaleModel newModel, int millisecondsSinceEpoch) {
    // TODO: implement updateScaleData
    throw UnimplementedError();
  }

  @override
  Future<int> writeScaleData(ScaleModel model) {
    // TODO: implement writeScaleData
    throw UnimplementedError();
  }
}
