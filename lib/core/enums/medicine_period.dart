import '../core.dart';

enum MedicinePeriod {
  everyDay,
  spesificDays,
  intermittenDays,
}

extension MedicinePeriodExtensions on MedicinePeriod {
  String toShortString() {
    switch (this) {
      case MedicinePeriod.everyDay:
        return LocaleProvider.current.every_day;

      case MedicinePeriod.spesificDays:
        return LocaleProvider.current.specific_days;

      case MedicinePeriod.intermittenDays:
        return LocaleProvider.current.intermittent_days;

      default:
        throw Exception('toShortString');
    }
  }

  String toParseableStringMedicine() {
    switch (this) {
      case MedicinePeriod.everyDay:
        return 'EveryDay';

      case MedicinePeriod.spesificDays:
        return 'SpecificDays';

      case MedicinePeriod.intermittenDays:
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
        return MedicinePeriod.everyDay;

      case 'SpecificDays':
        return MedicinePeriod.spesificDays;

      case 'IntermittentDays':
        return MedicinePeriod.intermittenDays;

      default:
        return MedicinePeriod.everyDay;
    }
  }
}
