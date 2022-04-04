// ignore_for_file: unused_local_variable

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

  String xCalculateTimeDifferenceBetween({
    required DateTime endDate,
  }) {
    int seconds = endDate.difference(this).inSeconds;
    int h, m, s;
    h = seconds ~/ 3600;
    m = ((seconds - h * 3600)) ~/ 60;
    s = seconds - (h * 3600) - (m * 60);

    var hourLeft = int.tryParse(
            h.toString().length < 2 ? "0" + h.toString() : h.toString()) ??
        0;
    var minuteLeft = int.tryParse(
            m.toString().length < 2 ? "0" + m.toString() : m.toString()) ??
        0;
    var secondsLeft = int.tryParse(
            s.toString().length < 2 ? "0" + s.toString() : s.toString()) ??
        0;

    if (hourLeft == 0) {
      return "$minuteLeft dk";
    } else if (hourLeft > 23) {
      final dayLeft = hourLeft ~/ 24;
      final dayHours = dayLeft * 24;
      final diffHours = hourLeft - dayHours;
      return "$dayLeft g $diffHours s $minuteLeft dk";
    } else {
      return "$hourLeft s $minuteLeft dk";
    }
  }
}
