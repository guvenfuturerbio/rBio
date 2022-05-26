import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

enum PatientScaleTreatmentDetailMode {
  readOnly,
  update,
}

extension PatientScaleTreatmentDetailModeExtension
    on PatientScaleTreatmentDetailMode {
  String xGetTitle(BuildContext context) {
    switch (this) {
      case PatientScaleTreatmentDetailMode.readOnly:
        return LocaleProvider.of(context).treatment_note;

      case PatientScaleTreatmentDetailMode.update:
        return LocaleProvider.of(context).update_treatment_note;
    }
  }
}
