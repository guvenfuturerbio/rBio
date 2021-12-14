import 'package:flutter/material.dart';

import '../../../core/data/repository/doctor_repository.dart';
import '../../../core/locator.dart';
import '../../../model/model.dart';

class PatientNotifiers extends ChangeNotifier {
  DoctorPatientDetailModel _patientDetail;

  List<DoctorPatientModel> _patientList;

  static final PatientNotifiers _patientNotifiers =
      PatientNotifiers._internal();

  factory PatientNotifiers() {
    return _patientNotifiers;
  }

  PatientNotifiers._internal();

  Future<void> fetchPatientDetail({@required int patientId}) async {
    this._patientDetail =
        await getIt<DoctorRepository>().getMyPatientDetail(patientId);
    notifyListeners();
  }

  Future<void> updatePatientLimit({
    @required int patientId,
    @required UpdateMyPatientLimit updateMyPatientLimit,
  }) async {
    await getIt<DoctorRepository>()
        .updateMyPatientLimit(patientId, updateMyPatientLimit);
    notifyListeners();
  }

  DoctorPatientDetailModel get patientDetail => this._patientDetail;

  List<DoctorPatientModel> get patientList => this._patientList;
}
