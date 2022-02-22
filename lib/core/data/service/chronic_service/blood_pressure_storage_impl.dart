part of 'chronic_storage_service.dart';

class BloodPressureStorageImpl
    extends ChronicStorageService<BloodPressureModel> {
  @override
  final String boxKey = 'BloodPressure';
  HealthFactory? health;

  bool _hasProgress = false;

  List<HealthDataType> types = [];

  /// Types uzunluğu kadar
  List<HealthDataAccess> perm = [
    HealthDataAccess.READ_WRITE,
    HealthDataAccess.READ_WRITE,
    HealthDataAccess.READ_WRITE,
  ];

  @override
  Future<void> init() async {
    box = await Hive.openBox<BloodPressureModel>(boxKey);
    health = HealthFactory();

    types = [
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.HEART_RATE,
    ];
  }

  bool checkBox([bool checkIsEmpty = false]) {
    if (!box.isOpen) {
      throw Exception('Box can"t open please check your box!!!');
    }

    if (checkIsEmpty) {
      return box.isNotEmpty;
    } else {
      return true;
    }
  }

  @override
  Future<bool> delete(dynamic key) async {
    try {
      if (checkBox(true) && box.containsKey(key)) {
        final BloodPressureModel? data = box.get(key);
        if (data == null) {
          throw Exception("data null");
        }

        if (data.dateTime != null) {
          await deleteFromServer(
            data.dateTime!.millisecondsSinceEpoch,
            DeleteBpMeasurements(
              entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
              measurementId: data.measurementId,
            ).toJson(),
          );
          box.delete(key);
          notifyListeners();
          return true;
        }

        throw Exception("dateTime null");
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteFromServer(
    int timeKey,
    Map<String, dynamic> deleteMeasurementRequest,
  ) async {
    try {
      await getIt<ChronicTrackingRepository>().deleteBpMeasurement(
        DeleteBpMeasurements.fromJson(deleteMeasurementRequest),
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  bool doesExist(BloodPressureModel data) {
    bool isContains = false;
    for (var item in box.values) {
      if (item.isEqual(data)) {
        isContains = true;
        break;
      }
    }
    return isContains;
  }

  @override
  BloodPressureModel get(dynamic key) {
    try {
      if (checkBox(true)) {
        final data = box.get(key);
        if (data == null) {
          throw Exception("data null");
        }

        return data;
      } else {
        throw Exception('box: $boxKey is empty');
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  List<BloodPressureModel> getAll() {
    try {
      if (checkBox()) {
        return box.values.toList();
      } else {
        return [];
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  BloodPressureModel? getLatestMeasurement() {
    try {
      if (checkBox(true)) {
        final List<BloodPressureModel> list = getAll();
        list.sort((a, b) {
          final aDate = a.dateTime;
          final bDate = b.dateTime;
          if (aDate == null || bDate == null) {
            throw Exception("aDate : $aDate bDate : $bDate");
          }

          return bDate.compareTo(aDate);
        });
        return list[0];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future sendToServer(BloodPressureModel data) async {
    final int userId = getIt<ProfileStorageImpl>().getFirst().id ?? 0;

    final AddBpWithDetail addBpWithDetail = AddBpWithDetail(
      deviceUuid: data.deviceUUID,
      dia: data.dia,
      entegrationId: userId,
      isManual: data.isManual,
      note: data.note,
      occurrenceTime: data.dateTime,
      pulse: data.pulse,
      sys: data.sys,
    );
    try {
      return (await getIt<ChronicTrackingRepository>()
              .insertNewBpValue(addBpWithDetail))
          .datum;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> update(BloodPressureModel data, dynamic key) async {
    try {
      if (checkBox()) {
        await updateServer(data);
        await box.put(key, data);
        notifyListeners();
        return true;
      } else {
        throw Exception('unhandled exception on box:$boxKey');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateServer(BloodPressureModel data) async {
    final int userId = getIt<ProfileStorageImpl>().getFirst().id ?? 0;

    final UpdateBpMeasurements updateBpMeasurements = UpdateBpMeasurements(
      deviceUuid: data.deviceUUID,
      dia: data.dia,
      entegrationId: userId,
      id: 0,
      isManual: data.isManual,
      measurementId: data.measurementId,
      note: data.note,
      occurrenceTime: data.dateTime,
      pulse: data.pulse,
      sys: data.sys,
    );
    try {
      await getIt<ChronicTrackingRepository>()
          .updateBpMeasurement(updateBpMeasurements);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> write(
    BloodPressureModel data, {
    bool shouldSendToServer = false,
  }) async {
    try {
      if (checkBox()) {
        if (shouldSendToServer) {
          if (!data.isFromHealth) {
            health!.requestAuthorization(types, permissions: perm);
            if (data.sys != null) {
              health!.writeHealthData(
                  data.sys!.toDouble(),
                  HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
                  data.dateTime!,
                  data.dateTime!);
            }
            if (data.dia != null) {
              health!.writeHealthData(
                  data.dia!.toDouble(),
                  HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
                  data.dateTime!,
                  data.dateTime!);
            }
            if (data.pulse != null) {
              health!.writeHealthData(data.pulse!.toDouble(),
                  HealthDataType.HEART_RATE, data.dateTime!, data.dateTime!);
            }
          }
          final id = await sendToServer(data);
          if (id is int?) {
            if (id != null) {
              data.measurementId = id;
            }
          }
        }
        await box.add(data);
        notifyListeners();
        return true;
      } else {
        throw Exception('unhandled exception on box:$boxKey');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> writeAll(
    List<BloodPressureModel> data, {
    bool isFromHealth = false,
  }) async {
    try {
      if (checkBox()) {
        for (var item in data) {
          if (!doesExist(item)) {
            if (isFromHealth) {
              var id = await sendToServer(item);
              item.measurementId = id;
            }
            box.add(item);
          }
        }

        return true;
      } else {
        throw Exception('unhandled exception on box:$boxKey');
      }
    } catch (e) {
      LoggerUtils.instance.e(e);

      rethrow;
    }
  }

  Future<void> checkLastBp() async {
    final list = await getBpValues(count: 1);
    if (list.isNotEmpty) {
      final lastData = list.last;
      if (getLatestMeasurement() == null ||
          box.values.length < 5 ||
          !lastData.isEqual(getLatestMeasurement()!)) {
        box.clear();
        getAndWriteBpData();
      }
    }
  }

  Future<List<BloodPressureModel>> getBpValues({
    DateTime? beginDate,
    DateTime? endDate,
    int? count,
  }) async {
    try {
      final GetBpMeasurements getScaleMasurementBody = GetBpMeasurements(
        entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
        beginDate: beginDate,
        endDate: endDate,
        count: count,
      );

      final response = await getIt<ChronicTrackingRepository>()
          .getBpDataOfPerson(getScaleMasurementBody);

      final datum = response.datum;
      if (datum is List?) {
        if (datum != null) {
          final List<BloodPressureModel> bpDataList = <BloodPressureModel>[];
          for (final scaleMeasurement in datum) {
            bpDataList.add(
              BloodPressureModel.fromJson(
                scaleMeasurement as Map<String, dynamic>,
              ),
            );
          }
          return bpDataList;
        }
      }

      throw Exception("datum null");
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getAndWriteBpData({
    DateTime? beginDate,
    DateTime? endDate,
    int count = 20,
  }) async {
    if (!_hasProgress) {
      _hasProgress = true;
      final list = await getBpValues(
          beginDate: beginDate, endDate: endDate, count: count);
      if (list.isNotEmpty) {
        var _dubItem = 0;
        for (final glucose in list) {
          if (doesExist(glucose)) _dubItem++;
        }
        if (_dubItem != list.length) {
          await writeAll(list);
          _hasProgress = false;
          notifyListeners();
          return false;
        } else {
          _hasProgress = false;
          return false;
        }
      } else {
        _hasProgress = false;
        return true;
      }
    } else {
      return false;
    }
  }

  @override
  void clear() => box.clear();
}
