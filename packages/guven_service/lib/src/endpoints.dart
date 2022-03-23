part of 'guven_service.dart';

class _Endpoints {
  final KeyManager keyManager;

  _Endpoints(this.keyManager);

  // #region Scale
  String get insertNewScaleValue =>
      '/Measurement/add-bmi-with-detail'.xDevApiTest(keyManager);
  String get deleteScaleMeasurement =>
      '/Measurement/delete-bmi-with-detail'.xDevApiTest(keyManager);
  String get getScaleMeasurement =>
      '/Measurement/get-bmi-measurements'.xDevApiTest(keyManager);
  String get updateScaleMeasurement =>
      '/Measurement/update-bmi-measurement'.xDevApiTest(keyManager);
  // #endregion
}

extension _EndpointsExtension on String {
  String xDevApiTest(KeyManager keyManager) {
    final String? path = keyManager.get(Keys.devApiTest);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xCronicTracking null');
    }
  }
}
