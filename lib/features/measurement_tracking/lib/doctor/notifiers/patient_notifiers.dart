import 'package:flutter/material.dart';
import 'package:onedosehealth/doctor/models/get_my_patient_filter.dart';
import 'package:onedosehealth/doctor/models/patient.dart';
import 'package:onedosehealth/doctor/models/patientDetail.dart';
import 'package:onedosehealth/doctor/models/update_my_patient_limit.dart';
import 'package:onedosehealth/doctor/services/patient_service.dart';

class PatientNotifiers extends ChangeNotifier {
  PatientDetail _patientDetail;

  List<Patient> _patientList;

  static final PatientNotifiers _patientNotifiers =
      PatientNotifiers._internal();

  factory PatientNotifiers() {
    return _patientNotifiers;
  }

  PatientNotifiers._internal();

  Future<void> fetchPatientDetail({@required int patientId}) async {
    this._patientDetail =
        await PatientService().fetchPatientDetail(id: patientId);
    notifyListeners();
  }

  Future<void> fetchPatientList(
      {@required GetMyPatientFilter myPatientFilter}) async {
    this._patientList = await PatientService()
        .fetchPatientList(getMyPatientFilter: myPatientFilter);
    notifyListeners();
  }

  Future<void> updatePatientLimit(
      {@required int patientId,
      @required UpdateMyPatientLimit updateMyPatientLimit}) async {
    await PatientService().updatePatientLimit(
        patientId: patientId, updateMyPatientLimit: updateMyPatientLimit);
    notifyListeners();
  }

  PatientDetail get patientDetail => this._patientDetail;

  List<Patient> get patientList => this._patientList;
}
