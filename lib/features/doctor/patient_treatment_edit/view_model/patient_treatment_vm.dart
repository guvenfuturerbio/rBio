import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/data/repository/doctor_repository.dart';
import 'package:onedosehealth/features/doctor/notifiers/patient_notifiers.dart';
import 'package:onedosehealth/model/doctor/doctor.dart';
import 'package:onedosehealth/model/treatment_model/treatment_model.dart';

class PatientTreatmentEditVm extends ChangeNotifier {
  TreatmentModel selectedModel;
  String patientName;
  PatientTreatmentEditVm(this.selectedModel) {
    patientName = PatientNotifiers().patientDetail.name;
  }

  save(String treatment) async {
    await getIt<DoctorRepository>().updateMyPatientLimit(
        PatientNotifiers().patientDetail.id,
        UpdateMyPatientLimit(
            rangeMax: PatientNotifiers().patientDetail.rangeMax,
            rangeMin: PatientNotifiers().patientDetail.rangeMin,
            hyper: PatientNotifiers().patientDetail.hyper,
            hypo: PatientNotifiers().patientDetail.hypo,
            treatment: treatment));
    await PatientNotifiers()
        .fetchPatientDetail(patientId: PatientNotifiers().patientDetail.id);
    Atom.historyBack();
  }
}
