import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../core/core.dart';
import '../mediminder.dart';

class ReminderHelper {
  ReminderHelper._();

  static ReminderHelper? _instance;

  static ReminderHelper get instance {
    _instance ??= ReminderHelper._();
    return _instance!;
  }

  final random = Random();

  // #region getSelectableDays
  List<SelectableDay> getSelectableDays() {
    final _days = <SelectableDay>[];
    final _kTempList = _kDaysOfWeek;
    for (var i = 0; i < _kTempList.length; i++) {
      _days.add(
        SelectableDay(
          name: _kTempList[i]['name'],
          selected: false,
          day: _kTempList[i]['day'],
          dayIndex: i,
          shortName: _kTempList[i]['shortName'],
        ),
      );
    }
    return _days;
  }
  // #endregion

  // #region generateNotificationId
  Future<int> generateNotificationId(
    LocalNotificationManager notificationManager,
  ) async {
    final _pendingList = await notificationManager.getPendingNotificationIds();
    List<int> numberList = [];
    while (numberList.length <= 1) {
      int randomNumber = 10000 + random.nextInt(1000);
      // Prevent Generate Duplicate Ids
      if (!numberList.contains(randomNumber) &&
          !_pendingList.contains(randomNumber)) {
        numberList.add(randomNumber.toInt());
      }
    }
    return numberList.first;
  }
  // #endregion

  // #region generateUniqueIdsWithMedicinePeriod
  Future<List<int>> generateUniqueIdsWithMedicinePeriod(
    LocalNotificationManager notificationManager,
    MedicinePeriod? medicinePeriod,
    int? dailyDose,
    List<SelectableDay> days,
  ) async {
    final _pendingList = await notificationManager.getPendingNotificationIds();
    int requiredIdCount = 0;
    if (medicinePeriod == MedicinePeriod.oneTime) {
      requiredIdCount = dailyDose ?? 0;
    } else if (medicinePeriod == MedicinePeriod.everyDay) {
      requiredIdCount = dailyDose ?? 0;
    } else if (medicinePeriod == MedicinePeriod.specificDays) {
      requiredIdCount = days.length * (dailyDose ?? 0);
    } else {
      requiredIdCount = 1;
    }

    List<int> numberList = [];
    while (numberList.length < requiredIdCount) {
      int randomNumber = 10000 + random.nextInt(1000);
      // Prevent Generate Duplicate Ids
      if (!numberList.contains(randomNumber) &&
          !_pendingList.contains(randomNumber)) {
        numberList.add(randomNumber);
      }
    }

    return numberList;
  }
  // #endregion

  // #region _kDaysOfWeek
  List<Map<String, dynamic>> get _kDaysOfWeek => [
        {
          'name': LocaleProvider.current.weekdays_monday,
          'day': Day.monday,
          'shortName': LocaleProvider.current.weekdays_monday_short,
        },
        {
          'name': LocaleProvider.current.weekdays_tuesday,
          'day': Day.tuesday,
          'shortName': LocaleProvider.current.weekdays_tuesday_short,
        },
        {
          'name': LocaleProvider.current.weekdays_wednesday,
          'day': Day.wednesday,
          'shortName': LocaleProvider.current.weekdays_wednesday_short,
        },
        {
          'name': LocaleProvider.current.weekdays_thursday,
          'day': Day.thursday,
          'shortName': LocaleProvider.current.weekdays_thursday_short,
        },
        {
          'name': LocaleProvider.current.weekdays_friday,
          'day': Day.friday,
          'shortName': LocaleProvider.current.weekdays_friday_short,
        },
        {
          'name': LocaleProvider.current.weekdays_saturday,
          'day': Day.saturday,
          'shortName': LocaleProvider.current.weekdays_saturday_short,
        },
        {
          'name': LocaleProvider.current.weekdays_sunday,
          'day': Day.sunday,
          'shortName': LocaleProvider.current.weekdays_sunday_short,
        }
      ];
  // #endregion
}
