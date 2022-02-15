import 'package:collection/collection.dart';

import '../core.dart';

enum MedicinePeriod {
  oneTime,
  everyDay,
  specificDays,
  intermittentDays,
}

extension MedicinePeriodExtensions on MedicinePeriod {
  String get xRawValue => getEnumValue(this);

  String toShortString() {
    switch (this) {
      case MedicinePeriod.oneTime:
        return LocaleProvider.current.one_time;

      case MedicinePeriod.everyDay:
        return LocaleProvider.current.every_day;

      case MedicinePeriod.specificDays:
        return LocaleProvider.current.specific_days;

      case MedicinePeriod.intermittentDays:
        return LocaleProvider.current.intermittent_days;

      default:
        return "";
    }
  }
}

extension MedicinePeriodKeysStringExt on String {
  MedicinePeriod? get xMedicinePeriodKeys => MedicinePeriod.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}
