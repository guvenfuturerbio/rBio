import '../../../../../../generated/l10n.dart';

enum SelectedScaleType {
  BMI,
  WEIGHT,
  BODY_FAT,
  BONE_MASS,
  WATER,
  VISCERAL_FAT,
  MUSCLE
}

extension SclaeToStringExtension on SelectedScaleType {
  get toStr {
    switch (this) {
      case SelectedScaleType.BMI:
        return LocaleProvider.current.scale_data_bmi;
      case SelectedScaleType.WEIGHT:
        return LocaleProvider.current.weight;
      case SelectedScaleType.BODY_FAT:
        return LocaleProvider.current.scale_data_body_fat;
      case SelectedScaleType.BONE_MASS:
        return LocaleProvider.current.scale_data_bone_mass;
      case SelectedScaleType.WATER:
        return LocaleProvider.current.scale_data_water;
      case SelectedScaleType.VISCERAL_FAT:
        return LocaleProvider.current.scale_data_visceral_fat;
      case SelectedScaleType.MUSCLE:
        return LocaleProvider.current.scale_data_muscle;
    }
  }
}
