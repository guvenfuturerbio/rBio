import 'package:onedosehealth/core/core.dart';

abstract class ScaleApi {
  Future<bool> deleteScaleData(int millisecondsSinceEpoch);
  Future<List<ScaleModel>> readScaleData();
  Future<bool> updateScaleData(ScaleModel newModel, int millisecondsSinceEpoch);
  Future<int> writeScaleData(ScaleModel model);
}
