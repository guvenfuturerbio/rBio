import 'package:flutter/material.dart';

import '../../../core/data/repository/doctor_repository.dart';
import '../../../core/locator.dart';
import '../../../model/model.dart';

class PatientNotifiers extends ChangeNotifier {
  late DoctorPatientDetailModel _patientDetail;

  List<DoctorGlucosePatientModel>? _patientList;

  DoctorPatientDetailModel get patientDetail => _patientDetail;

  List<DoctorGlucosePatientModel> get patientList => _patientList ?? [];

  static final PatientNotifiers _patientNotifiers =
      PatientNotifiers._internal();

  factory PatientNotifiers() {
    return _patientNotifiers;
  }

  static PatientNotifiers get instace => _patientNotifiers;

  PatientNotifiers._internal();

  Future<void> fetchPatientDetail({required int patientId}) async {
    _patientDetail =
        await getIt<DoctorRepository>().getMyPatientDetail(patientId);
    notifyListeners();
  }

  Future<void> updatePatientLimit({
    required int patientId,
    required UpdateMyPatientLimit updateMyPatientLimit,
  }) async {
    await getIt<DoctorRepository>()
        .updateMyPatientLimit(patientId, updateMyPatientLimit);
    notifyListeners();
  }
}
