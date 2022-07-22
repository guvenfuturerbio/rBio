import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

enum TreatmentType {
  diet,
  treatmentNote,
  doctorNote,
}

extension TreatmentTypeExtension on TreatmentType {
  Color xBackColor(BuildContext context) {
    switch (this) {
      case TreatmentType.diet:
        return context.xAppColors.kournikova;

      case TreatmentType.treatmentNote:
        return context.xAppColors.frenchPass;

      case TreatmentType.doctorNote:
        return context.xAppColors.frenchLilac;
    }
  }

  String xGetTitle(BuildContext context) {
    switch (this) {
      case TreatmentType.diet:
        return LocaleProvider.of(context).diet_list;

      case TreatmentType.treatmentNote:
        return LocaleProvider.of(context).treatment_note;

      case TreatmentType.doctorNote:
        return LocaleProvider.of(context).doctor_note;
    }
  }
}
