part of 'chronic_storage_service.dart';

class BloodPressureStorageImpl extends ChronicStorageService {
  @override
  Future<bool> delete(key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future deleteFromServer(
      int timeKey, Map<String, dynamic> deleteMeasurementRequest) {
    // TODO: implement deleteFromServer
    throw UnimplementedError();
  }

  @override
  bool doesExist(HiveObject data) {
    // TODO: implement doesExist
    throw UnimplementedError();
  }

  @override
  HiveObject get(key) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  List<HiveObject> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  HiveObject getLatestMeasurement() {
    // TODO: implement getLatestMeasurement
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future sendToServer(HiveObject data) {
    // TODO: implement sendToServer
    throw UnimplementedError();
  }

  @override
  Future<bool> update(HiveObject data, key) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future updateServer(HiveObject data) {
    // TODO: implement updateServer
    throw UnimplementedError();
  }

  @override
  Future<bool> write(HiveObject data, {bool shouldSendToServer = false}) {
    // TODO: implement write
    throw UnimplementedError();
  }

  @override
  Future<bool> writeAll(List<HiveObject> data) {
    // TODO: implement writeAll
    throw UnimplementedError();
  }
}
