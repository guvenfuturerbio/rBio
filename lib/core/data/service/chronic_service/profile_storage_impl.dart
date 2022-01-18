part of 'chronic_storage_service.dart';

class ProfileStorageImpl extends ChronicStorageService<Person> {
  @override
  String boxKey = 'PersonData';

  @override
  Box<Person> box;

  @override
  Future<bool> delete(key) async {
    if (box.isNotEmpty) {
      box.delete(key);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future deleteFromServer(
      int timeKey, Map<String, dynamic> deleteMeasurementRequest) {
    throw UnimplementedError();
  }

  @override
  bool doesExist(Person data) {
    if (box.isNotEmpty) {
      return box.values.contains(data);
    } else {
      return false;
    }
  }

  @override
  Person get(key) {
    try {
      checkBox();

      if (box.isNotEmpty) {
        return box.get(key);
      } else {
        return null;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  List<Person> getAll() {
    checkBox();

    if (box.isNotEmpty) {
      return box.values.toList();
    } else {
      return null;
    }
  }

  Person getFirst() {
    checkBox();
    if (box.isNotEmpty) {
      return box.values.first;
    } else {
      return Person().fromDefault();
    }
  }

  @override
  Person getLatestMeasurement() {
    return null;
  }

  @override
  Future<void> init() async {
    box = await Hive.openBox<Person>(boxKey);
  }

  @override
  Future sendToServer(Person data) async {
    await getIt<ChronicTrackingRepository>().addProfile(data);
  }

  @override
  Future<bool> update(Person data, key) async {
    try {
      checkBox();
      if (box.isNotEmpty) {
        var person = get(key);
        if (!person.isEqual(data)) {
          await updateServer(data);
          box.put(key, data);
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  bool updateFromTreatment(Person data) {
    try {
      checkBox();
      if (box.isNotEmpty) {
        box.put(0, data);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateServer(Person data) async {
    try {
      data.isFirstUser = false;
      data.userId = -1;
      await getIt<ChronicTrackingRepository>().updateProfile(data, data.id);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> write(Person data, {bool shouldSendToServer = false}) async {
    try {
      checkBox();
      if (!doesExist(data)) {
        if (box.isEmpty) {
          await box.add(data);
        } else {
          box.putAt(0, data);
        }
        if (shouldSendToServer) await sendToServer(data);
      } else {
        print('here');
      }
      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> writeAll(List<Person> data) {
    throw UnimplementedError();
  }

  checkBox() {
    if (!box.isOpen)
      throw Exception('Box can\'t open please check your box!!!');
  }

  @override
  void clear() => box.clear();
}
