part of 'guven_service.dart';

class _Endpoints {
  final KeyManager keyManager;

  _Endpoints(this.keyManager);

  // #region Scale
  String get insertNewScaleValue =>
      '/Measurement/add-bmi-with-detail'.xCronicTracking(keyManager);
  String get deleteScaleMeasurement =>
      '/Measurement/delete-bmi-with-detail'.xCronicTracking(keyManager);
  String get getScaleMeasurement =>
      '/Measurement/get-bmi-measurements'.xCronicTracking(keyManager);
  String get updateScaleMeasurement =>
      '/Measurement/update-bmi-measurement'.xCronicTracking(keyManager);
  // #endregion
}

extension _EndpointsExtension on String {
  String xBasePath(KeyManager keyManager) {
    final String? path = keyManager.get(Keys.baseUrl);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xBasePath null');
    }
  }

  String xGuvenPath(KeyManager keyManager) {
    final String? path = keyManager.get(Keys.dev4Guven);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xGuvenPath null');
    }
  }

  String xSymptomCheckerLogin(KeyManager keyManager) {
    final String? path = keyManager.get(Keys.symtonCheckerLogin);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xSymptomCheckerLogin null');
    }
  }

  String xSymptomCheckerRequest(KeyManager keyManager) {
    final String? path = keyManager.get(Keys.symtomRequestLogin);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xSymptomCheckerRequest null');
    }
  }

  String xCronicTracking(KeyManager keyManager) {
    final String? path = keyManager.get(Keys.chronicTrackingBaseUrl);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xCronicTracking null');
    }
  }

  String xDoctorBaseUrl(KeyManager keyManager) {
    final String? path = keyManager.get(Keys.doctorBaseUrl);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xDoctorBaseUrl null');
    }
  }
}
