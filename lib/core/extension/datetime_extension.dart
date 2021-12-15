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
      DateFormat("d MMMM yyyy HH:MM", locale).format(this);

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
      DateFormat("HH:MM", locale).format(this);
}
