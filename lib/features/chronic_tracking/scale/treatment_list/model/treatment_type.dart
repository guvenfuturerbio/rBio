import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

enum TreatmentType {
  diet,
  treatmentNote,
  doctorNote,
}

extension TreatmentTypeExtension on TreatmentType {
  Color get xBackColor {
    switch (this) {
      case TreatmentType.diet:
        return getIt<IAppConfig>().theme.yellow;

      case TreatmentType.treatmentNote:
        return getIt<IAppConfig>().theme.blue;

      case TreatmentType.doctorNote:
        return getIt<IAppConfig>().theme.pink;
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
