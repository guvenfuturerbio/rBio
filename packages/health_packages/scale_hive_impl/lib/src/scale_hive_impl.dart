import 'package:hive_flutter/hive_flutter.dart';

import 'package:scale_api/scale_api.dart';

import 'exceptions.dart';

class ScaleHiveImpl extends ScaleApi {
  late Box<ScaleModel> box;

  Future<void> init(String boxKey) async {
    box = await Hive.openBox<ScaleModel>(boxKey);
  }

  @override
  Future<bool> deleteScaleData(int millisecondsSinceEpoch) async {
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

  @override
  Future<List<ScaleModel>> readScaleData() async {
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

  @override
  Future<bool> updateScaleData(
      ScaleModel newModel, int millisecondsSinceEpoch) async {
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

  @override
  Future<int> writeScaleData(ScaleModel model) async {
    try {
      if (boxIsOpen()) {
        await box.put(model.dateTime.millisecondsSinceEpoch, model);
        return model.dateTime.millisecondsSinceEpoch;
      } else {
        throw const HiveScaleBoxClosedException();
      }
    } catch (e) {
      throw const HiveScaleFailedToWriteException();
    }
  }

  bool boxIsOpen() => !box.isOpen ? false : true;
}
