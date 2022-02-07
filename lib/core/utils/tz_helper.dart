// ignore_for_file: lines_longer_than_80_chars

import 'package:timezone/timezone.dart' as tz;

class TZHelper {
  TZHelper._();

  static TZHelper? _instance;

  static TZHelper get instance {
    _instance ??= TZHelper._();
    return _instance!;
  }

  tz.TZDateTime from(String formattedString) =>
      tz.TZDateTime.from(DateTime.parse(formattedString), tz.local);

  tz.TZDateTime fromMillisecondsSinceEpoch(int millisecondsSinceEpoch) =>
      tz.TZDateTime.fromMillisecondsSinceEpoch(
          tz.local, millisecondsSinceEpoch);

  tz.TZDateTime now() => tz.TZDateTime.now(tz.local);

  tz.TZDateTime nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, 10); // 2022-01-29 10:00:00.000+0300
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime nextInstanceOfTenAMLastYear() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    return tz.TZDateTime(tz.local, now.year - 1, now.month, now.day, 10);
  }

  /// DateTime.monday = 1
  /// Bir sonraki Pazartesi, Salı ... Pazar'ı getiren metod.
  tz.TZDateTime nextInstanceOfDay(int dayIndex, tz.TZDateTime date) {
    final dateNow = now();
    tz.TZDateTime scheduledDate = date;
    while (scheduledDate.weekday != dayIndex) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    if (scheduledDate.isBefore(dateNow)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }
    return scheduledDate;
  }
}

extension TZDateTimeExtensions on tz.TZDateTime {
  String get xTimeFormat {
    String result = "";
    result += hour < 10 ? "0$hour" : "$hour";
    result += ":";
    result += minute < 10 ? "0$minute" : "$minute";
    return result;
  }
}
