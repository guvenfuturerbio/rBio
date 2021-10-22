import 'dart:convert';

import '../../model/model.dart';
import '../core.dart';

class PatientSingleton {
  static final PatientSingleton _patientSingleton =
      PatientSingleton._internal();
  factory PatientSingleton() {
    return _patientSingleton;
  }

  PatientSingleton._internal();

  Future<void> setPatient(PatientResponse patient) async {
    final stringData = jsonEncode(patient.toJson());
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.PATIENT, stringData);
  }

  PatientResponse getPatient() {
    final stringData = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.PATIENT);
    if (stringData != null) {
      final decodeData = jsonDecode(stringData);
      return PatientResponse.fromJson(decodeData);
    }

    return null;
  }
}
