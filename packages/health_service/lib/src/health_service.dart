import 'package:health/health.dart';

part 'model/constants.dart';

class HealthService {
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

  Future<List<HealthDataPoint>> getBloodGlucoseData() async =>
      await _health.getHealthDataFromTypes(
        Constants.instance.startDate,
        Constants.instance.endDate,
        Constants.instance.bloodGlucoseTypes,
      );

  Future<List<HealthDataPoint>> getBloodPressureData() async =>
      await _health.getHealthDataFromTypes(
        Constants.instance.startDate,
        Constants.instance.endDate,
        Constants.instance.bloodPressureTypes,
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
  ) async {
    return _health.writeHealthData(
      value,
      type,
      startTime,
      endTime,
    );
  }
}
