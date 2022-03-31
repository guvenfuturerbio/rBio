import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../core/core.dart';
import '../../../../core/utils/tz_helper.dart';
import '../../mediminder.dart';

class BloodGlucoseReminderAddVm extends RbioVm {
  @override
  late BuildContext mContext;
  late Remindable mRemindable;
  late ReminderNotificationsManager mRotificationManager;

  BloodGlucoseReminderAddVm({
    required this.mContext,
    required this.mRemindable,
    required this.mRotificationManager,
  }) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      _createDays();
      await _generateUniqueIdForSchedule();
    });
  }

  final random = Random();

  List<Map<String, dynamic>> kDays(BuildContext context) => [
        {
          'name': LocaleProvider.of(mContext).weekdays_monday,
          'day': Day.monday,
          'shortName': LocaleProvider.of(mContext).weekdays_monday_short,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_tuesday,
          'day': Day.tuesday,
          'shortName': LocaleProvider.of(mContext).weekdays_tuesday_short,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_wednesday,
          'day': Day.wednesday,
          'shortName': LocaleProvider.of(mContext).weekdays_wednesday_short,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_thursday,
          'day': Day.thursday,
          'shortName': LocaleProvider.of(mContext).weekdays_thursday_short,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_friday,
          'day': Day.friday,
          'shortName': LocaleProvider.of(mContext).weekdays_friday_short,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_saturday,
          'day': Day.saturday,
          'shortName': LocaleProvider.of(mContext).weekdays_saturday_short,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_sunday,
          'day': Day.sunday,
          'shortName': LocaleProvider.of(mContext).weekdays_sunday_short,
        }
      ];

  MedicinePeriod? mMedicinePeriod;
  void setMedicinePeriod(MedicinePeriod? value) {
    mMedicinePeriod = value;
    notifyListeners();
  }

  List<tz.TZDateTime>? _doseTimes;
  List<tz.TZDateTime> get doseTimes => _doseTimes ?? [];
  set doseTimes(List<tz.TZDateTime> value) {
    _doseTimes = value;
    notifyListeners();
  }

  int? _dailyDose;
  int get dailyDose => _dailyDose ?? 1;
  setDailyDose(int dose) {
    _dailyDose = dose;
    notifyListeners();
  }

  int? _dailyCount;
  int get dailyCount => _dailyCount ?? 0;
  Future<void> setDailyCount(int count) async {
    _dailyCount = count;
    notifyListeners();
    calculateDoseTimes();
    await _generateUniqueIdForSchedule();
  }

  String? _drugName;
  String get drugName => _drugName ?? "-";
  void setDrugName(String drugName) {
    _drugName = drugName;
    notifyListeners();
  }

  UsageType? _selectedUsageType;
  UsageType get selectedUsageType => _selectedUsageType ?? UsageType.irrelevant;
  void setSelectedUsageType(UsageType usageType) {
    _selectedUsageType = usageType;
    notifyListeners();
  }

  Future<void> setSelectedDay(int index) async {
    days[index].selected = !days[index].selected;
    notifyListeners();
    await _generateUniqueIdForSchedule();
  }

  List<SelectableDay>? _days;
  List<SelectableDay> get days => _days ?? [];
  void _createDays() {
    _days = [];
    final _kTempList = kDays(mContext);
    for (var i = 0; i < _kTempList.length; i++) {
      _days!.add(
        SelectableDay(
          name: _kTempList[i]['name'],
          selected: false,
          day: _kTempList[i]['day'],
          dayIndex: i,
          shortName: _kTempList[i]['shortName'],
        ),
      );
    }
    notifyListeners();
  }

  void daysReset() {
    for (var item in days) {
      item.selected = false;
    }
  }

  List<int>? _generatedIdForSchedule;
  List<int> get generatedIdForSchedule => _generatedIdForSchedule ?? [];
  Future<void> _generateUniqueIdForSchedule() async {
    List<int> numberList = [];
    List<String>? jsonList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.medicines);

    List<int> prefList = [];
    if (jsonList != null) {
      for (String jsonMedicine in jsonList) {
        Map<String, dynamic> userMap = jsonDecode(jsonMedicine);
        final tempMedicine = MedicineForScheduledModel.fromJson(userMap);
        if (tempMedicine.notificationId != null) {
          prefList.add(tempMedicine.notificationId!);
        }
      }
    }

    int requiredIdCount = 0;
    if (mMedicinePeriod == MedicinePeriod.oneTime) {
      requiredIdCount = dailyCount;
    } else if (mMedicinePeriod == MedicinePeriod.everyDay) {
      requiredIdCount = dailyCount;
    } else if (mMedicinePeriod == MedicinePeriod.specificDays) {
      requiredIdCount = days.length * dailyCount;
    } else {
      requiredIdCount = 1;
    }

    while (numberList.length < requiredIdCount) {
      int randomNumber = 10000 + random.nextInt(1000);
      // Prevent Generate Duplicate Ids
      if (!numberList.contains(randomNumber) &&
          !prefList.contains(randomNumber)) {
        numberList.add(randomNumber);
      }
    }

    _generatedIdForSchedule = numberList;
    notifyListeners();
  }

  void calculateDoseTimes() {
    if (dailyCount == 0) return;

    // dailyCount : 3
    int perMinute = ((24 * 60) / dailyCount).round(); // 480
    int hour = perMinute < 60 ? perMinute : (perMinute / 60).round(); // 8
    int minute = perMinute < 60 ? 0 : perMinute - hour * 60; // 0
    List<tz.TZDateTime> doseTimeList = [];
    doseTimeList.add(TZHelper.instance.now().add(const Duration(
        hours: 1))); // TZDateTime (2022-01-31 12:08:12.034435+0300)
    for (var i = 1; i < dailyCount; i++) {
      doseTimeList.add(
        doseTimeList.first.add(
          Duration(hours: i * hour, minutes: i * minute),
        ),
      );
    }
    /*
      TZDateTime (2022-01-31 12:08:12.034435+0300)
      TZDateTime (2022-02-01 00:08:12.034435+0300)
    */
    doseTimes = doseTimeList;
  }

  void setSelectedDoseDate(TimeOfDay timeOfDay, int index) {
    _doseTimes?[index] = tz.TZDateTime(
      tz.local,
      _doseTimes?[index].year ?? 2022,
      _doseTimes?[index].month ?? 1,
      _doseTimes?[index].day ?? 1,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    notifyListeners();
  }

  void createReminderPlan(Remindable selectedRemindable) {
    final isValid = checkValidation(selectedRemindable, mMedicinePeriod);
    if (!isValid) return;

    switch (mMedicinePeriod) {
      case MedicinePeriod.oneTime:
        _scheduleForOneTime(selectedRemindable);
        break;

      case MedicinePeriod.everyDay:
        _scheduleForEveryDay(selectedRemindable);
        break;

      case MedicinePeriod.specificDays:
        _scheduleForSpecificDays(selectedRemindable);
        break;

      case MedicinePeriod.intermittentDays:
        break;

      default:
        break;
    }
  }

  bool checkValidation(
    Remindable selectedRemindable,
    MedicinePeriod? medicinePeriod,
  ) {
    // İlaç ismi kontrolü
    if (selectedRemindable == Remindable.medication) {
      if (_drugName == null || _drugName == '') {
        showInfoDialog(
          LocaleProvider.current.warning,
          LocaleProvider.current.error_empty_medicine_name,
        );
        return false;
      }
    }

    // Belirli Günler seçiminde gün kontrolü
    if (medicinePeriod == MedicinePeriod.specificDays) {
      final anyDateSelected = days.any((item) => item.selected);
      if (!anyDateSelected) {
        showInfoDialog(
          LocaleProvider.current.warning,
          LocaleProvider.current.error_empty_specific_day_selected,
        );
        return false;
      }
    }

    return true;
  }

  Future<void> _scheduleForOneTime(Remindable selectedRemindable) async {
    final dateTimeNow = TZHelper.instance.now().millisecondsSinceEpoch;

    for (int i = 0; i < doseTimes.length; i++) {
      await _createBGNotificationAndSaved(
        generatedIdForSchedule[i],
        doseTimes[i],
        MedicinePeriod.oneTime,
        doseTimes[i].xTimeFormat,
        null,
        dateTimeNow,
      );
    }

    _popAndPushRemindersScreen();
  }

  Future<void> _scheduleForEveryDay(Remindable selectedRemindable) async {
    final dateTimeNow = TZHelper.instance.now().millisecondsSinceEpoch;

    for (int i = 0; i < doseTimes.length; i++) {
      await _createBGNotificationAndSaved(
        generatedIdForSchedule[i],
        doseTimes[i],
        MedicinePeriod.everyDay,
        doseTimes[i].xTimeFormat,
        null,
        dateTimeNow,
      );
    }

    _popAndPushRemindersScreen();
  }

  Future<void> _scheduleForSpecificDays(Remindable selectedRemindable) async {
    int idIndex = 0;
    final dateTimeNow = TZHelper.instance.now().millisecondsSinceEpoch;

    for (int i = 0; i < days.length; i++) {
      if (days[i].selected) {
        for (int y = 0; y < doseTimes.length; y++) {
          if (days[i].dayIndex != null) {
            await _createBGNotificationAndSaved(
              generatedIdForSchedule[idIndex],
              TZHelper.instance.nextInstanceOfDay(i + 1, doseTimes[y]),
              MedicinePeriod.specificDays,
              doseTimes[y].xTimeFormat,
              days[i].dayIndex!,
              dateTimeNow,
            );

            idIndex++;
          }
        }
      }
    }

    _popAndPushRemindersScreen();
  }

  Future<void> _createBGNotificationAndSaved(
    int id,
    tz.TZDateTime scheduledDate,
    MedicinePeriod period,
    String time,
    int? dayIndex,
    int createdDate,
  ) async {
    if (mMedicinePeriod == null) return;

    await mRotificationManager.createMedinicine(
      id,
      _getNotificationTitle(),
      _getNotificationBody(),
      scheduledDate,
      period,
    );

    saveScheduledMedicine(
      MedicineForScheduledModel(
        notificationId: id,
        remindable: mRemindable.xRawValue,
        dosage: dailyDose,
        medicinePeriod: mMedicinePeriod!.xRawValue,
        time: time,
        dayIndex: dayIndex,
        name: drugName,
        usageType: selectedUsageType.xRawValue,
        scheduledDate: scheduledDate.millisecondsSinceEpoch,
        createdDate: createdDate,
      ),
    );
  }

  void _popAndPushRemindersScreen() {
    Atom.historyBack();
    Atom.to(
      PagePaths.bloodGlucoseReminderList,
      queryParameters: {
        'remindable': mRemindable.toRouteString(),
      },
      isReplacement: true,
    );
  }

  Future<void> saveScheduledMedicine(MedicineForScheduledModel medicine) async {
    final medicineStr = jsonEncode(medicine.toJson());

    List<String> medicineJsonList = [];
    final sharedList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.medicines);
    if (sharedList != null) {
      medicineJsonList = sharedList;
    }

    medicineJsonList.add(medicineStr);
    await getIt<ISharedPreferencesManager>()
        .setStringList(SharedPreferencesKeys.medicines, medicineJsonList);
  }

  String _getNotificationTitle() {
    if (mRemindable == Remindable.medication) {
      return drugName;
    } else if (mRemindable == Remindable.bloodGlucose) {
      return LocaleProvider.of(mContext).blood_glucose_measurement;
    } else if (mRemindable == Remindable.hbA1c) {
      return LocaleProvider.of(mContext).hbA1c_measurement;
    } else {
      return "";
    }
  }

  String _getNotificationBody() {
    if (mRemindable == Remindable.medication) {
      return LocaleProvider.of(mContext).time_take_medicine;
    } else if (mRemindable == Remindable.bloodGlucose) {
      return LocaleProvider.of(mContext).bg_measurement_time;
    } else if (mRemindable == Remindable.hbA1c) {
      return LocaleProvider.of(mContext).time_hba1c;
    } else {
      return "";
    }
  }
}
