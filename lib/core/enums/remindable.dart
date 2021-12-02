import '../core.dart';

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

  String toParseableString() {
    switch (this) {
      case Remindable.BloodGlucose:
        return 'BloodGlucose';

      case Remindable.HbA1c:
        return 'HbA1c';

      case Remindable.Strip:
        return 'Strip';

      case Remindable.Medication:
        return 'Medication';

      default:
        return LocaleProvider.current.error;
    }
  }
}

extension ParseToRemindable on String {
  Remindable toRemindable() {
    switch (this) {
      case 'BloodGlucose':
        return Remindable.BloodGlucose;

      case 'HbA1c':
        return Remindable.HbA1c;

      case 'Strip':
        return Remindable.Strip;

      case 'Medication':
        return Remindable.Medication;

      default:
        return Remindable.BloodGlucose;
    }
  }
}
