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
        break;
    }

    throw Exception("Undefined");
  }
}
