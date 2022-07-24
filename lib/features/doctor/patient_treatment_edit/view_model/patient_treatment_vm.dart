import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../chronic_tracking/treatment/treatment_detail/model/treatment_model.dart';
import '../../notifiers/patient_notifiers.dart';
import '../../shared/shared.dart';

class PatientTreatmentEditVm extends ChangeNotifier {
  TreatmentModel selectedModel;
  late String patientName;
  PatientTreatmentEditVm(this.selectedModel) {
    patientName = PatientNotifiers().patientDetail.name!;
  }

  Future<void> save(String treatment) async {
    await getIt<DoctorRepository>().updateMyPatientLimit(
      PatientNotifiers().patientDetail.id!,
      UpdateMyPatientLimit(
        rangeMax: PatientNotifiers().patientDetail.rangeMax,
        rangeMin: PatientNotifiers().patientDetail.rangeMin,
        hyper: PatientNotifiers().patientDetail.hyper,
        hypo: PatientNotifiers().patientDetail.hypo,
        treatment: treatment,
      ),
    );
    await PatientNotifiers().fetchPatientDetail(
      patientId: PatientNotifiers().patientDetail.id!,
    );
    Atom.historyBack();
  }
}
