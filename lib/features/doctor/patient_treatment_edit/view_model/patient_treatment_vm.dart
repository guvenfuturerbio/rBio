import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/doctor/doctor.dart';
import '../../../../model/treatment_model/treatment_model.dart';
import '../../notifiers/patient_notifiers.dart';

class PatientTreatmentEditVm extends ChangeNotifier {
  TreatmentModel selectedModel;
  late String patientName;
  PatientTreatmentEditVm(this.selectedModel) {
    patientName = PatientNotifiers().patientDetail.name!;
  }

  save(String treatment) async {
    await getIt<DoctorRepository>().updateMyPatientLimit(
        PatientNotifiers().patientDetail.id!,
        UpdateMyPatientLimit(
            rangeMax: PatientNotifiers().patientDetail.rangeMax,
            rangeMin: PatientNotifiers().patientDetail.rangeMin,
            hyper: PatientNotifiers().patientDetail.hyper,
            hypo: PatientNotifiers().patientDetail.hypo,
            treatment: treatment));
    await PatientNotifiers()
        .fetchPatientDetail(patientId: PatientNotifiers().patientDetail.id!);
    Atom.historyBack();
  }
}
