import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../scale_dependencies.dart';

class ScaleHiveImpl {
  late Box<ScaleHiveModel> _box;

  Future<void> init(String boxKey) async {
    _box = await Hive.openBox<ScaleHiveModel>(boxKey);
  }

  ValueListenable<Box<ScaleHiveModel>> get listenable => _box.listenable();

  Stream<BoxEvent> get watch => _box.watch();

  Future<int> clear() async => _box.clear();

  bool boxIsOpen() => !_box.isOpen ? false : true;

  Future<bool> deleteScaleMeasurement(String millisecondsSinceEpoch) async {
    try {
      if (boxIsOpen()) {
        await _box.delete(millisecondsSinceEpoch);
        return true;
      } else {
        throw const ScaleHiveBoxClosedException();
      }
    } catch (e) {
      throw const ScaleHiveFailedToDeleteException();
    }
  }

  List<ScaleHiveModel> readScaleData() {
    try {
      if (boxIsOpen()) {
        return _box.values.toList();
      } else {
        throw const ScaleHiveBoxClosedException();
      }
    } catch (e) {
      throw const ScaleHiveFailedToReadException();
    }
  }

  Future<bool> updateScaleData(
      ScaleHiveModel newModel, String millisecondsSinceEpoch) async {
    try {
      if (boxIsOpen()) {
        await _box.put(millisecondsSinceEpoch, newModel);
        return true;
      } else {
        throw const ScaleHiveBoxClosedException();
      }
    } catch (e) {
      throw const ScaleHiveFailedToUpdateException();
    }
  }

  Future<String> addScaleMeasurement(ScaleHiveModel model) async {
    try {
      if (boxIsOpen()) {
        await _box.put(model.occurrenceTime, model);
        return model.occurrenceTime;
      } else {
        throw const ScaleHiveBoxClosedException();
      }
    } catch (e) {
      throw const ScaleHiveFailedToWriteException();
    }
  }

  Future<void> addScaleListMeasurement(List<ScaleHiveModel> list) async {
    try {
      if (boxIsOpen()) {
        for (var item in list) {
          await addScaleMeasurement(item);
        }
      } else {
        throw const ScaleHiveBoxClosedException();
      }
    } catch (e) {
      throw const ScaleHiveFailedToWriteException();
    }
  }
}
