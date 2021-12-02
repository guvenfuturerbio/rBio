part of 'chronic_storage_service.dart';

class ScaleStorageImpl extends ChronicStorageService<ScaleModel> {
  @override
  Box<ScaleModel> box;

  @override
  final String boxKey = 'ScaleBox';

  @override
  Future<void> init() async {
    Hive..registerAdapter(ScaleModelAdapter());
    box = await Hive.openBox<ScaleModel>(boxKey);
  }

  @override
  Future<bool> delete(key) async {
    try {
      if (checkBox(true) && box.containsKey(key)) {
        ScaleModel data = box.get(key);
        //await deleteFromServer(data.time,{});
        box.delete(key);
        notifyListeners();
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteFromServer(
      int timeKey, Map<String, dynamic> deleteMeasurementRequest) {
    // TODO: implement deleteFromServer
    throw UnimplementedError();
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
  Future sendToServer(ScaleModel data) {}

  @override
  Future<bool> update(ScaleModel data, key) async {
    try {
      if (checkBox(true)) {
        ScaleModel scaleModelFromBox = get(key);
        if (!scaleModelFromBox.isEqual(data)) {
          box.put(key, data);
          //await updateServer(data);
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
  Future updateServer(ScaleModel data) {
    // TODO: implement updateServer
    throw UnimplementedError();
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
