import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  String get xTimeFormat {
    String result = "";
    result += hour < 10 ? "0$hour" : "$hour";
    result += ":";
    result += minute < 10 ? "0$minute" : "$minute";
    return result;
  }

  bool xIsEqual(TimeOfDay other) =>
      hour == other.hour && minute == other.minute;
}

extension TimeOfDayStringExtensions on String? {
  /// "07:45" => TimeOfDay(07:45)
  TimeOfDay get xToTimeOfDay {
    final itemTime = this?.split(":") ?? ["0", "0"];
    return TimeOfDay(
      hour: int.tryParse(itemTime[0]) ?? 0,
      minute: int.tryParse(itemTime[1]) ?? 0,
    );
  }
}
