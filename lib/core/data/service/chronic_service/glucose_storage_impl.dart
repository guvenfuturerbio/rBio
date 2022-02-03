// ignore_for_file: overridden_fields

part of 'chronic_storage_service.dart';

class GlucoseStorageImpl extends ChronicStorageService<GlucoseData> {
  @override
  final String boxKey = 'GlucoseBox';
  bool _hasProgress = false;

  @override
  Future<void> init() async {
    box = await Hive.openBox<GlucoseData>(boxKey);
  }

  @override
  late Box<GlucoseData> box;

  @override
  Future<bool> delete(dynamic key) async {
    if (box.isOpen && box.isNotEmpty && box.containsKey(key)) {
      final GlucoseData? data = box.get(key);
      if (data != null) {
        await deleteFromServer(
          data.time,
          DeleteBloodGlucoseMeasurementRequest(
            entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
            measurementId: data.measurementId,
          ).toJson(),
        );
        box.delete(key);
        notifyListeners();
        return true;
      }

      throw Exception("data null");
    } else {
      return false;
    }
  }

  @override
  List<GlucoseData> getAll() {
    if (box.isOpen && box.isNotEmpty) {
      return box.values.toList();
    } else {
      return [];
    }
  }

  @override
  Future<bool> update(GlucoseData data, dynamic key) async {
    if (box.isOpen && box.isNotEmpty) {
      final GlucoseData? dataFromBox = get(key);

      if (dataFromBox != null && !data.isEqual(dataFromBox)) {
        await box.put(key, data);
        await updateServer(data);
        notifyListeners();
      } else {
        throw Exception('could not find data in the bpx');
      }

      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> write(
    GlucoseData data, {
    bool shouldSendToServer = false,
  }) async {
    if (box.isOpen && !doesExist(data)) {
      if (shouldSendToServer) {
        var id = await sendToServer(data);
        data.measurementId = id;
        await box.add(data);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> writeAll(List<GlucoseData> data) async {
    try {
      if (box.isOpen) {
        List<GlucoseData> _glucoseDataList = <GlucoseData>[];
        for (var item in data) {
          if (!doesExist(item)) {
            _glucoseDataList.add(item);
          }
        }
        await box.addAll(_glucoseDataList);
        return true;
      } else {
        return false;
      }
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      rethrow;
    }
  }

  @override
  GlucoseData? get(key) {
    if (box.isNotEmpty && box.isNotEmpty) {
      return box.getAt(key);
    } else {
      return null;
    }
  }

  @override
  GlucoseData? getLatestMeasurement() {
    if (box.isOpen && box.isNotEmpty) {
      List<GlucoseData> list = box.values.toList();

      list.sort((a, b) => b.date.compareTo(a.date));

      return list[0];
    }
    return null;
  }

  void updateImage(String path, key) {
    try {
      GlucoseData? data = get(key);
      if (data != null) {
        data.imageURL = path;
        update(data, key);
        sendImageToServer(path, data.measurementId!);
      } else {
        throw Exception('could not find correct data in the bpx');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getAndWriteGlucoseData(
      {DateTime? beginDate, DateTime? endDate, int? count}) async {
    if (!_hasProgress) {
      _hasProgress = true;
      var glucoseDataList = await getBloodGlucoseDataOfPerson(
          start: beginDate, end: endDate, count: count ?? 20);
      if (glucoseDataList.isNotEmpty) {
        var _dubItem = 0;
        for (var glucose in glucoseDataList) {
          if (doesExist(glucose)) _dubItem++;
        }
        if (_dubItem != glucoseDataList.length) {
          await writeAll(glucoseDataList);

          notifyListeners();
          _hasProgress = false;
          return false;
        } else {
          _hasProgress = false;
        }
        return false;
      } else {
        _hasProgress = false;
        return true;
      }
    }
    return false;
  }

  Future<void> checkLastGlucoseData() async {
    var list = (await getBloodGlucoseDataOfPerson(count: 1));
    if (list.isNotEmpty) {
      final lastData = list.last;
      if (getLatestMeasurement() == null ||
          !lastData.isEqual(getLatestMeasurement()!)) {
        box.clear();
        getAndWriteGlucoseData();
      }
    }
  }

  @override
  bool doesExist(GlucoseData data) {
    return box.values.contains(data);
  }

  @override
  Future<void> deleteFromServer(
      int timeKey, Map<String, dynamic> deleteMeasurementRequest) async {
    try {
      getIt<ChronicTrackingRepository>().deleteBloodGlucoseValue(
          DeleteBloodGlucoseMeasurementRequest.fromJson(
              deleteMeasurementRequest));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<int> sendToServer(GlucoseData data) async {
    final DateTime dt = DateTime.fromMillisecondsSinceEpoch(data.time);
    final int userId = getIt<ProfileStorageImpl>().getFirst().id;
    final String dtFrmt = dt.toString();
    final BloodGlucoseValue bloodGlucoseValue = BloodGlucoseValue(
      deviceUUID: data.deviceUUID,
      isManual: data.manual,
      id: userId,
      value: data.level,
      valueNote: data.note,
      detail: BloodGlucoseValueDetail(time: dtFrmt, tag: data.tag),
    );

    try {
      final datum = (await getIt<ChronicTrackingRepository>()
              .insertNewBloodGlucoseValue(bloodGlucoseValue))
          .datum;

      if (datum is int?) {
        if (datum == null) {
          throw Exception("datum null");
        } else {
          return datum;
        }
      }

      throw Exception("datum isn't int");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future updateServer(GlucoseData data) async {
    try {
      await getIt<ChronicTrackingRepository>().updateBloodGlucoseValue(
        UpdateBloodGlucoseMeasurementRequest(
          entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
          measurementId: data.measurementId,
          tag: data.tag,
          value: int.parse(data.level),
          type: "mg",
          note: data.note,
          date: data.date,
        ),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> sendImageToServer(String imagePath, int measurementId) async {
    try {
      await getIt<ChronicTrackingRepository>().uploadMeasurementImage(
        imagePath,
        getIt<ProfileStorageImpl>().getFirst().id,
        measurementId,
      );
    } catch (_) {
      rethrow;
    }
  }

  String getImagePathOfImageURL(String imageURL) {
    return "${getIt<GuvenSettings>().appDocDirectory}/$imageURL";
  }

  Future<List<GlucoseData>> getBloodGlucoseDataOfPerson({
    DateTime? start,
    DateTime? end,
    int count = 20,
  }) async {
    try {
      final entegrationId = getIt<ProfileStorageImpl>().getFirst().id;
      final GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson =
          GetBloodGlucoseDataOfPerson(
        id: entegrationId,
        start: start?.toIso8601String(),
        end: end?.toIso8601String(),
        count: count,
      );

      final response = await getIt<ChronicTrackingRepository>()
          .getBloodGlucoseDataOfPerson(getBloodGlucoseDataOfPerson);
      final datum = response.datum;
      if (datum is Map<String, dynamic>?) {
        if (datum != null) {
          final list = datum["blood_glucose_measurement_details"];
          if (list == null) {
            throw Exception("blood_glucose_measurement_details list null");
          }

          if (list is List<Map<String, dynamic>>) {}

          final List<GlucoseData> glucoseDataList = [];
          for (final bgMeasurement in list) {
            final int time =
                DateTime.parse(bgMeasurement["detail"]["occurrence_time"])
                    .millisecondsSinceEpoch;
            String level = bgMeasurement["blood_glucose_measurement"]["value"];
            String note =
                bgMeasurement["blood_glucose_measurement"]["value_note"];

            int tag = bgMeasurement["tag"]["id"];
            bool manual = bgMeasurement["is_manuel"];
            String deviceId = bgMeasurement['device_id'];
            int measurementId = bgMeasurement["id"];
            GlucoseData glucoseData = GlucoseData(
                time: time,
                userId: entegrationId,
                level: level,
                note: note,
                tag: tag,
                manual: manual,
                measurementId: measurementId,
                device: 103,
                deviceUUID: deviceId);
            glucoseDataList.add(glucoseData);
          }
          return glucoseDataList;
        }
      }
      return [];
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return [];
    }
  }

  checkUserDatas(int uid) {
    if (box.isOpen && box.isNotEmpty) {
      if (box.values.first.userId != uid) {
        box.clear();
      }
    }
  }

  @override
  void clear() => box.clear();
}
