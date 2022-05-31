import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

enum ScaleTreatmentScreenEditMode {
  readOnly,
  update,
}

extension ScaleTreatmentScreenEditModeExtension
    on ScaleTreatmentScreenEditMode {
  String xGetTreatmentTitle(BuildContext context) {
    switch (this) {
      case ScaleTreatmentScreenEditMode.readOnly:
        return LocaleProvider.of(context).treatment_note;

      case ScaleTreatmentScreenEditMode.update:
        return LocaleProvider.of(context).update_treatment_note;
    }
  }

  String xGetDietTitle(BuildContext context) {
    switch (this) {
      case ScaleTreatmentScreenEditMode.readOnly:
        return LocaleProvider.of(context).diet_list;

      case ScaleTreatmentScreenEditMode.update:
        return LocaleProvider.of(context).update_diet_list;
    }
  }
}
