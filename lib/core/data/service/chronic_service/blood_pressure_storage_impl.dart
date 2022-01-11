part of 'chronic_storage_service.dart';

class BloodPressureStorageImpl
    extends ChronicStorageService<BloodPressureModel> {
  @override
  final String boxKey = 'BloodPressure';

  @override
  Future<void> init() async {
    box = await Hive.openBox<BloodPressureModel>(boxKey);
  }

  List<Map<String, dynamic>> get map {
    var list = [
      {"occurrence_time": "", "pulse": 72, "sys": 125, "dia": 86},
      {"occurrence_time": "", "pulse": 85, "sys": 104, "dia": 57},
      {"occurrence_time": "", "pulse": 84, "sys": 101, "dia": 58},
      {"occurrence_time": "", "pulse": 65, "sys": 140, "dia": 82},
      {"occurrence_time": "", "pulse": 70, "sys": 134, "dia": 68},
      {"occurrence_time": "", "pulse": 87, "sys": 100, "dia": 59},
      {"occurrence_time": "", "pulse": 77, "sys": 110, "dia": 58},
      {"occurrence_time": "", "pulse": 82, "sys": 108, "dia": 61},
      {"occurrence_time": "", "pulse": 80, "sys": 104, "dia": 64},
      {"occurrence_time": "", "pulse": 82, "sys": 102, "dia": 61},
      {"occurrence_time": "", "pulse": 82, "sys": 108, "dia": 67},
      {"occurrence_time": "", "pulse": 85, "sys": 115, "dia": 73},
      {"occurrence_time": "", "pulse": 67, "sys": 137, "dia": 79},
      {"occurrence_time": "", "pulse": 78, "sys": 140, "dia": 79},
      {"occurrence_time": "", "pulse": 78, "sys": 106, "dia": 57},
      {"occurrence_time": "", "pulse": 85, "sys": 128, "dia": 78},
      {"occurrence_time": "", "pulse": 69, "sys": 134, "dia": 86},
      {"occurrence_time": "", "pulse": 77, "sys": 142, "dia": 79},
      {"occurrence_time": "", "pulse": 82, "sys": 128, "dia": 64},
      {"occurrence_time": "", "pulse": 92, "sys": 145, "dia": 83},
      {"occurrence_time": "", "pulse": 74, "sys": 138, "dia": 89},
      {"occurrence_time": "", "pulse": 66, "sys": 125, "dia": 86},
      {"occurrence_time": "", "pulse": 89, "sys": 128, "dia": 77},
      {"occurrence_time": "", "pulse": 94, "sys": 125, "dia": 78},
      {"occurrence_time": "", "pulse": 88, "sys": 114, "dia": 71},
      {"occurrence_time": "", "pulse": 86, "sys": 113, "dia": 77},
      {"occurrence_time": "", "pulse": 78, "sys": 142, "dia": 86},
      {"occurrence_time": "", "pulse": 81, "sys": 144, "dia": 88},
      {"occurrence_time": "", "pulse": 87, "sys": 122, "dia": 74},
      {"occurrence_time": "", "pulse": 82, "sys": 152, "dia": 83},
      {"occurrence_time": "", "pulse": 79, "sys": 122, "dia": 81},
      {"occurrence_time": "", "pulse": 82, "sys": 139, "dia": 85},
      {"occurrence_time": "", "pulse": 72, "sys": 132, "dia": 80},
      {"occurrence_time": "", "pulse": 74, "sys": 141, "dia": 87},
      {"occurrence_time": "", "pulse": 71, "sys": 124, "dia": 85},
      {"occurrence_time": "", "pulse": 74, "sys": 129, "dia": 85},
      {"occurrence_time": "", "pulse": 74, "sys": 120, "dia": 83},
      {"occurrence_time": "", "pulse": 72, "sys": 127, "dia": 78},
      {"occurrence_time": "", "pulse": 76, "sys": 111, "dia": 84},
      {"occurrence_time": "", "pulse": 83, "sys": 150, "dia": 102},
      {"occurrence_time": "", "pulse": 61, "sys": 128, "dia": 77},
      {"occurrence_time": "", "pulse": 84, "sys": 100, "dia": 66},
      {"occurrence_time": "", "pulse": 73, "sys": 132, "dia": 79},
      {"occurrence_time": "", "pulse": 96, "sys": 108, "dia": 69},
      {"occurrence_time": "", "pulse": 69, "sys": 101, "dia": 61},
      {"occurrence_time": "", "pulse": 77, "sys": 126, "dia": 88},
      {"occurrence_time": "", "pulse": 89, "sys": 127, "dia": 90},
      {"occurrence_time": "", "pulse": 78, "sys": 146, "dia": 84},
      {"occurrence_time": "", "pulse": 90, "sys": 103, "dia": 73},
      {"occurrence_time": "", "pulse": 79, "sys": 126, "dia": 69},
      {"occurrence_time": "", "pulse": 86, "sys": 130, "dia": 85},
      {"occurrence_time": "", "pulse": 97, "sys": 147, "dia": 73},
      {"occurrence_time": "", "pulse": 90, "sys": 139, "dia": 66},
    ];

    for (var item = 0; item < list.length; item++) {
      list[item]["occurrence_time"] = timeList[item];
    }

    return list;
  }

  List<String> get timeList => [
        "2021-01-01T00:00:00.000",
        "2021-01-01T01:00:00.000",
        "2021-01-01T02:00:00.000",
        "2021-01-01T03:00:00.000",
        "2021-01-01T04:00:00.000",
        "2021-01-01T05:00:00.000",
        "2021-01-01T06:00:00.000",
        "2021-01-01T07:00:00.000",
        "2021-01-01T08:00:00.000",
        "2021-01-01T09:00:00.000",
        "2021-01-01T10:00:00.000",
        "2021-01-01T11:00:00.000",
        "2021-01-01T12:00:00.000",
        "2021-01-01T13:00:00.000",
        "2021-01-01T14:00:00.000",
        "2021-01-01T15:00:00.000",
        "2021-01-01T16:00:00.000",
        "2021-01-01T17:00:00.000",
        "2021-01-01T18:00:00.000",
        "2021-01-01T19:00:00.000",
        "2021-01-01T20:00:00.000",
        "2021-01-01T21:00:00.000",
        "2021-01-01T22:00:00.000",
        "2021-01-01T23:00:00.000",
        "2021-01-02T00:00:00.000",
        "2021-01-02T01:00:00.000",
        "2021-01-02T02:00:00.000",
        "2021-01-02T03:00:00.000",
        "2021-01-02T04:00:00.000",
        "2021-01-02T05:00:00.000",
        "2021-01-02T06:00:00.000",
        "2021-01-02T07:00:00.000",
        "2021-01-02T08:00:00.000",
        "2021-01-02T09:00:00.000",
        "2021-01-02T10:00:00.000",
        "2021-01-02T11:00:00.000",
        "2021-01-02T12:00:00.000",
        "2021-01-02T13:00:00.000",
        "2021-01-02T14:00:00.000",
        "2021-01-02T15:00:00.000",
        "2021-01-02T16:00:00.000",
        "2021-01-02T17:00:00.000",
        "2021-01-02T18:00:00.000",
        "2021-01-02T19:00:00.000",
        "2021-01-02T20:00:00.000",
        "2021-01-02T21:00:00.000",
        "2021-01-02T22:00:00.000",
        "2021-01-02T23:00:00.000",
        "2021-01-03T00:00:00.000",
        "2021-01-03T01:00:00.000",
        "2021-01-03T02:00:00.000",
        "2021-01-03T03:00:00.000",
        "2021-01-03T04:00:00.000",
        "2021-01-03T05:00:00.000",
      ];

  checkBox([bool checkIsEmpty = false]) {
    if (!box.isOpen)
      throw Exception('Box can\'t open please check your box!!!');
    if (checkIsEmpty) {
      return box.isNotEmpty;
    } else
      return true;
  }

  @override
  Future<bool> delete(key) async {
    try {
      if (checkBox(true) && box.containsKey(key)) {
        BloodPressureModel data = box.get(key);
        await deleteFromServer(
            data.dateTime.millisecondsSinceEpoch,
            DeleteBpMeasurements(
                    entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
                    measurementId: data.measurementId)
                .toJson());
        box.delete(key);
        notifyListeners();
        return true;
      } else
        return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteFromServer(
      int timeKey, Map<String, dynamic> deleteMeasurementRequest) async {
    try {
      await getIt<ChronicTrackingRepository>().deleteBpMeasurement(
          DeleteBpMeasurements.fromJson(deleteMeasurementRequest));
    } catch (_) {
      rethrow;
    }
  }

  @override
  bool doesExist(BloodPressureModel data) {
    return box.values.contains(data);
  }

  @override
  BloodPressureModel get(key) {
    try {
      if (checkBox(true))
        return box.get(key);
      else
        throw Exception('box: $boxKey is empty');
    } catch (_) {
      rethrow;
    }
  }

  @override
  List<BloodPressureModel> getAll() {
    try {
      if (checkBox())
      // return map.map((e) => BloodPressureModel.fromJson(e)).toList();
      {
        return box.values.toList();
      } else
        return [];
    } catch (_) {
      rethrow;
    }
  }

  @override
  BloodPressureModel getLatestMeasurement() {
    try {
      if (checkBox(true)) {
        List<BloodPressureModel> list = getAll();
        list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
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
    int userId = getIt<ProfileStorageImpl>().getFirst().id ?? 0;

    final AddBpWithDetail addBpWithDetail = AddBpWithDetail(
        deviceUuid: data.deviceUUID,
        dia: data.dia,
        entegrationId: userId,
        isManual: data.isManual,
        note: data.note,
        occurrenceTime: data.dateTime,
        pulse: data.pulse,
        sys: data.sys);
    try {
      return (await getIt<ChronicTrackingRepository>()
              .insertNewBpValue(addBpWithDetail))
          .datum;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> update(BloodPressureModel data, key) async {
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
    int userId = getIt<ProfileStorageImpl>().getFirst().id ?? 0;

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
        sys: data.sys);
    try {
      (await getIt<ChronicTrackingRepository>()
              .updateBpMeasurement(updateBpMeasurements))
          .datum;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> write(BloodPressureModel data,
      {bool shouldSendToServer = false}) async {
    try {
      if (checkBox()) {
        if (shouldSendToServer) {
          int id;
          id = await sendToServer(data);
          data.measurementId = id;
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
  Future<bool> writeAll(List<BloodPressureModel> data) async {
    try {
      if (checkBox()) {
        await box.addAll(data);
        return true;
      } else {
        throw Exception('unhandled exception on box:$boxKey');
      }
    } catch (e) {
      rethrow;
    }
  }

  checkLastBp() async {
    var list = (await getBpValues(count: 1));
    if (list.isNotEmpty) {
      final lastData = list.last;
      if (getLatestMeasurement() == null ||
          box.values.length < 5 ||
          !lastData.isEqual(getLatestMeasurement())) {
        box.clear();
        getAndWriteBpData();
      }
    }
  }

  Future<List<BloodPressureModel>> getBpValues(
      {DateTime beginDate, DateTime endDate, int count}) async {
    try {
      GetBpMeasurements getScaleMasurementBody = GetBpMeasurements(
          entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
          beginDate: beginDate,
          endDate: endDate,
          count: count);

      final response = await getIt<ChronicTrackingRepository>()
          .getBpDataOfPerson(getScaleMasurementBody);

      List datum = response.datum;
      List<BloodPressureModel> bpDataList = <BloodPressureModel>[];
      for (var scaleMeasurement in datum) {
        bpDataList.add(BloodPressureModel.fromJson(scaleMeasurement));
      }
      return bpDataList;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getAndWriteBpData(
      {DateTime beginDate, DateTime endDate, int count = 20}) async {
    var list =
        await getBpValues(beginDate: beginDate, endDate: endDate, count: count);
    if (list.isNotEmpty) {
      var _dubItem = 0;
      for (var glucose in list) {
        if (doesExist(glucose)) _dubItem++;
      }
      if (_dubItem != list.length) {
        await writeAll(list);
        notifyListeners();
        return false;
      } else
        return false;
    } else {
      return true;
    }
  }

  @override
  void clear() => box.clear();
}
