import '../core.dart';

enum Remindable {
  bloodGlucose,
  strip,
  medication,
  hba1c,
}

extension ParseToString on Remindable {
  String toShortString() {
    switch (this) {
      case Remindable.bloodGlucose:
        return LocaleProvider.current.blood_glucose_measurement;

      case Remindable.hba1c:
        return LocaleProvider.current.hbA1c_measurement;

      case Remindable.strip:
        return LocaleProvider.current.strip_tracker;

      case Remindable.medication:
        return LocaleProvider.current.medication_reminder;

      default:
        return LocaleProvider.current.error;
    }
  }

  String toParseableString() {
    switch (this) {
      case Remindable.bloodGlucose:
        return 'BloodGlucose';

      case Remindable.hba1c:
        return 'HbA1c';

      case Remindable.strip:
        return 'Strip';

      case Remindable.medication:
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
        return Remindable.bloodGlucose;

      case 'HbA1c':
        return Remindable.hba1c;

      case 'Strip':
        return Remindable.strip;

      case 'Medication':
        return Remindable.medication;

      default:
        return Remindable.bloodGlucose;
    }
  }
}
