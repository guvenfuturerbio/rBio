import 'package:intl/intl.dart';

extension BuildContextExtensions on DateTime {
  /// Format : Last Day of Month
  DateTime get xLastDayOfMonth =>
      month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);

  /// Format : dd-MM-yyyy
  String xFormatTime1([dynamic locale]) =>
      DateFormat("dd-MM-yyyy", locale).format(this);

  /// Format : d MMMM yyyy
  String xFormatTime2([dynamic locale]) =>
      DateFormat("d MMMM yyyy", locale).format(this);

  /// Format : d MMMM yyyy HH:MM
  String xFormatTime3([dynamic locale]) =>
      DateFormat("d MMMM yyyy HH:mm", locale).format(this);

  /// Format : EEEE
  String xFormatTime4([dynamic locale]) => DateFormat.EEEE(locale).format(this);

  /// Format : yMMMMd
  String xFormatTime5([dynamic locale]) =>
      DateFormat.yMMMMd(locale).format(this);

  /// Format : yyyy-MM-ddTHH:mm:ss
  String xFormatTime6([dynamic locale]) =>
      DateFormat("yyyy-MM-ddTHH:mm:ss", locale).format(this);

  /// Format : dd/MM/yy
  String xFormatTime7([dynamic locale]) =>
      DateFormat("dd/MM/yy", locale).format(this);

  /// Format : HH:MM
  String xFormatTime8([dynamic locale]) =>
      DateFormat("HH:mm", locale).format(this);

  /// Format : dd/MM/yyyy - HH:MM
  String xFormatTime9([dynamic locale]) {
    return DateFormat("dd/MM/yy - HH:mm", locale).format(this);
  }

  /// Format : dd/MM/yyyy
  String xFormatTime10([dynamic locale]) =>
      DateFormat("dd/MM/yyyy", locale).format(this);

  bool xIsSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool xIsSameDateTime(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day &&
        hour == other.hour &&
        minute == other.minute &&
        second == other.second &&
        millisecond == other.millisecond &&
        microsecond == other.microsecond;
  }
}
