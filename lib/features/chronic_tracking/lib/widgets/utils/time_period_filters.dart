import '../../../../../generated/l10n.dart';

enum TimePeriodFilter { DAILY, WEEKLY, MONTHLY, MONTHLY_THREE, SPECIFIC }

extension TimePeriodFilterExtension on TimePeriodFilter {
  String toShortString() {
    switch (this) {
      case TimePeriodFilter.DAILY:
        return LocaleProvider.current.daily;
        break;
      case TimePeriodFilter.WEEKLY:
        return LocaleProvider.current.weekly;
        break;
      case TimePeriodFilter.MONTHLY:
        return LocaleProvider.current.monthly;
        break;
      case TimePeriodFilter.MONTHLY_THREE:
        return LocaleProvider.current.three_months;
        break;
      case TimePeriodFilter.SPECIFIC:
        return LocaleProvider.current.specific;
        break;
    }
  }
}

extension TimePeriodStringExtension on String {
  TimePeriodFilter get fromString {
    if (this == LocaleProvider.current.daily) {
      return TimePeriodFilter.DAILY;
    } else if (this == LocaleProvider.current.weekly) {
      return TimePeriodFilter.WEEKLY;
    } else if (this == LocaleProvider.current.monthly) {
      return TimePeriodFilter.MONTHLY;
    } else if (this == LocaleProvider.current.three_months) {
      return TimePeriodFilter.MONTHLY_THREE;
    } else if (this == LocaleProvider.current.specific) {
      return TimePeriodFilter.SPECIFIC;
    } else {
      throw Exception(
          '$this: The content does not exist please check your code base');
    }
  }
}
