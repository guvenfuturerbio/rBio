import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../mediminder.dart';
import '../../../core/core.dart';
import '../../../core/utils/tz_helper.dart';

class ReminderManager {
  final ProfileStorageImpl profileStorage;
  final ISharedPreferencesManager sharedPreferencesManager;
  final LocalNotificationManager localNotificationManager;
  final ReminderNotificationsManager reminderNotificationsManager;

  ReminderManager(
    this.profileStorage,
    this.sharedPreferencesManager,
    this.localNotificationManager,
    this.reminderNotificationsManager,
  );

  final random = Random();

  /// * "BloodGlucoseReminderAddEditCubit" tarafından çağrılır.
  ///
  /// * result parametresi içerisindeki "isCreated" değeri false ise, bu daha önce oluşturulan bir hatırlatıcıya aittir bu yüzden ilk önce bu plana ait bildirimleri createdDate değerine göre iptal edip, siliyor.
  ///
  /// * Her zaman "BloodGlucoseReminderAddEditResult" tipindeki parametreye göre bildirimleri oluşturup, Shared Preferences'a kaydediyor.
  // #region createOrEditBgReminderPlan
  Future<bool> createOrEditBgReminderPlan(
    BloodGlucoseReminderAddEditResult result,
  ) async {
    // #region _createNotificationAndSaved
    Future<void> _createNotificationAndSaved(
      int id,
      tz.TZDateTime scheduledDate,
      ReminderPeriod period,
      int? dayIndex,
      int createdDate,
      BloodGlucoseReminderAddEditResult result,
    ) async {
      await reminderNotificationsManager.createBloodGlucose(
        id,
        scheduledDate,
        period,
      );

      await _saveReminderEntity<BloodGlucoseReminderModel>(
        BloodGlucoseReminderModel(
          notificationId: id,
          scheduledDate: scheduledDate.millisecondsSinceEpoch,
          createdDate: createdDate,
          entegrationId: profileStorage.getFirst().id ?? 0,
          dayIndex: dayIndex,
          dailyDose: result.dailyDose,
          reminderPeriod: result.reminderPeriod,
          usageType: result.usageType,
        ),
      );
    }
    // #endregion

    // #region _scheduleForOneTime
    Future<void> _scheduleForOneTime(
      List<int> notificationIds,
      BloodGlucoseReminderAddEditResult result,
    ) async {
      final dateTimeNow = TZHelper.instance.now().millisecondsSinceEpoch;

      for (int i = 0; i < result.doseTimes.length; i++) {
        var itemScheduledTime = result.doseTimes[i];
        itemScheduledTime =
            TZHelper.instance.nextSameTimeAfterDay(itemScheduledTime);

        await _createNotificationAndSaved(
          notificationIds[i],
          itemScheduledTime,
          ReminderPeriod.oneTime,
          null,
          dateTimeNow,
          result,
        );
      }
    }
    // #endregion

    // #region  _scheduleForEveryDay
    Future<void> _scheduleForEveryDay(
      List<int> notificationIds,
      BloodGlucoseReminderAddEditResult result,
    ) async {
      final dateTimeNow = TZHelper.instance.now();
      final dateTimeNowMilliSeconds = dateTimeNow.millisecondsSinceEpoch;

      for (int i = 0; i < result.doseTimes.length; i++) {
        var itemScheduledTime = result.doseTimes[i];
        itemScheduledTime =
            TZHelper.instance.nextSameTimeAfterDay(itemScheduledTime);

        await _createNotificationAndSaved(
          notificationIds[i],
          itemScheduledTime,
          ReminderPeriod.everyDay,
          null,
          dateTimeNowMilliSeconds,
          result,
        );
      }
    }
    // #endregion

    // #region _scheduleForSpecificDays
    Future<void> _scheduleForSpecificDays(
      List<int> notificationIds,
      BloodGlucoseReminderAddEditResult result,
    ) async {
      int idIndex = 0;
      final dateTimeNow = TZHelper.instance.now().millisecondsSinceEpoch;

      for (int i = 0; i < result.days.length; i++) {
        if (result.days[i].selected) {
          for (int y = 0; y < result.doseTimes.length; y++) {
            if (result.days[i].dayIndex != null) {
              await _createNotificationAndSaved(
                notificationIds[idIndex],
                TZHelper.instance.nextInstanceOfDay(i + 1, result.doseTimes[y]),
                ReminderPeriod.specificDays,
                result.days[i].dayIndex!,
                dateTimeNow,
                result,
              );

              idIndex++;
            }
          }
        }
      }
    }
    // #endregion

    //
    try {
      if (!result.isCreated) {
        // Bu plana ait tüm bildirimleri sil ve iptal et.
        await cancelRemindersGroupAndRemove<BloodGlucoseReminderModel>(
          result.editCreatedDate!,
          BloodGlucoseReminderModel.empty(),
        );
      }

      final notificationIds = await _generateUniqueIdsWithReminderPeriod(
        localNotificationManager,
        result.reminderPeriod,
        result.dailyDose,
        result.days,
      );

      switch (result.reminderPeriod) {
        case ReminderPeriod.oneTime:
          await _scheduleForOneTime(notificationIds, result);
          break;

        case ReminderPeriod.everyDay:
          await _scheduleForEveryDay(notificationIds, result);
          break;

        case ReminderPeriod.specificDays:
          await _scheduleForSpecificDays(notificationIds, result);
          break;

        default:
          break;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
  // #endregion

  /// * "MedicationReminderAddEditCubit" tarafından çağrılır.
  ///
  /// * result parametresi içerisindeki "isCreated" değeri false ise, bu daha önce oluşturulan bir hatırlatıcıya aittir bu yüzden ilk önce bu plana ait bildirimleri createdDate değerine göre iptal edip, siliyor.
  ///
  /// * Her zaman "MedicationReminderAddEditResult" tipindeki parametreye göre bildirimleri oluşturup, Shared Preferences'a kaydediyor.
  // #region createOrEditMedicationReminderPlan
  Future<bool> createOrEditMedicationReminderPlan(
    MedicationReminderAddEditResult result,
  ) async {
    // #region _createNotificationAndSaved
    Future<void> _createNotificationAndSaved(
      int id,
      tz.TZDateTime scheduledDate,
      ReminderPeriod period,
      int? dayIndex,
      int createdDate,
      MedicationReminderAddEditResult result,
    ) async {
      await reminderNotificationsManager.createMedinicine(
        id,
        result.drugName ?? '',
        scheduledDate,
        period,
      );

      await _saveReminderEntity<MedicationReminderModel>(
        MedicationReminderModel(
          notificationId: id,
          scheduledDate: scheduledDate.millisecondsSinceEpoch,
          createdDate: createdDate,
          entegrationId: profileStorage.getFirst().id ?? 0,
          drugTracking: result.drugTracking,
          drugName: result.drugName,
          usageType: result.usageType,
          reminderPeriod: result.reminderPeriod,
          dailyDose: result.dailyDose,
          oneTimeDose: result.oneTimeDose,
          dayIndex: dayIndex,
          drugCount: result.drugCount,
          remainingCountNotification: result.remainingCountNotification,
          boxCode: result.boxCode,
        ),
      );
    }
    // #endregion

    // #region _scheduleForOneTime
    Future<void> _scheduleForOneTime(
      List<int> notificationIds,
      MedicationReminderAddEditResult result,
    ) async {
      final dateTimeNow = TZHelper.instance.now().millisecondsSinceEpoch;

      for (int i = 0; i < result.doseTimes.length; i++) {
        var itemScheduledTime = result.doseTimes[i];
        itemScheduledTime =
            TZHelper.instance.nextSameTimeAfterDay(itemScheduledTime);

        await _createNotificationAndSaved(
          notificationIds[i],
          itemScheduledTime,
          ReminderPeriod.oneTime,
          null,
          dateTimeNow,
          result,
        );
      }
    }
    // #endregion

    // #region  _scheduleForEveryDay
    Future<void> _scheduleForEveryDay(
      List<int> notificationIds,
      MedicationReminderAddEditResult result,
    ) async {
      final dateTimeNow = TZHelper.instance.now();
      final dateTimeNowMilliSeconds = dateTimeNow.millisecondsSinceEpoch;

      for (int i = 0; i < result.doseTimes.length; i++) {
        var itemScheduledTime = result.doseTimes[i];
        itemScheduledTime =
            TZHelper.instance.nextSameTimeAfterDay(itemScheduledTime);

        await _createNotificationAndSaved(
          notificationIds[i],
          itemScheduledTime,
          ReminderPeriod.everyDay,
          null,
          dateTimeNowMilliSeconds,
          result,
        );
      }
    }
    // #endregion

    // #region _scheduleForSpecificDays
    Future<void> _scheduleForSpecificDays(
      List<int> notificationIds,
      MedicationReminderAddEditResult result,
    ) async {
      int idIndex = 0;
      final dateTimeNow = TZHelper.instance.now().millisecondsSinceEpoch;

      for (int i = 0; i < result.days.length; i++) {
        if (result.days[i].selected) {
          for (int y = 0; y < result.doseTimes.length; y++) {
            if (result.days[i].dayIndex != null) {
              await _createNotificationAndSaved(
                notificationIds[idIndex],
                TZHelper.instance.nextInstanceOfDay(i + 1, result.doseTimes[y]),
                ReminderPeriod.specificDays,
                result.days[i].dayIndex!,
                dateTimeNow,
                result,
              );

              idIndex++;
            }
          }
        }
      }
    }
    // #endregion

    //
    try {
      if (!result.isCreated) {
        // Bu plana ait tüm bildirimleri sil ve iptal et.
        await cancelRemindersGroupAndRemove<MedicationReminderModel>(
          result.editCreatedDate!,
          MedicationReminderModel.empty(),
        );
      }

      final notificationIds = await _generateUniqueIdsWithReminderPeriod(
        localNotificationManager,
        result.reminderPeriod,
        result.dailyDose,
        result.days,
      );

      switch (result.reminderPeriod) {
        case ReminderPeriod.oneTime:
          await _scheduleForOneTime(notificationIds, result);
          break;

        case ReminderPeriod.everyDay:
          await _scheduleForEveryDay(notificationIds, result);
          break;

        case ReminderPeriod.specificDays:
          await _scheduleForSpecificDays(notificationIds, result);
          break;

        default:
          break;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
  // #endregion

  /// * "Hba1cReminderAddEditCubit" tarafından çağrılır.
  ///
  /// * result parametresi içerisindeki "isCreated" değeri false ise, bu daha önce oluşturulan bir hatırlatıcıya aittir bu yüzden ilk önce bu plana ait bildirimleri createdDate değerine göre iptal edip, siliyor.
  ///
  /// * Her zaman "Hba1cReminderAddEditResult" tipindeki parametreye göre bildirimleri oluşturup, Shared Preferences'a kaydediyor.
  // #region createOrEditHba1CReminderPlan
  Future<bool> createOrEditHba1CReminderPlan(
    Hba1cReminderAddEditResult result,
  ) async {
    try {
      //
      if (!result.isCreated) {
        // Bu plana ait tüm bildirimleri sil ve iptal et.
        await cancelRemindersGroupAndRemove<Hba1CReminderModel>(
          result.editCreatedDate!,
          Hba1CReminderModel.empty(),
        );
      }

      final notificationId = await generateNotificationId();

      final lastMeasurementDateTime = DateTime.parse(result.lastTestDate!);

      var lastMeasurementDateTimeTZ =
          TZHelper.instance.from(lastMeasurementDateTime.toString());

      final scheduledDateTime = DateTime.parse(result.scheduledDate!);

      final remindDateTime = DateTime(scheduledDateTime.year,
              scheduledDateTime.month, scheduledDateTime.day)
          .add(Duration(hours: result.scheduledHour?.hour ?? 0))
          .add(Duration(minutes: result.scheduledHour?.minute ?? 0));

      var remindDateTimeTZ = TZHelper.instance.from(remindDateTime.toString());

      final currentHbaModel = Hba1CReminderModel(
        notificationId: notificationId,
        scheduledDate: remindDateTimeTZ.millisecondsSinceEpoch,
        createdDate: TZHelper.instance.now().millisecondsSinceEpoch,
        entegrationId: profileStorage.getFirst().id ?? 0,
        lastTestDate: lastMeasurementDateTimeTZ.millisecondsSinceEpoch,
        lastTestValue: result.lastTestValue,
      );

      await reminderNotificationsManager.createHba1c(
        currentHbaModel.notificationId,
        remindDateTimeTZ,
      );

      await _saveReminderEntity<Hba1CReminderModel>(currentHbaModel);

      return true;
    } catch (e) {
      if (e.toString().contains(
          'Invalid argument (scheduledDate): Must be a date in the future')) {
        LoggerUtils.instance.i("Geçmişe hatırlatıcı oluşturulamaz.");
      }

      return false;
    }
  }
  // #endregion

  // #region getAllRelatives - List<ReminderRelativePerson>
  List<ReminderRelativePerson> getAllRelatives() => profileStorage.getAll().map(
        (e) {
          return ReminderRelativePerson(
            id: e.id ?? -1,
            isEnabled: true,
            nameAndSurname: e.name ?? '',
          );
        },
      ).toList();
  // #endregion

  // #region getAllReminders - List<ReminderListModel>
  List<ReminderListModel> getAllReminders() {
    final allProfiles = profileStorage.getAll();

    final result = <ReminderListModel>[];

    final hba1cList =
        _getAllReminderWithType<Hba1CReminderModel>(Hba1CReminderModel.empty());
    final medicineList = _getAllReminderWithType<MedicationReminderModel>(
        MedicationReminderModel.empty());
    final bloodGlucoseList = _getAllReminderWithType<BloodGlucoseReminderModel>(
        BloodGlucoseReminderModel.empty());

    for (var hba1cModel in hba1cList) {
      result.add(
        ReminderListModel(
          notificationId: hba1cModel.notificationId,
          scheduledDate: hba1cModel.scheduledDate,
          createdDate: hba1cModel.createdDate,
          entegrationId: hba1cModel.entegrationId,
          remindable: Remindable.hbA1c,
          title: LocaleProvider.current.hbA1c,
          subTitle: "",
          nameAndSurname: allProfiles
                  .firstWhere(
                      (element) => element.id == hba1cModel.entegrationId)
                  .name ??
              '',
        ),
      );
    }

    for (var medicationModel in medicineList) {
      int scheduledDate = medicationModel.scheduledDate;
      final itemDate = TZHelper.instance
          .fromMillisecondsSinceEpoch(medicationModel.scheduledDate);
      if (medicationModel.reminderPeriod == ReminderPeriod.everyDay) {
        scheduledDate = TZHelper.instance
            .nextSameTimeAfterDay(itemDate)
            .millisecondsSinceEpoch;
      } else if (medicationModel.reminderPeriod ==
          ReminderPeriod.specificDays) {
        scheduledDate = TZHelper.instance
            .nextInstanceOfDay(medicationModel.dayIndex! + 1, itemDate)
            .millisecondsSinceEpoch;
      }

      result.add(
        ReminderListModel(
          notificationId: medicationModel.notificationId,
          scheduledDate: scheduledDate,
          createdDate: medicationModel.createdDate,
          entegrationId: medicationModel.entegrationId,
          remindable: Remindable.medication,
          title:
              '${LocaleProvider.current.medicine} ${medicationModel.drugName}',
          subTitle: medicationModel.drugTracking == DrugTracking.manuel
              ? LocaleProvider.current.manuel
              : LocaleProvider.current.pillar_small,
          nameAndSurname: allProfiles
                  .firstWhere(
                      (element) => element.id == medicationModel.entegrationId)
                  .name ??
              '',
        ),
      );
    }

    for (var bloodGlucoseModel in bloodGlucoseList) {
      int scheduledDate = bloodGlucoseModel.scheduledDate;
      final itemDate = TZHelper.instance
          .fromMillisecondsSinceEpoch(bloodGlucoseModel.scheduledDate);
      if (bloodGlucoseModel.reminderPeriod == ReminderPeriod.everyDay) {
        scheduledDate = TZHelper.instance
            .nextSameTimeAfterDay(itemDate)
            .millisecondsSinceEpoch;
      } else if (bloodGlucoseModel.reminderPeriod ==
          ReminderPeriod.specificDays) {
        scheduledDate = TZHelper.instance
            .nextInstanceOfDay(bloodGlucoseModel.dayIndex! + 1, itemDate)
            .millisecondsSinceEpoch;
      }

      result.add(
        ReminderListModel(
          notificationId: bloodGlucoseModel.notificationId,
          scheduledDate: scheduledDate,
          createdDate: bloodGlucoseModel.createdDate,
          entegrationId: bloodGlucoseModel.entegrationId,
          remindable: Remindable.bloodGlucose,
          title: LocaleProvider.current.blood_glucose_measurement_title,
          subTitle: bloodGlucoseModel.usageType.xGetText,
          nameAndSurname: allProfiles
                  .firstWhere((element) =>
                      element.id == bloodGlucoseModel.entegrationId)
                  .name ??
              '',
        ),
      );
    }

    return result.xSortedBy((element) => element.scheduledDate).toList();
  }
  // #endregion

  // #region cancelAndRemoveNotification - Future<bool>
  Future<bool> cancelAndRemoveNotification(
    Remindable remindable,
    int notificationId,
    int scheduledDate,
    int createdDate,
    int entegrationId,
  ) async {
    try {
      // Notification'ı iptal et
      await localNotificationManager.cancelNotification(notificationId);

      // Shared Preferences'da ki listeyi güncelle
      switch (remindable) {
        case Remindable.bloodGlucose:
          {
            await _updateLocalList(
              notificationId,
              SharedPreferencesKeys.bloodGlucoseList,
              BloodGlucoseReminderModel(
                notificationId: notificationId,
                scheduledDate: scheduledDate,
                createdDate: createdDate,
                entegrationId: entegrationId,
              ),
            );
            break;
          }

        case Remindable.strip:
          break;

        case Remindable.medication:
          {
            await _updateLocalList(
              notificationId,
              SharedPreferencesKeys.medicineList,
              MedicationReminderModel(
                notificationId: notificationId,
                scheduledDate: scheduledDate,
                createdDate: createdDate,
                entegrationId: entegrationId,
              ),
            );
            break;
          }

        case Remindable.hbA1c:
          {
            await _updateLocalList(
              notificationId,
              SharedPreferencesKeys.hba1cList,
              Hba1CReminderModel(
                notificationId: notificationId,
                scheduledDate: scheduledDate,
                createdDate: createdDate,
                entegrationId: entegrationId,
              ),
            );
            break;
          }
      }

      return true;
    } catch (e) {
      return false;
    }
  }
  // #endregion

  // #region getReminderDetailResult - ReminderDetailResult?
  ReminderDetailResult? getReminderDetailResult(
    Remindable remindable,
    int notificationId,
  ) {
    switch (remindable) {
      case Remindable.bloodGlucose:
        final result = getBloodGlucoseById(notificationId);
        if (result != null) {
          return ReminderDetailResult.bloodGlucose(result);
        }
        break;

      case Remindable.strip:
        break;

      case Remindable.medication:
        final result = getMedicationById(notificationId);
        if (result != null) {
          return ReminderDetailResult.medication(result);
        }
        break;

      case Remindable.hbA1c:
        final result = getHba1CById(notificationId);
        if (result != null) {
          return ReminderDetailResult.hba1C(result);
        }
        break;
    }

    return null;
  }
  // #endregion

  // #region filterList - List<AllReminderListModel>
  List<ReminderListModel> filterList(
    List<ReminderListModel> allList,
    ReminderListFilterResult filterResult,
  ) {
    final relativeList = filterResult.relativeList
        .where((element) => element.isEnabled)
        .toList();
    var filterList = allList.where((element) {
      if (filterResult.isBloodGlucose) {
        if (element.remindable == Remindable.bloodGlucose) {
          return true;
        }
      }

      if (filterResult.isHbA1c) {
        if (element.remindable == Remindable.hbA1c) {
          return true;
        }
      }

      if (filterResult.isStrip) {
        if (element.remindable == Remindable.strip) {
          return true;
        }
      }

      if (filterResult.isMedication) {
        if (element.remindable == Remindable.medication) {
          return true;
        }
      }

      return false;
    }).toList();

    filterList = filterList.where((element) {
      for (var relative in relativeList) {
        if (relative.id == element.entegrationId) {
          return true;
        }
      }

      return false;
    }).toList();

    return filterList;
  }
  // #endregion

  // #region getBloodGlucoseDetailResult - BloodGlucoseReminderAddEditResult?
  BloodGlucoseReminderAddEditResult? getBloodGlucoseDetailResult(
    int createdDate,
  ) {
    final sharedList =
        getRemindersGroupWithCreatedDate<BloodGlucoseReminderModel>(
      createdDate,
      BloodGlucoseReminderModel.empty(),
    );
    if (sharedList.isNotEmpty) {
      final activeDays = sharedList.map((e) => e.dayIndex).toSet().toList();
      final days = getSelectableDays(activeDays);

      final now = TZHelper.instance.currentDay();
      var tempList = <TimeOfDay>[];
      for (var element in sharedList) {
        final itemDate =
            TZHelper.instance.fromMillisecondsSinceEpoch(element.scheduledDate);
        tempList.add(TimeOfDay(hour: itemDate.hour, minute: itemDate.minute));
      }
      tempList = tempList.toSet().toList();
      var doseTimes = tempList
          .map((e) => now.add(Duration(hours: e.hour, minutes: e.minute)))
          .toList();

      final firstItem = sharedList.first;
      return BloodGlucoseReminderAddEditResult(
        isCreated: false,
        editCreatedDate: createdDate,
        usageType: firstItem.usageType,
        reminderPeriod: firstItem.reminderPeriod,
        dailyDose: firstItem.dailyDose,
        doseTimes: doseTimes,
        days: days,
      );
    }

    return null;
  }
  // #endregion

  // #region getMedicationDetailResult - MedicationReminderAddEditResult?
  MedicationReminderAddEditResult? getMedicationDetailResult(int createdDate) {
    final sharedList =
        getRemindersGroupWithCreatedDate<MedicationReminderModel>(
      createdDate,
      MedicationReminderModel.empty(),
    );

    if (sharedList.isNotEmpty) {
      final activeDays = sharedList.map((e) => e.dayIndex).toSet().toList();
      final days = getSelectableDays(activeDays);

      final now = TZHelper.instance.currentDay();
      var tempList = <TimeOfDay>[];
      for (var element in sharedList) {
        final itemDate =
            TZHelper.instance.fromMillisecondsSinceEpoch(element.scheduledDate);
        tempList.add(TimeOfDay(hour: itemDate.hour, minute: itemDate.minute));
      }
      tempList = tempList.toSet().toList();
      var doseTimes = tempList
          .map((e) => now.add(Duration(hours: e.hour, minutes: e.minute)))
          .toList();

      final firstItem = sharedList.first;
      return MedicationReminderAddEditResult(
        isCreated: false,
        editCreatedDate: createdDate,
        drugTracking: firstItem.drugTracking ?? DrugTracking.manuel,
        drugName: firstItem.drugName,
        usageType: firstItem.usageType,
        reminderPeriod: firstItem.reminderPeriod,
        dailyDose: firstItem.dailyDose,
        oneTimeDose: firstItem.oneTimeDose,
        doseTimes: doseTimes,
        days: days,
        drugCount: firstItem.drugCount,
        remainingCountNotification: firstItem.remainingCountNotification,
        boxCode: firstItem.boxCode,
      );
    }

    return null;
  }
  // #endregion

  // #region getHba1CDetailResult - Hba1cReminderAddEditResult?
  Hba1cReminderAddEditResult? getHba1CDetailResult(int notificationId) {
    final localModel = getHba1CById(notificationId);
    if (localModel != null) {
      final createdDate = localModel.createdDate;
      final remindDate = localModel.scheduledDate.xGetTZDateTime;
      final scheduledDate = remindDate.toString();
      final scheduledHour = TimeOfDay(
        hour: remindDate.hour,
        minute: remindDate.minute,
      );
      final lastTestDate = localModel.lastTestDate!.xGetTZDateTime.toString();
      final lastTestValue = localModel.lastTestValue ?? 0;
      return Hba1cReminderAddEditResult(
        isCreated: false,
        editNotificationId: notificationId,
        editCreatedDate: createdDate,
        scheduledDate: scheduledDate,
        scheduledHour: scheduledHour,
        lastTestDate: lastTestDate,
        lastTestValue: lastTestValue,
      );
    }

    return null;
  }
  // #endregion

  // #region getBloodGlucoseById - BloodGlucoseReminderModel?
  BloodGlucoseReminderModel? getBloodGlucoseById(int notificationId) =>
      _getNotificationDetail(
        notificationId,
        BloodGlucoseReminderModel.empty(),
        SharedPreferencesKeys.bloodGlucoseList,
      );
  // #endregion

  // #region getMedicationById - MedicationReminderModel?
  MedicationReminderModel? getMedicationById(int notificationId) =>
      _getNotificationDetail(
        notificationId,
        MedicationReminderModel.empty(),
        SharedPreferencesKeys.medicineList,
      );
  // #endregion

  // #region getHba1CById - Hba1CReminderModel?
  Hba1CReminderModel? getHba1CById(int notificationId) =>
      _getNotificationDetail(
        notificationId,
        Hba1CReminderModel.empty(),
        SharedPreferencesKeys.hba1cList,
      );
  // #endregion

  // #region getSelectableDays
  List<SelectableDay> getSelectableDays([List<int?> activeDays = const []]) {
    final _days = <SelectableDay>[];
    final _kTempList = _kDaysOfWeek;
    for (var i = 0; i < _kTempList.length; i++) {
      _days.add(
        SelectableDay(
          name: _kTempList[i]['name'],
          selected: activeDays.contains(i),
          day: _kTempList[i]['day'],
          dayIndex: i,
          shortName: _kTempList[i]['shortName'],
        ),
      );
    }
    return _days;
  }
  // #endregion

  // #region calculateDoseTimes
  List<tz.TZDateTime>? calculateDoseTimes(int dailyDose) {
    if (dailyDose == 0) return null;

    int perMinute = ((24 * 60) / dailyDose).round();
    int hour = perMinute < 60 ? perMinute : (perMinute / 60).round();
    int minute = perMinute < 60 ? 0 : perMinute - hour * 60;
    List<tz.TZDateTime> doseTimeList = [];

    doseTimeList.add(
      TZHelper.instance.currentDay(),
    );

    for (var i = 1; i < dailyDose; i++) {
      doseTimeList.add(
        doseTimeList.first.add(
          Duration(hours: i * hour, minutes: i * minute),
        ),
      );
    }
    return doseTimeList;
  }
  // #endregion

  // #region generateNotificationId - Future<int>
  Future<int> generateNotificationId() async {
    final _pendingList =
        await localNotificationManager.getPendingNotificationIds();
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

  // #region _generateUniqueIdsWithReminderPeriod - Future<List<int>>
  Future<List<int>> _generateUniqueIdsWithReminderPeriod(
    LocalNotificationManager notificationManager,
    ReminderPeriod? period,
    int? dailyDose,
    List<SelectableDay> days,
  ) async {
    final _pendingList = await notificationManager.getPendingNotificationIds();
    int requiredIdCount = 0;
    if (period == ReminderPeriod.oneTime) {
      requiredIdCount = dailyDose ?? 0;
    } else if (period == ReminderPeriod.everyDay) {
      requiredIdCount = dailyDose ?? 0;
    } else if (period == ReminderPeriod.specificDays) {
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

  // ! ------- ------- Generics ------- -------

  // #region cancelRemindersGroupAndRemove - Future<void>
  Future<void> cancelRemindersGroupAndRemove<T extends ReminderEntity>(
    int createdDate,
    T entity,
  ) async {
    final sharedList = _getAllReminderWithType<T>(entity);

    // Notificationlar'ı iptal et
    await Future.forEach<T>(
      sharedList,
      (item) async {
        if (item.createdDate == createdDate) {
          // Notification'ı iptal et
          await localNotificationManager
              .cancelNotification(item.notificationId);
        }
      },
    );

    sharedList.removeWhere((element) => element.createdDate == createdDate);

    await _saveReminders(sharedList, entity.xGetSharedKeys);
  }
  // #endregion

  // #region getRemindersGroupWithCreatedDate - List<T>
  List<T> getRemindersGroupWithCreatedDate<T extends ReminderEntity>(
    int createdDate,
    T entity,
  ) {
    final sharedList =
        sharedPreferencesManager.getStringList(entity.xGetSharedKeys) ?? [];
    final tempList = <T>[];
    for (String item in sharedList) {
      final json = jsonDecode(item);
      tempList.add(entity.fromJson(json));
    }
    return tempList
        .where((element) => element.createdDate == createdDate)
        .toList();
  }
  // #endregion

  // #region _getAllReminderWithType - List<T>
  List<T> _getAllReminderWithType<T extends ReminderEntity>(T entity) {
    final sharedList =
        sharedPreferencesManager.getStringList(entity.xGetSharedKeys) ?? [];
    final tempList = <T>[];
    for (String item in sharedList) {
      final json = jsonDecode(item);
      tempList.add(entity.fromJson(json));
    }
    return tempList;
  }
  // #endregion

  // #region _saveReminders - Future<void>
  Future<void> _saveReminders<T extends ReminderEntity>(
    List<T> reminderList,
    SharedPreferencesKeys sharedKeys,
  ) async {
    List<String> savedList = [];
    if (reminderList.isNotEmpty) {
      for (var item in reminderList) {
        final itemStr = jsonEncode(item.toJson());
        savedList.add(itemStr);
      }
    }
    await sharedPreferencesManager.setStringList(
      sharedKeys,
      savedList,
    );
  }
  // #endregion

  // #region _saveReminderEntity - Future<void>
  Future<void> _saveReminderEntity<T extends ReminderEntity>(T entity) async {
    final map = jsonEncode(entity.toJson());
    final sharedList =
        sharedPreferencesManager.getStringList(entity.xGetSharedKeys) ?? [];
    sharedList.add(map);
    await sharedPreferencesManager.setStringList(
      entity.xGetSharedKeys,
      sharedList,
    );
  }
  // #endregion

  // #region _getNotificationDetail - T?
  T? _getNotificationDetail<T extends ReminderEntity>(
    int notificationId,
    T entity,
    SharedPreferencesKeys keys,
  ) {
    final sharedList = sharedPreferencesManager.getStringList(keys) ?? [];
    final tempList = <T>[];
    for (String item in sharedList) {
      final json = jsonDecode(item);
      tempList.add(entity.fromJson(json));
    }
    return tempList.firstWhereOrNull(
      (element) => element.notificationId == notificationId,
    );
  }
  // #endregion

  // #region _updateLocalList - Future<void>
  Future<void> _updateLocalList<T extends ReminderEntity>(
    int notificationId,
    SharedPreferencesKeys sharedKeys,
    T entity,
  ) async {
    final localList = sharedPreferencesManager.getStringList(sharedKeys) ?? [];
    List<T> prefList = [];
    for (String item in localList) {
      final json = jsonDecode(item);
      prefList.add(entity.fromJson(json));
    }
    prefList.removeWhere((item) => item.notificationId == notificationId);
    List<String> saveList = [];
    for (var item in prefList) {
      final itemStr = jsonEncode(item.toJson());
      saveList.add(itemStr);
    }
    await sharedPreferencesManager.setStringList(
      sharedKeys,
      saveList,
    );
  }
  // #endregion

  // ! ------- ------- Constants ------- -------

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
