import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

enum ScaleTreatmentScreenMode {
  readOnly,
  update,
}

extension ScaleTreatmentScreenModeExtension on ScaleTreatmentScreenMode {
  String xGetTreatmentTitle(BuildContext context) {
    switch (this) {
      case ScaleTreatmentScreenMode.readOnly:
        return LocaleProvider.of(context).treatment_note;

      case ScaleTreatmentScreenMode.update:
        return LocaleProvider.of(context).update_treatment_note;
    }
  }

  String xGetDietTitle(BuildContext context) {
    switch (this) {
      case ScaleTreatmentScreenMode.readOnly:
        return LocaleProvider.of(context).diet_list;

      case ScaleTreatmentScreenMode.update:
        return LocaleProvider.of(context).update_diet_list;
    }
  }
}
