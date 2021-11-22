import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../common/mediminder_common.dart';

class MedicationDateVm extends ChangeNotifier {
  BuildContext mContext;
  MedicinePeriod mMedicinePeriod;
  Remindable mRemindable;

  MedicationDateVm({
    BuildContext context,
    MedicinePeriod medicinePeriod,
    Remindable remindable,
  }) {
    this.mContext = context;
    this.mMedicinePeriod = medicinePeriod;
    this.mRemindable = remindable;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _createDays();
      await _generateUniqueIdForSchedule();
    });
  }

  final random = Random();

  List<Map<String, dynamic>> kDays(BuildContext context) => [
        {
          'name': LocaleProvider.of(mContext).weekdays_monday,
          'day': Day.monday,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_tuesday,
          'day': Day.tuesday,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_wednesday,
          'day': Day.wednesday,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_thursday,
          'day': Day.thursday,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_friday,
          'day': Day.friday,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_saturday,
          'day': Day.saturday,
        },
        {
          'name': LocaleProvider.of(mContext).weekdays_sunday,
          'day': Day.sunday,
        }
      ];

  List<DateTime> _doseTimes;
  List<DateTime> get doseTimes => this._doseTimes ?? [];
  void set doseTimes(List<DateTime> value) {
    this._doseTimes = value;
    notifyListeners();
  }

  int _dailyDose;
  int get dailyDose => this._dailyDose ?? 1;
  setDailyDose(int dose) {
    this._dailyDose = dose;
    notifyListeners();
  }

  int _dailyCount;
  int get dailyCount => this._dailyCount ?? 0;
  Future<void> setDailyCount(int count) async {
    this._dailyCount = count;
    notifyListeners();
    calculateDoseTimes();
    await _generateUniqueIdForSchedule();
  }

  String _drugName;
  String get drugName => this._drugName ?? "-";
  void setDrugName(String drugName) {
    this._drugName = drugName;
    notifyListeners();
  }

  Future<void> setSelectedDay(int index) async {
    days[index].selected = !days[index].selected;
    notifyListeners();
    await _generateUniqueIdForSchedule();
  }

  List<SelectableDay> _days;
  List<SelectableDay> get days => this._days;
  void _createDays() {
    _days = [];
    final _kTempList = kDays(mContext);
    for (var i = 0; i < _kTempList.length; i++) {
      _days.add(
        SelectableDay(
          name: _kTempList[i]['name'],
          selected: false,
          day: _kTempList[i]['day'],
          dayIndex: i,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> _generateUniqueIdForSchedule() async {
    List<int> numberList = [];
    List<String> jsonList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.medicines);

    List<int> prefList = [];
    if (jsonList != null) {
      for (String jsonMedicine in jsonList) {
        Map<String, dynamic> userMap = jsonDecode(jsonMedicine);
        final tempMedicine = MedicineForScheduledModel.fromJson(userMap);
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
      // Prevent Generate Duplicate Ids
      if (!numberList.contains(randomNumber) &&
          !prefList.contains(randomNumber)) {
        numberList.add(randomNumber);
      }
    }

    this._generatedIdForSchedule = numberList;
    notifyListeners();
  }

  UsageType _selectedUsageType;
  UsageType get selectedUsageType =>
      this._selectedUsageType ?? UsageType.IRRELEVANT;
  void setSelectedUsageType(UsageType usageType) {
    this._selectedUsageType = usageType;
    notifyListeners();
  }

  List<int> _generatedIdForSchedule;
  List<int> get generatedIdForSchedule => this._generatedIdForSchedule;

  int get intermittentDrugPerDay => 2;

  void calculateDoseTimes() {
    int perMinute = ((24 * 60) / dailyCount).round();
    int hour = perMinute < 60 ? perMinute : (perMinute / 60).round();
    int minute = perMinute < 60 ? 0 : perMinute - hour * 60;
    List<DateTime> doseTimeList = [];
    doseTimeList.add(DateTime.now());
    for (var i = 1; i < dailyCount; i++) {
      doseTimeList.add(
        DateTime.now().add(
          new Duration(hours: i * hour, minutes: i * minute),
        ),
      );
    }
    doseTimes = doseTimeList;
  }

  void setSelectedDoseDate(TimeOfDay timeOfDay, int index) {
    this._doseTimes[index] = DateTime(
      this._doseTimes[index].year,
      this._doseTimes[index].month,
      this._doseTimes[index].day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    notifyListeners();
  }

  void createReminderPlan(Remindable selectedRemindable) {
    if (mMedicinePeriod == MedicinePeriod.EVERY_DAY) {
      _scheduleForEveryDay(selectedRemindable);
    } else if (mMedicinePeriod == MedicinePeriod.SPECIFIC_DAYS) {
      _scheduleForSpecific(selectedRemindable);
    }
  }

  Future<void> _scheduleForEveryDay(Remindable selectedRemindable) async {
    for (int i = 0; i < doseTimes.length; i++) {
      await getIt<LocalNotificationsManager>().createMedicineEveryDay(
        generatedIdForSchedule[i],
        _getNotificationTitle(),
        _getNotificationBody(),
        Time(doseTimes[i].hour, doseTimes[i].minute, 0),
      );

      String time = ((doseTimes[i].hour) < 10
              ? "0" + doseTimes[i].hour.toString()
              : doseTimes[i].hour.toString()) +
          ":" +
          ((doseTimes[i].minute) < 10
              ? "0" + doseTimes[i].minute.toString()
              : doseTimes[i].minute.toString());

      saveScheduledMedicine(
        MedicineForScheduledModel(
          remindable: mRemindable.toString(),
          dosage: dailyDose,
          medicinePeriod: mMedicinePeriod.toString(),
          time: time.toString(),
          dayIndex: null,
          name: drugName,
          notificationId: generatedIdForSchedule[i],
          usageType: selectedUsageType.toString(),
        ),
      );
    }

    Navigator.of(mContext).popUntil(
      ModalRoute.withName(Mediminder.instance.MY_MEDICINES_PAGE),
    );
    Navigator.push(
      mContext,
      MaterialPageRoute(
        builder: (_) => MedicationScreen(remindable: selectedRemindable),
      ),
    );
  }

  Future<void> _scheduleForSpecific(Remindable selectedRemindable) async {
    int idIndex = 0;
    for (int i = 0; i < days.length; i++) {
      if (days[i].selected) {
        for (int y = 0; y < doseTimes.length; y++) {
          await getIt<LocalNotificationsManager>().createMedicineSpecificDays(
            generatedIdForSchedule[idIndex],
            _getNotificationTitle(),
            _getNotificationBody(),
            days[i].day,
            Time(doseTimes[y].hour, doseTimes[y].minute, 0),
          );

          String time = ((doseTimes[y].hour) < 10
                  ? "0" + doseTimes[y].hour.toString()
                  : doseTimes[y].hour.toString()) +
              ":" +
              ((doseTimes[y].minute) < 10
                  ? "0" + doseTimes[y].minute.toString()
                  : doseTimes[y].minute.toString());

          saveScheduledMedicine(
            MedicineForScheduledModel(
              remindable: mRemindable.toString(),
              dosage: dailyDose,
              medicinePeriod: mMedicinePeriod.toString(),
              time: time.toString(),
              dayIndex: days[i].dayIndex,
              name: drugName,
              notificationId: generatedIdForSchedule[idIndex],
              usageType: selectedUsageType.toString(),
            ),
          );

          idIndex++;
        }
      }
    }

    Navigator.of(mContext).popUntil(
      ModalRoute.withName(Mediminder.instance.MY_MEDICINES_PAGE),
    );
    Navigator.push(
      mContext,
      MaterialPageRoute(
        builder: (_) => MedicationScreen(remindable: selectedRemindable),
      ),
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

  String _getNotificationBody() {
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
