import '../common//mediminder_common.dart';

enum MedicinePeriod {
  EVERY_DAY,
  SPECIFIC_DAYS,
  INTERMITTENT_DAYS,
}

extension MedicinePeriodExtensions on MedicinePeriod {
  String toShortString() {
    switch (this) {
      case MedicinePeriod.EVERY_DAY:
        return LocaleProvider().every_day;
        break;

      case MedicinePeriod.SPECIFIC_DAYS:
        return LocaleProvider().specific_days;
        break;

      case MedicinePeriod.INTERMITTENT_DAYS:
        return LocaleProvider().intermittent_days;
        break;

      default:
        throw Exception('toShprtString');
    }
  }
}
