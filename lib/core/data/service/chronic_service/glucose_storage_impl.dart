part of 'chronic_storage_service.dart';

class GlucoseStorageImpl extends ChronicStorageService<GlucoseData> {
  @override
  final String boxKey = 'GlucoseBox';

  @override
  Future<void> init() async {
    if (!Atom.isWeb) {
      final appDocumentDirectory = await getApplicationDocumentsDirectory();

      _localDirectoryPath = appDocumentDirectory.path;
      Hive.init(_localDirectoryPath);
    }
    Hive..registerAdapter(GlucoseDataAdapter());

    box = await Hive.openBox<GlucoseData>(boxKey);
  }

  @override
  Box<GlucoseData> box;
  @override
  Future<bool> delete(key) async {
    if (box.isOpen && box.isNotEmpty && box.containsKey(key)) {
      GlucoseData data = box.get(key);
      await deleteFromServer(
          data.time,
          DeleteBloodGlucoseMeasurementRequest(
                  entegrationId: UserProfilesNotifier().selection.id,
                  measurementId: data.measurementId)
              .toJson());
      box.delete(key);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @override
  List<GlucoseData> getAll() {
    if (box.isOpen && box.isNotEmpty) {
      for (var item in box.values) {
        debugPrint(item.toMap().toString());
      }
      return box.values.toList();
    } else {
      return [];
    }
  }

  @override
  Future<bool> update(GlucoseData data, key) async {
    if (box.isOpen && box.isNotEmpty) {
      GlucoseData glusoceDataFromBox = get(key);
      glusoceDataFromBox = data;
      glusoceDataFromBox.save();
      await updateServer(data);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> write(GlucoseData data,
      {bool shouldSendToServer = false}) async {
    print(data.toMap().toString());
    if (box.isOpen && !doesExist(data)) {
      if (shouldSendToServer) {
        var id = await sendToServer(data);
        data.measurementId = id;
        box.add(data);
      }

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @override
  bool writeAll(List<GlucoseData> dataList) {
    if (box.isOpen) {
      for (var data in dataList) {
        if (!doesExist(data)) {
          box.add(data);
        }
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @override
  GlucoseData get(key) {
    if (box.isNotEmpty && box.isNotEmpty) {
      return box.getAt(key);
    } else {
      return null;
    }
  }

  @override
  GlucoseData getLatestMeasurement() {
    List<GlucoseData> list = box.values.toList();

    list.sort((a, b) => b.date.compareTo(a.date));

    return list[0];
  }

  updateImage(String path, key) {
    try {
      GlucoseData data = get(key);
      data.imageURL = path;
      update(data, key);
      sendImageToServer(path, data.measurementId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool doesExist(GlucoseData data) {
    return box.values.contains(data);
  }

  @override
  Future<void> deleteFromServer(int timeKey,
      Map<String, dynamic> deleteBloodGlucoseMeasurementRequest) async {
    try {
      getIt<ChronicTrackingRepository>().deleteBloodGlucoseValue(
          DeleteBloodGlucoseMeasurementRequest.fromJson(
              deleteBloodGlucoseMeasurementRequest));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<int> sendToServer(GlucoseData data) async {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(data.time);
    int userId = UserProfilesNotifier().selection?.id ?? 0;
    String dtFrmt = dt.toString();
    BloodGlucoseValue bloodGlucoseValue = new BloodGlucoseValue(
        deviceUUID: data.deviceUUID,
        isManual: data.manual,
        id: userId,
        value: data.level,
        valueNote: data.note,
        detail: new BloodGlucoseValueDetail(time: dtFrmt, tag: data.tag));
    try {
      return (await getIt<ChronicTrackingRepository>()
              .insertNewBloodGlucoseValue(bloodGlucoseValue))
          .datum;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future updateServer(GlucoseData glucoseData) async {
    try {
      await getIt<ChronicTrackingRepository>().updateBloodGlucoseValue(
          UpdateBloodGlucoseMeasurementRequest(
              entegrationId: UserProfilesNotifier().selection.id,
              measurementId: glucoseData.measurementId,
              tag: glucoseData.tag,
              value: int.parse(glucoseData.level),
              type: "mg",
              note: glucoseData.note,
              date: glucoseData.date));
    } catch (_) {
      rethrow;
    }
  }

  Future<void> sendImageToServer(String imagePath, int measurementId) async {
    try {
      await getIt<ChronicTrackingRepository>().uploadMeasurementImage(
          imagePath, UserProfilesNotifier().selection.id ?? 0, measurementId);
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  String _localDirectoryPath = "";
  String getImagePathOfImageURL(String imageURL) {
    return "${_localDirectoryPath}/${imageURL}";
  }

  Future<void> getBloodGlucoseDataOfPerson(Person pd) async {
    try {
      GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson =
          GetBloodGlucoseDataOfPerson(
        id: pd.id,
        start: "01.01.2011",
        end: "01.01.2025",
      );

      final response = await getIt<ChronicTrackingRepository>()
          .getBloodGlucoseDataOfPerson(getBloodGlucoseDataOfPerson);
      List datum = response.datum["blood_glucose_measurement_details"];
      List<GlucoseData> glucoseDataList = new List();
      for (var bgMeasurement in datum) {
        int time = DateTime.parse(bgMeasurement["detail"]["occurrence_time"])
            .millisecondsSinceEpoch;
        String level = bgMeasurement["blood_glucose_measurement"]["value"];
        String note = bgMeasurement["blood_glucose_measurement"]["value_note"];
        int tag = bgMeasurement["tag"]["id"];
        bool manual = bgMeasurement["is_manuel"];
        int measurementId = bgMeasurement["id"];
        GlucoseData glucoseData = new GlucoseData(
          time: time,
          userId: pd.id,
          level: level,
          note: note,
          tag: tag,
          manual: manual,
          measurementId: measurementId,
          device: 103,
        );
        glucoseDataList.add(glucoseData);
      }
      writeAll(glucoseDataList);
    } catch (e) {
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
}
