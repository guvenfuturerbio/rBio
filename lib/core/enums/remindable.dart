import 'package:collection/collection.dart';

import '../core.dart';

enum Remindable {
  bloodGlucose,
  strip,
  medication,
  hbA1c,
}

extension ParseToString on Remindable {
  String get xRawValue => name;

  String toShortTitle() {
    switch (this) {
      case Remindable.bloodGlucose:
        return LocaleProvider.current.blood_glucose_measurement;

      case Remindable.hbA1c:
        return LocaleProvider.current.hbA1c_measurement;

      case Remindable.strip:
        return LocaleProvider.current.strip_tracker;

      case Remindable.medication:
        return LocaleProvider.current.medication_reminder;

      default:
        return LocaleProvider.current.error;
    }
  }

  String toRouteString() {
    switch (this) {
      case Remindable.bloodGlucose:
        return 'bloodGlucose';

      case Remindable.hbA1c:
        return 'hbA1c';

      case Remindable.strip:
        return 'strip';

      case Remindable.medication:
        return 'medication';

      default:
        return LocaleProvider.current.error;
    }
  }
}

extension ParseToRemindable on String {
  Remindable? get xRemindableKeys => Remindable.values
      .firstWhereOrNull((element) => element.xRawValue == this);

  Remindable toRouteToRemindable() {
    switch (this) {
      case 'bloodGlucose':
        return Remindable.bloodGlucose;

      case 'hbA1c':
        return Remindable.hbA1c;

      case 'strip':
        return Remindable.strip;

      case 'medication':
        return Remindable.medication;

      default:
        return Remindable.bloodGlucose;
    }
  }
}
