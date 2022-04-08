part of '../view/reminder_alert_dialog.dart';

enum ReminderPostponeType {
  after5,
  after10,
  after30,
}

extension ReminderPostponeTypeExtension on ReminderPostponeType {
  String get xGetTitle {
    switch (this) {
      case ReminderPostponeType.after5:
        return "5 dk";

      case ReminderPostponeType.after10:
        return "10 dk";

      case ReminderPostponeType.after30:
        return "30 dk";
    }
  }

  Duration get xGetDuration {
    switch (this) {
      case ReminderPostponeType.after5:
        return const Duration(minutes: 5);

      case ReminderPostponeType.after10:
        return const Duration(minutes: 10);

      case ReminderPostponeType.after30:
        return const Duration(minutes: 30);
    }
  }
}
