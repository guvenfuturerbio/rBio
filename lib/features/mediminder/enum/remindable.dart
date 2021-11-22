import '../common//mediminder_common.dart';

enum Remindable {
  BloodGlucose,
  Strip,
  Medication,
  HbA1c,
}

extension ParseToString on Remindable {
  String toShortString() {
    switch (this) {
      case Remindable.BloodGlucose:
        return LocaleProvider.current.blood_glucose_measurement;

      case Remindable.HbA1c:
        return LocaleProvider.current.hbA1c_measurement;

      case Remindable.Strip:
        return LocaleProvider.current.strip_tracker;

      case Remindable.Medication:
        return LocaleProvider.current.medication_reminder;

      default:
        return LocaleProvider.current.error;
    }
  }
}
