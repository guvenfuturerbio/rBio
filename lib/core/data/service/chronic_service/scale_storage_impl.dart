part of 'chronic_storage_service.dart';

class ScaleStorageImpl extends ChronicStorageService<ScaleModel> {
  @override
  late Box<ScaleModel> box;

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
  final String boxKey = 'ScaleBox';

  @override
  Future<void> init() async {
    box = await Hive.openBox<ScaleModel>(boxKey);

    health = HealthFactory();

    types = [
      HealthDataType.BODY_MASS_INDEX,
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.WEIGHT,
    ];
  }

  @override
  Future<bool> delete(key) async {
    try {
      if (checkBox(true) && box.containsKey(key)) {
        ScaleModel? data = box.get(key);
        if (data != null) {
          await deleteFromServer(
            data.time!,
            DeleteScaleMasurementBody(
              entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
              measurementId: data.measurementId,
            ).toJson(),
          );

          await box.delete(key);
          notifyListeners();
          return true;
        } else {
          throw Exception('Does not contain data from the box');
        }
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
      await getIt<ChronicTrackingRepository>().deleteScaleMeasurement(
          DeleteScaleMasurementBody.fromJson(deleteMeasurementRequest));
    } catch (_) {
      rethrow;
    }
  }

  @override
  bool doesExist(ScaleModel data) {
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
  ScaleModel? get(key) {
    try {
      if (checkBox(true)) {
        return box.get(key);
      } else {
        return null;
      }
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
  ScaleModel? getLatestMeasurement() {
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
    int userId = getIt<ProfileStorageImpl>().getFirst().id ?? 0;

    AddScaleMasurementBody addScaleMasurementBody = AddScaleMasurementBody(
      bmh: data.bmh,
      bodyFat: data.bodyFat,
      bmi: data.bmi,
      boneMass: data.boneMass,
      entegrationId: userId,
      muscle: data.muscle,
      note: data.note,
      occurrenceTime: data.dateTime,
      scaleUnit: data.unit != null || data.unit != ScaleUnit.kg ? 1 : 0,
      visceralFat: data.visceralFat,
      water: data.water,
      weight: data.weight,
      isManuel: data.isManuel,
      deviceUUID: data.device?["deviceId"] ?? 'manual',
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
        ScaleModel? scaleModelFromBox = get(key);

        if (scaleModelFromBox != null && !scaleModelFromBox.isEqual(data)) {
          await updateServer(data);
          await box.put(key, data);

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
    int userId = getIt<ProfileStorageImpl>().getFirst().id ?? 0;

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
      scaleUnit: data.unit != null || data.unit != ScaleUnit.kg ? 1 : 0,
      visceralFat: data.visceralFat,
      water: data.water,
      weight: data.weight,
      kioskMeasurementId: 0,
    );

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
        if (!data.isFromHealth) {
          await health!.requestAuthorization(types, permissions: perm);

          if (data.weight != null) {
            await health!.writeHealthData(
              data.weight!,
              HealthDataType.WEIGHT,
              data.dateTime,
              data.dateTime,
            );
          }

          if (data.bmi != null) {
            await health!.writeHealthData(
              data.bmi!,
              HealthDataType.BODY_MASS_INDEX,
              data.dateTime,
              data.dateTime,
            );
          }

          if (data.bodyFat != null) {
            await health!.writeHealthData(
              data.bodyFat!,
              HealthDataType.BODY_FAT_PERCENTAGE,
              data.dateTime,
              data.dateTime,
            );
          }
        }

        if (shouldSendToServer) {
          var id = await sendToServer(data);
          data.measurementId = id;
        }

        await box.add(data);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<List<ScaleNetworkModel>> getScaleNetworkDatas({
    DateTime? beginDate,
    DateTime? endDate,
    int? count,
  }) async {
    try {
      GetScaleMasurementBody getScaleMasurementBody = GetScaleMasurementBody(
        entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
        beginDate: beginDate,
        endDate: endDate,
        count: count,
      );

      final response = await getIt<ChronicTrackingRepository>()
          .getScaleDataOfPerson(getScaleMasurementBody);
      var datum = response.datum as List<dynamic>? ?? [];
      List<ScaleNetworkModel> scaleDataList = <ScaleNetworkModel>[];
      for (var scaleMeasurement in datum) {
        scaleDataList.add(ScaleNetworkModel.fromJson(scaleMeasurement));
      }
      return scaleDataList;
    } catch (e) {
      LoggerUtils.instance.e(e);
      rethrow;
    }
  }

  Future<bool> getAndWriteScaleData({
    DateTime? beginDate,
    DateTime? endDate,
    int count = 20,
  }) async {
    if (!_hasProgress) {
      _hasProgress = true;
      var list = await getScaleNetworkDatas(
        beginDate: beginDate,
        endDate: endDate,
        count: count,
      );

      if (list.isNotEmpty) {
        var _dubItem = 0;
        for (var scale in list) {
          if (doesExist(scale.xToScaleModel())) {
            _dubItem++;
          }
        }

        if (_dubItem != list.length) {
          final scaleList = list.map((e) => e.xToScaleModel()).toList();
          await writeAll(scaleList);
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

  /// mt_home_vm'de kişiye ait son veriyi api'den getir
  /// Box'da veri yoksa, eleman sayısı 5'ten azsa veya apiden gelen son kayıt ile box'daki son kayıt aynıysa, hive'i güncelle
  Future<void> checkLastScale() async {
    var list = (await getScaleNetworkDatas(count: 1));
    if (list.isNotEmpty) {
      final lastData = list.last.xToScaleModel();
      if (getLatestMeasurement() == null ||
          box.values.length < 5 ||
          !lastData.isEqual(getLatestMeasurement()!)) {
        await box.clear();
        await getAndWriteScaleData();
      }
    }
  }

  @override
  Future<bool> writeAll(
    List<ScaleModel> data, {
    bool isFromHealth = false,
  }) async {
    try {
      if (box.isOpen) {
        for (var item in data) {
          await write(item, shouldSendToServer: true);
          // if (!doesExist(item)) {
          //   if (isFromHealth) {
          //     var id = await sendToServer(item);
          //     item.measurementId = id;
          //   }
          //   await box.add(item);
          // }
        }

        return true;
      } else {
        return false;
      }
    } catch (_) {
      rethrow;
    }
  }

  String getImagePathOfImageURL(String imageURL) {
    return imageURL;
  }

  bool checkBox([bool checkIsEmpty = false]) {
    if (!box.isOpen) {
      throw Exception('Box can\'t open please check your box!!!');
    }

    if (checkIsEmpty) {
      return box.isNotEmpty;
    } else {
      return true;
    }
  }

  @override
  void clear() => box.clear();
}
