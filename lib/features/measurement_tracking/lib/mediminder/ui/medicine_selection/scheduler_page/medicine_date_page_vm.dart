import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/mediminder/ui/medicine_selection/scheduled_page/scheduled_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/l10n.dart';
import '../../../../helper/resources.dart';
import '../../../models/medicine_for_schedule.dart';
import '../../homepage/selectedremindable.dart';
import '../medicine_period_selection.dart';

class MedicineDatePageVm extends ChangeNotifier {
  BuildContext mContext;
  int _dailyCount;
  MedicinePeriod mMedicinePeriod;
  Remindable mRemindable;
  List<SelectableDay> _days;
  UsageType _selectedUsageType;
  int _intermittentDrugPerDay;
  int _dailyDose;
  List<DateTime> _doseTimes;
  String _drugName;
  List<int> _generatedIdForSchedule;
  MedicineDatePageVm(
      {BuildContext context,
      MedicinePeriod medicinePeriod,
      Remindable remindable}) {
    this.mContext = context;
    this.mMedicinePeriod = medicinePeriod;
    this.mRemindable = remindable;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      createDays();
      await generateUniqueIdForSchedule();
    });
  }

  setDailyCount(int count) async {
    this._dailyCount = count;
    notifyListeners();
    calculateDoseTimes();
    await generateUniqueIdForSchedule();
  }

  int get dailyCount => this._dailyCount ?? 0;

  createDays() {
    _days = [];
    _days.add(new SelectableDay(
        name: LocaleProvider.of(mContext).weekdays_monday,
        selected: false,
        day: Day.monday,
        dayIndex: 1));
    _days.add(new SelectableDay(
        name: LocaleProvider.of(mContext).weekdays_tuesday,
        selected: false,
        day: Day.tuesday,
        dayIndex: 2));
    _days.add(new SelectableDay(
        name: LocaleProvider.of(mContext).weekdays_wednesday,
        selected: false,
        day: Day.wednesday,
        dayIndex: 3));
    _days.add(new SelectableDay(
        name: LocaleProvider.of(mContext).weekdays_thursday,
        selected: false,
        day: Day.thursday,
        dayIndex: 4));
    _days.add(new SelectableDay(
        name: LocaleProvider.of(mContext).weekdays_friday,
        selected: false,
        day: Day.friday,
        dayIndex: 5));
    _days.add(new SelectableDay(
        name: LocaleProvider.of(mContext).weekdays_saturday,
        selected: false,
        day: Day.saturday,
        dayIndex: 6));
    _days.add(new SelectableDay(
        name: LocaleProvider.of(mContext).weekdays_sunday,
        selected: false,
        day: Day.sunday,
        dayIndex: 7));
    notifyListeners();
  }

  List<SelectableDay> get days => this._days;

  setSelectedUsageType(UsageType usageType) {
    this._selectedUsageType = usageType;
    notifyListeners();
  }

  UsageType get selectedUsageType =>
      this._selectedUsageType ?? UsageType.IRRELEVANT;

  setSelectedDay(int index) async {
    days[index].selected = !days[index].selected;
    notifyListeners();
    await generateUniqueIdForSchedule();
  }

  int get intermittentDrugPerDay => this._intermittentDrugPerDay ?? 2;

  setDailyDose(int dose) {
    this._dailyDose = dose;
    notifyListeners();
  }

  int get dailyDose => this._dailyDose ?? 1;

  calculateDoseTimes() {
    int perMinute = ((24 * 60) / dailyCount).round();
    int hour = perMinute < 60 ? perMinute : (perMinute / 60).round();
    int minute = perMinute < 60 ? 0 : perMinute - hour * 60;
    List<DateTime> doseTimeList = [];
    doseTimeList.add(DateTime.now());
    for (var i = 1; i < dailyCount; i++) {
      doseTimeList.add(DateTime.now()
          .add(new Duration(hours: i * hour, minutes: i * minute)));
    }
    setDoseTimes(doseTimeList);
  }

  setDoseTimes(List<DateTime> doseTime) {
    this._doseTimes = doseTime;
    notifyListeners();
  }

  List<DateTime> get doseTimes => this._doseTimes ?? [];

  setSelectedDoseDate(TimeOfDay timeOfDay, int index) {
    this._doseTimes[index] = DateTime(
        this._doseTimes[index].year,
        this._doseTimes[index].month,
        this._doseTimes[index].day,
        timeOfDay.hour,
        timeOfDay.minute);
    notifyListeners();
  }

  setDrugName(String drugName) {
    this._drugName = drugName;
    notifyListeners();
  }

  String get drugName => this._drugName ?? "-";

  createReminderPlan(Remindable selectedRemindable) {
    if (mMedicinePeriod == MedicinePeriod.EVERY_DAY) {
      scheduleForEveryDay(selectedRemindable);
    } else if (mMedicinePeriod == MedicinePeriod.SPECIFIC_DAYS) {
      scheduleForSpecific(selectedRemindable);
    }
  }

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  scheduleForEveryDay(Remindable selectedRemindable) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.max,
      ledColor: R.color.defaultBlue,
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    for (int i = 0; i < doseTimes.length; i++) {
      print("id " + generatedIdForSchedule[i].toString());
      await flutterLocalNotificationsPlugin.showDailyAtTime(
          generatedIdForSchedule[i],
          getNotificationTitle(),
          getNotificationBody(),
          Time(doseTimes[i].hour, doseTimes[i].minute, 0),
          platformChannelSpecifics);
      String time = ((doseTimes[i].hour) < 10
              ? "0" + doseTimes[i].hour.toString()
              : doseTimes[i].hour.toString()) +
          ":" +
          ((doseTimes[i].minute) < 10
              ? "0" + doseTimes[i].minute.toString()
              : doseTimes[i].minute.toString());
      saveScheduledMedicine(MedicineForScheduled(
          remindable: mRemindable.toString(),
          dosage: dailyDose,
          medicinePeriod: mMedicinePeriod.toString(),
          time: time.toString(),
          dayIndex: null,
          name: drugName,
          notificationId: generatedIdForSchedule[i],
          usageType: selectedUsageType.toString()));
    }
    Navigator.of(mContext)
        .popUntil(ModalRoute.withName(Routes.MY_MEDICINES_PAGE));
    Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (_) => ScheduledListPage(selectedRemindable)));
  }

  scheduleForSpecific(Remindable selectedRemindable) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.max,
      ledColor: R.color.defaultBlue,
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    int idIndex = 0;
    for (int i = 0; i < days.length; i++) {
      if (days[i].selected) {
        for (int y = 0; y < doseTimes.length; y++) {
          await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
              generatedIdForSchedule[idIndex],
              getNotificationTitle(),
              getNotificationBody(),
              days[i].day,
              Time(doseTimes[y].hour, doseTimes[y].minute, 0),
              platformChannelSpecifics);
          String time = ((doseTimes[y].hour) < 10
                  ? "0" + doseTimes[y].hour.toString()
                  : doseTimes[y].hour.toString()) +
              ":" +
              ((doseTimes[y].minute) < 10
                  ? "0" + doseTimes[y].minute.toString()
                  : doseTimes[y].minute.toString());
          saveScheduledMedicine(MedicineForScheduled(
              remindable: mRemindable.toString(),
              dosage: dailyDose,
              medicinePeriod: mMedicinePeriod.toString(),
              time: time.toString(),
              dayIndex: days[i].dayIndex,
              name: drugName,
              notificationId: generatedIdForSchedule[idIndex],
              usageType: selectedUsageType.toString()));
          idIndex++;
        }
      }
    }
    Navigator.of(mContext)
        .popUntil(ModalRoute.withName(Routes.MY_MEDICINES_PAGE));
    Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (_) => ScheduledListPage(selectedRemindable)));
  }

  saveScheduledMedicine(MedicineForScheduled medicine) async {
    Map<String, dynamic> tempMap = medicine.toJson();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String newMedicineJson = jsonEncode(tempMap);
    List<String> medicineJsonList = [];
    if (sharedUser.getStringList('medicines') == null) {
      medicineJsonList.add(newMedicineJson);
    } else {
      medicineJsonList = sharedUser.getStringList('medicines');
      medicineJsonList.add(newMedicineJson);
    }
    sharedUser.setStringList('medicines', medicineJsonList);
  }

  generateUniqueIdForSchedule() async {
    List<int> numberList = [];
    Random random = new Random();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('medicines');
    List<int> prefList = [];
    if (jsonList != null) {
      for (String jsonMedicine in jsonList) {
        Map userMap = jsonDecode(jsonMedicine);
        MedicineForScheduled tempMedicine =
            MedicineForScheduled.fromJson(userMap);
        prefList.add(tempMedicine.notificationId);
      }
    }
    int requiredIdCount = mMedicinePeriod == MedicinePeriod.SPECIFIC_DAYS
        ? days.length * dailyCount
        : mMedicinePeriod == MedicinePeriod.EVERY_DAY
            ? dailyCount
            : 1;
    while (numberList.length < requiredIdCount) {
      int randomNumber = 10000 + random.nextInt(1000);
      if (!numberList.contains(randomNumber) &&
          !prefList.contains(randomNumber)) {
        //prevent generate duplicate ids
        numberList.add(randomNumber);
      }
    }
    this._generatedIdForSchedule = numberList;
    notifyListeners();
  }

  List<int> get generatedIdForSchedule => this._generatedIdForSchedule;

  String getNotificationTitle() {
    if (mRemindable == Remindable.Medication) {
      return drugName;
    } else if (mRemindable == Remindable.BloodGlucose) {
      return LocaleProvider.of(mContext).blood_glucose_measurement;
    } else if (mRemindable == Remindable.HbA1c) {
      return LocaleProvider.of(mContext).hbA1c_measurement;
    } else {
      return "";
    }
  }

  String getNotificationBody() {
    if (mRemindable == Remindable.Medication) {
      return LocaleProvider.of(mContext).time_take_medicine;
    } else if (mRemindable == Remindable.BloodGlucose) {
      return LocaleProvider.of(mContext).bg_measurement_time;
    } else if (mRemindable == Remindable.HbA1c) {
      return LocaleProvider.of(mContext).time_hba1c;
    } else {
      return "";
    }
  }
}

class SelectableDay {
  String name;
  bool selected;
  Day day;
  int dayIndex;
  SelectableDay({this.name, this.selected, this.day, this.dayIndex});
}
