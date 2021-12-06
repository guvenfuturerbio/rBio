import '../core.dart';

enum MedicinePeriod {
  EVERY_DAY,
  SPECIFIC_DAYS,
  INTERMITTENT_DAYS,
}

extension MedicinePeriodExtensions on MedicinePeriod {
  String toShortString() {
    switch (this) {
      case MedicinePeriod.EVERY_DAY:
        return LocaleProvider.current.every_day;
        break;

      case MedicinePeriod.SPECIFIC_DAYS:
        return LocaleProvider.current.specific_days;
        break;

      case MedicinePeriod.INTERMITTENT_DAYS:
        return LocaleProvider.current.intermittent_days;
        break;

      default:
        throw Exception('toShortString');
    }
  }

  String toParseableStringMedicine() {
    switch (this) {
      case MedicinePeriod.EVERY_DAY:
        return 'EveryDay';

      case MedicinePeriod.SPECIFIC_DAYS:
        return 'SpecificDays';

      case MedicinePeriod.INTERMITTENT_DAYS:
        return 'IntermittentDays';

      default:
        return LocaleProvider.current.error;
    }
  }
}

extension ParseToMedicinePeriod on String {
  MedicinePeriod toMedicinePeriod() {
    switch (this) {
      case 'EveryDay':
        return MedicinePeriod.EVERY_DAY;

      case 'SpecificDays':
        return MedicinePeriod.SPECIFIC_DAYS;

      case 'IntermittentDays':
        return MedicinePeriod.INTERMITTENT_DAYS;

      default:
        return MedicinePeriod.EVERY_DAY;
    }
  }
}
