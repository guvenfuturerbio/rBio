import 'package:collection/collection.dart';

import '../../../../core/core.dart';

enum ReminderPeriod {
  oneTime,
  everyDay,
  specificDays,
}

extension ReminderPeriodExtensions on ReminderPeriod {
  String get xRawValue => Utils.instance.getEnumValue(this);

  String toShortString() {
    switch (this) {
      case ReminderPeriod.oneTime:
        return LocaleProvider.current.one_time;

      case ReminderPeriod.everyDay:
        return LocaleProvider.current.every_day;

      case ReminderPeriod.specificDays:
        return LocaleProvider.current.specific_days;

      default:
        return "";
    }
  }
}

extension ReminderPeriodKeysStringExt on String {
  ReminderPeriod? get xGetReminderPeriod => ReminderPeriod.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}
