import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../features/mediminder/mediminder.dart';
import '../../core.dart';
import '../../utils/tz_helper.dart';

class ReminderRepository {
  final ProfileStorageImpl profileStorage;
  final ISharedPreferencesManager sharedPreferencesManager;
  final LocalNotificationManager localNotificationManager;
  final ReminderNotificationsManager reminderNotificationsManager;

  ReminderRepository(
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
      MedicinePeriod period,
      int? dayIndex,
      int createdDate,
      BloodGlucoseReminderAddEditResult result,
    ) async {
      await reminderNotificationsManager.createMedinicineOrBloodGlucose(
        id,
        LocaleProvider.current.blood_glucose_measurement,
        LocaleProvider.current.bg_measurement_time,
        scheduledDate,
        period,
      );

      saveScheduledMedicine(
        BloodGlucoseReminderModel(
          notificationId: id,
          scheduledDate: scheduledDate.millisecondsSinceEpoch,
          createdDate: createdDate,
          entegrationId: profileStorage.getFirst().id ?? 0,
          dayIndex: dayIndex,
          dailyDose: result.dailyDose,
          medicinePeriod: result.medicinePeriod,
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
          MedicinePeriod.oneTime,
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
          MedicinePeriod.everyDay,
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
                MedicinePeriod.specificDays,
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
        await cancelAndRemoveNotificationBloodGlucose(result.editCreatedDate!);
      }

      final notificationIds =
          await ReminderHelper.instance.generateUniqueIdsWithMedicinePeriod(
        localNotificationManager,
        result.medicinePeriod,
        result.dailyDose,
        result.days,
      );

      switch (result.medicinePeriod) {
        case MedicinePeriod.oneTime:
          await _scheduleForOneTime(notificationIds, result);
          break;

        case MedicinePeriod.everyDay:
          await _scheduleForEveryDay(notificationIds, result);
          break;

        case MedicinePeriod.specificDays:
          await _scheduleForSpecificDays(notificationIds, result);
          break;

        case MedicinePeriod.intermittentDays:
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
        await cancelAndRemoveNotificationHba1C(result.editCreatedDate!);
      }

      final notificationId = await ReminderHelper.instance
          .generateNotificationId(localNotificationManager);

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
        currentHbaModel,
        remindDateTimeTZ,
      );

      await saveScheduledHba1c(currentHbaModel);

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

  // #region saveScheduledMedicine
  Future<void> saveScheduledMedicine(BloodGlucoseReminderModel medicine) async {
    final medicineStr = jsonEncode(medicine.toJson());
    final sharedList = sharedPreferencesManager
            .getStringList(SharedPreferencesKeys.bloodGlucoseList) ??
        [];
    sharedList.add(medicineStr);
    await sharedPreferencesManager.setStringList(
      SharedPreferencesKeys.bloodGlucoseList,
      sharedList,
    );
  }
  // #endregion

  // #region getAllRelatives
  List<AllReminderRelativePerson> getAllRelatives() =>
      profileStorage.getAll().map(
        (e) {
          return AllReminderRelativePerson(
            id: e.id ?? -1,
            isEnabled: true,
            nameAndSurname: e.name ?? '',
          );
        },
      ).toList();
  // #endregion

  // #region getAllReminders
  List<AllReminderListModel> getAllReminders() {
    final allProfiles = profileStorage.getAll();

    final result = <AllReminderListModel>[];

    final hba1cList = sharedPreferencesManager
            .getStringList(SharedPreferencesKeys.hba1cList) ??
        [];
    final medicineList = sharedPreferencesManager
            .getStringList(SharedPreferencesKeys.medicineList) ??
        [];
    final bloodGlucoseList = sharedPreferencesManager
            .getStringList(SharedPreferencesKeys.bloodGlucoseList) ??
        [];

    for (var item in hba1cList) {
      final hba1cModel = Hba1CReminderModel.fromJson(jsonDecode(item));
      result.add(
        AllReminderListModel(
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

    for (var item in medicineList) {
      final medicationModel =
          MedicationReminderModel.fromJson(jsonDecode(item));
      result.add(
        AllReminderListModel(
          notificationId: medicationModel.notificationId,
          scheduledDate: medicationModel.scheduledDate,
          createdDate: medicationModel.createdDate,
          entegrationId: medicationModel.entegrationId,
          remindable: Remindable.medication,
          title: '${LocaleProvider.current.medicine} ${medicationModel.name}',
          subTitle: "",
          nameAndSurname: allProfiles
                  .firstWhere(
                      (element) => element.id == medicationModel.entegrationId)
                  .name ??
              '',
        ),
      );
    }

    for (var item in bloodGlucoseList) {
      final bloodGlucoseModel =
          BloodGlucoseReminderModel.fromJson(jsonDecode(item));

      int scheduledDate = bloodGlucoseModel.scheduledDate;
      final itemDate = TZHelper.instance
          .fromMillisecondsSinceEpoch(bloodGlucoseModel.scheduledDate);
      if (bloodGlucoseModel.medicinePeriod == MedicinePeriod.everyDay) {
        scheduledDate = TZHelper.instance
            .nextSameTimeAfterDay(itemDate)
            .millisecondsSinceEpoch;
      } else if (bloodGlucoseModel.medicinePeriod ==
          MedicinePeriod.specificDays) {
        scheduledDate = TZHelper.instance
            .nextInstanceOfDay(bloodGlucoseModel.dayIndex! + 1, itemDate)
            .millisecondsSinceEpoch;
      }

      result.add(
        AllReminderListModel(
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

  // #region cancelAndRemoveNotification
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

  // #region cancelAndRemoveNotificationBloodGlucose
  Future<void> cancelAndRemoveNotificationBloodGlucose(
    int createdDate,
  ) async {
    final sharedList = sharedPreferencesManager
            .getStringList(SharedPreferencesKeys.bloodGlucoseList) ??
        [];
    final tempList = <BloodGlucoseReminderModel>[];
    for (String item in sharedList) {
      final json = jsonDecode(item);
      tempList.add(BloodGlucoseReminderModel.fromJson(json));
    }

    // Notificationlar'ı iptal et
    await Future.forEach<BloodGlucoseReminderModel>(
      tempList,
      (item) async {
        if (item.createdDate == createdDate) {
          // Notification'ı iptal et
          await getIt<LocalNotificationManager>()
              .cancelNotification(item.notificationId);
        }
      },
    );

    tempList.removeWhere((element) => element.createdDate == createdDate);

    List<String> savedList = [];
    if (sharedList.isNotEmpty) {
      for (var item in tempList) {
        final itemStr = jsonEncode(item.toJson());
        savedList.add(itemStr);
      }
    }
    await getIt<ISharedPreferencesManager>().setStringList(
      SharedPreferencesKeys.bloodGlucoseList,
      savedList,
    );
  }
  // #endregion

  // #region cancelAndRemoveNotificationHba1C
  Future<void> cancelAndRemoveNotificationHba1C(
    int createdDate,
  ) async {
    final sharedList = sharedPreferencesManager
            .getStringList(SharedPreferencesKeys.hba1cList) ??
        [];
    final tempList = <Hba1CReminderModel>[];
    for (String item in sharedList) {
      final json = jsonDecode(item);
      tempList.add(Hba1CReminderModel.fromJson(json));
    }

    // Notificationlar'ı iptal et
    await Future.forEach<Hba1CReminderModel>(
      tempList,
      (item) async {
        if (item.createdDate == createdDate) {
          // Notification'ı iptal et
          await getIt<LocalNotificationManager>()
              .cancelNotification(item.notificationId);
        }
      },
    );

    tempList.removeWhere((element) => element.createdDate == createdDate);

    List<String> savedList = [];
    if (sharedList.isNotEmpty) {
      for (var item in tempList) {
        final itemStr = jsonEncode(item.toJson());
        savedList.add(itemStr);
      }
    }
    await getIt<ISharedPreferencesManager>().setStringList(
      SharedPreferencesKeys.hba1cList,
      savedList,
    );
  }
  // #endregion

  // #region getReminderDetailResult
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

  // #region getNotificationList
  List<T> getNotificationList<T extends ReminderEntity>(
    int createdDate,
    T entity,
    SharedPreferencesKeys keys,
  ) {
    final sharedList = sharedPreferencesManager.getStringList(keys) ?? [];
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

  // #region filterList
  List<AllReminderListModel> filterList(
    List<AllReminderListModel> allList,
    AllReminderListFilterResult filterResult,
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

  // #region getBloodGlucoseById
  BloodGlucoseReminderModel? getBloodGlucoseById(int notificationId) =>
      _getNotificationDetail(
        notificationId,
        BloodGlucoseReminderModel.empty(),
        SharedPreferencesKeys.bloodGlucoseList,
      );
  // #endregion

  // #region getMedicationById
  MedicationReminderModel? getMedicationById(int notificationId) =>
      _getNotificationDetail(
        notificationId,
        MedicationReminderModel.empty(),
        SharedPreferencesKeys.medicineList,
      );
  // #endregion

  // #region saveScheduledHba1c
  Future<void> saveScheduledHba1c(Hba1CReminderModel hba1c) async {
    final newHba1cJson = jsonEncode(hba1c.toJson());
    final sharedList = getIt<ISharedPreferencesManager>()
            .getStringList(SharedPreferencesKeys.hba1cList) ??
        [];
    sharedList.add(newHba1cJson);
    await getIt<ISharedPreferencesManager>().setStringList(
      SharedPreferencesKeys.hba1cList,
      sharedList,
    );
  }
  // #endregion

  // #region getBloodGlucoseDetailResult
  BloodGlucoseReminderAddEditResult? getBloodGlucoseDetailResult(
    int createdDate,
    List<SelectableDay> days,
  ) {
    final sharedList = getNotificationList<BloodGlucoseReminderModel>(
      createdDate,
      BloodGlucoseReminderModel.empty(),
      SharedPreferencesKeys.bloodGlucoseList,
    );
    if (sharedList.isNotEmpty) {
      final firstItem = sharedList.first;
      return BloodGlucoseReminderAddEditResult(
        isCreated: false,
        editCreatedDate: createdDate,
        usageType: firstItem.usageType,
        medicinePeriod: firstItem.medicinePeriod,
        dailyDose: firstItem.dailyDose,
        doseTimes: sharedList
            .map((e) =>
                TZHelper.instance.fromMillisecondsSinceEpoch(e.scheduledDate))
            .toList(),
        days: days,
      );
    }

    return null;
  }
  // #endregion

  // #region getHba1CDetailResult
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

  // #region getHba1CById
  Hba1CReminderModel? getHba1CById(int notificationId) =>
      _getNotificationDetail(
        notificationId,
        Hba1CReminderModel.empty(),
        SharedPreferencesKeys.hba1cList,
      );
  // #endregion

  // #region _getNotificationDetail
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

  // #region _updateLocalList
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
}
