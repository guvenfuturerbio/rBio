import 'package:hive_flutter/hive_flutter.dart';

import '../scale_hive_impl.dart';

class ScaleHiveImpl {
  late Box<ScaleHiveModel> box;

  Future<void> init(String boxKey) async {
    box = await Hive.openBox<ScaleHiveModel>(boxKey);
  }

  Future<bool> deleteScaleData(String millisecondsSinceEpoch) async {
    try {
      if (boxIsOpen()) {
        await box.delete(millisecondsSinceEpoch);
        return true;
      } else {
        throw const HiveScaleBoxClosedException();
      }
    } catch (e) {
      throw const HiveScaleFailedToDeleteException();
    }
  }

  Future<List<ScaleHiveModel>> readScaleData() async {
    try {
      if (boxIsOpen()) {
        return box.values.toList();
      } else {
        throw const HiveScaleBoxClosedException();
      }
    } catch (e) {
      throw const HiveScaleFailedToReadException();
    }
  }

  Future<bool> updateScaleData(
      ScaleHiveModel newModel, String millisecondsSinceEpoch) async {
    try {
      if (boxIsOpen()) {
        await box.put(millisecondsSinceEpoch, newModel);
        return true;
      } else {
        throw const HiveScaleBoxClosedException();
      }
    } catch (e) {
      throw const HiveScaleFailedToUpdateException();
    }
  }

  Future<String> writeScaleData(ScaleHiveModel model) async {
    try {
      if (boxIsOpen()) {
        await box.put(model.occurrenceTime, model);
        return model.occurrenceTime;
      } else {
        throw const HiveScaleBoxClosedException();
      }
    } catch (e) {
      throw const HiveScaleFailedToWriteException();
    }
  }

  bool boxIsOpen() => !box.isOpen ? false : true;
}
