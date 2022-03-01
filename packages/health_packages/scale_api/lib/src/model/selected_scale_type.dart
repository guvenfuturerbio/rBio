import 'package:onedosehealth/core/core.dart';

enum SelectedScaleType {
  bmi,
  weight,
  bodyFat,
  boneMass,
  water,
  visceralFat,
  muscle,
}

extension SclaeToStringExtension on SelectedScaleType {
  String get toStr {
    switch (this) {
      case SelectedScaleType.bmi:
        return LocaleProvider.current.scale_data_bmi;

      case SelectedScaleType.weight:
        return LocaleProvider.current.weight;

      case SelectedScaleType.bodyFat:
        return LocaleProvider.current.scale_data_body_fat;

      case SelectedScaleType.boneMass:
        return LocaleProvider.current.scale_data_bone_mass;

      case SelectedScaleType.water:
        return LocaleProvider.current.scale_data_water;

      case SelectedScaleType.visceralFat:
        return LocaleProvider.current.scale_data_visceral_fat;

      case SelectedScaleType.muscle:
        return LocaleProvider.current.scale_data_muscle;
    }
  }
}
