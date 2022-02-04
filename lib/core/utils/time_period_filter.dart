import '../core.dart';

enum TimePeriodFilter { daily, weekly, monthly, monthlyThree, spesific }

extension TimePeriodFilterExtension on TimePeriodFilter {
  String toShortString() {
    switch (this) {
      case TimePeriodFilter.daily:
        return LocaleProvider.current.daily;
      case TimePeriodFilter.weekly:
        return LocaleProvider.current.weekly;
      case TimePeriodFilter.monthly:
        return LocaleProvider.current.monthly;
      case TimePeriodFilter.monthlyThree:
        return LocaleProvider.current.three_months;
      case TimePeriodFilter.spesific:
        return LocaleProvider.current.specific;
      default:
        return '';
    }
  }
}

extension TimePeriodStringExtension on String {
  TimePeriodFilter get fromString {
    if (this == LocaleProvider.current.daily) {
      return TimePeriodFilter.daily;
    } else if (this == LocaleProvider.current.weekly) {
      return TimePeriodFilter.weekly;
    } else if (this == LocaleProvider.current.monthly) {
      return TimePeriodFilter.monthly;
    } else if (this == LocaleProvider.current.three_months) {
      return TimePeriodFilter.monthlyThree;
    } else if (this == LocaleProvider.current.specific) {
      return TimePeriodFilter.spesific;
    } else {
      throw Exception(
          '$this: The content does not exist please check your code base');
    }
  }
}
