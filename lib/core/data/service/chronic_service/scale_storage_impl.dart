part of 'chronic_storage_service.dart';

class ScaleStorageImpl extends ChronicStorageService<ScaleModel> {
  @override
  Box<ScaleModel> box;

  @override
  final String boxKey = 'ScaleBox';

  @override
  Future<void> init() async {
    box = await Hive.openBox<ScaleModel>(boxKey);
  }

  @override
  Future<bool> delete(key) async {
    try {
      if (checkBox(true) && box.containsKey(key)) {
        ScaleModel data = box.get(key);
        await deleteFromServer(
            data.time,
            DeleteScaleMasurementBody(
                    entegrationId: UserProfilesNotifier().selection.id,
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
      await getIt<ChronicTrackingRepository>().deleteScaleMeasurement(
          DeleteScaleMasurementBody.fromJson(deleteMeasurementRequest));
    } catch (_) {
      rethrow;
    }
  }

  @override
  bool doesExist(ScaleModel data) {
    return box.values.contains(data);
  }

  @override
  ScaleModel get(key) {
    try {
      return box.get(key);
    } catch (_) {
      rethrow;
    }
  }

  @override
  List<ScaleModel> getAll() {
    try {
      if (checkBox(true)) {
        return box.values.toList();
      } else {
        return [];
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  ScaleModel getLatestMeasurement() {
    try {
      if (checkBox(true)) {
        List<ScaleModel> list = box.values.toList();
        list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        return list[0];
      }
      return null;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future sendToServer(ScaleModel data) async {
    int userId = UserProfilesNotifier().selection?.id ?? 0;

    AddScaleMasurementBody addScaleMasurementBody = new AddScaleMasurementBody(
      bmh: data.bmh,
      bodyFat: data.bodyFat,
      bmi: data.bmi,
      boneMass: data.boneMass,
      entegrationId: userId,
      muscle: data.muscle,
      note: data.note,
      occurrenceTime: data.dateTime,
      scaleUnit: data.unit != null || data.unit != ScaleUnit.KG ? 1 : 0,
      visceralFat: data.visceralFat,
      water: data.water,
      weight: data.weight,
    );
    try {
      return (await getIt<ChronicTrackingRepository>()
              .insertNewScaleValue(addScaleMasurementBody))
          .datum;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> update(ScaleModel data, key) async {
    try {
      if (checkBox(true)) {
        ScaleModel scaleModelFromBox = get(key);
        print(scaleModelFromBox.key);

        if (!scaleModelFromBox.isEqual(data)) {
          await updateServer(data);
          box.put(key, data);

          notifyListeners();
        }
        return true;
      } else {
        return false;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future updateServer(ScaleModel data) async {
    int userId = UserProfilesNotifier().selection?.id ?? 0;

    UpdateScaleMasurementBody updateScaleMasurementBody =
        UpdateScaleMasurementBody(
            id: data.measurementId,
            bmh: data.bmh,
            bodyFat: data.bodyFat,
            bmi: data.bmi,
            boneMass: data.boneMass,
            entegrationId: userId,
            muscle: data.muscle,
            note: data.note,
            occurrenceTime: data.dateTime,
            scaleUnit: data.unit != null || data.unit != ScaleUnit.KG ? 1 : 0,
            visceralFat: data.visceralFat,
            water: data.water,
            weight: data.weight,
            kioskMeasurementId: 0);
    print(updateScaleMasurementBody.toJson());
    try {
      return (await getIt<ChronicTrackingRepository>()
              .updateScaleMeasurement(updateScaleMasurementBody))
          .datum;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> write(ScaleModel data, {bool shouldSendToServer = false}) async {
    try {
      if (box.isOpen && !doesExist(data)) {
        if (shouldSendToServer) {
          var id = await sendToServer(data);
          data.measurementId = id;
        }
        box.add(data);
        print("here");
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<List<ScaleModel>> getScaleDatas(
      {DateTime beginDate, DateTime endDate, int count}) async {
    try {
      GetScaleMasurementBody getScaleMasurementBody = GetScaleMasurementBody(
          entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
          beginDate: beginDate,
          endDate: endDate,
          count: count);

      final response = await getIt<ChronicTrackingRepository>()
          .getScaleDataOfPerson(getScaleMasurementBody);

      List datum = response.datum;
      List<ScaleModel> scaleDataList = <ScaleModel>[];
      for (var scaleMeasurement in datum) {
        scaleDataList.add(ScaleModel.fromMap(scaleMeasurement));
      }
      return scaleDataList;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getAndWriteScaleData(
      {DateTime beginDate, DateTime endDate, int count = 20}) async {
    var list = await getScaleDatas(
        beginDate: beginDate, endDate: endDate, count: count);
    if (list.isNotEmpty) {
      writeAll(list);
      return false;
    } else {
      return true;
    }
  }

  checkLastScale() async {
    var lastData = (await getScaleDatas(count: 1))[0];

    if (getLatestMeasurement() == null ||
        !lastData.isEqual(getLatestMeasurement())) {
      box.clear();
      getAndWriteScaleData();
    }
  }

  @override
  bool writeAll(List<ScaleModel> dataList) {
    try {
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
    } catch (_) {
      rethrow;
    }
  }

  String getImagePathOfImageURL(String imageURL) {
    return "${imageURL}";
  }

  checkBox([bool checkIsEmpty = false]) {
    if (!box.isOpen)
      throw Exception('Box can\'t open please check your box!!!');
    if (checkIsEmpty) {
      return box.isNotEmpty;
    } else
      return true;
  }
}
