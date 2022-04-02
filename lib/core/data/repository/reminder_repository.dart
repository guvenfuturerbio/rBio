import 'dart:convert';
import 'package:collection/collection.dart';

import '../../../features/mediminder/mediminder.dart';
import '../../core.dart';

class ReminderRepository {
  final ProfileStorageImpl profileStorage;
  final ISharedPreferencesManager sharedPreferencesManager;
  final LocalNotificationManager localNotificationManager;

  ReminderRepository(
    this.profileStorage,
    this.sharedPreferencesManager,
    this.localNotificationManager,
  );

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
      result.add(
        AllReminderListModel(
          notificationId: bloodGlucoseModel.notificationId,
          scheduledDate: bloodGlucoseModel.scheduledDate,
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

    return result;
  }

  Future<void> cancelAndRemoveNotification(
    Remindable remindable,
    int notificationId,
    int scheduledDate,
    int createdDate,
    int entegrationId,
  ) async {
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
  }

  Future<void> _updateLocalList<T extends ReminderEntity>(
    int notificationId,
    SharedPreferencesKeys sharedKeys,
    T entity,
  ) async {
    List<String> jsonList =
        sharedPreferencesManager.getStringList(sharedKeys) ?? [];
    List<T> prefList = [];
    for (String jsonMedicine in jsonList) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonMedicine);
      prefList.add(entity.fromJson(jsonMap));
    }
    prefList.removeWhere((item) => item.notificationId == notificationId);
    List<String> saveList = [];
    for (var medicines in prefList) {
      String medicineJson = jsonEncode(medicines.toJson());
      saveList.add(medicineJson);
    }
    await sharedPreferencesManager.setStringList(
      sharedKeys,
      saveList,
    );
  }

  ReminderDetailResult? getReminderDetailResult(
    Remindable remindable,
    int notificationId,
  ) {
    switch (remindable) {
      case Remindable.bloodGlucose:
        {
          final result = _getNotificationDetail<BloodGlucoseReminderModel>(
            notificationId,
            BloodGlucoseReminderModel.empty(),
            SharedPreferencesKeys.bloodGlucoseList,
          );
          if (result != null) {
            return ReminderDetailResult.bloodGlucose(result);
          }

          break;
        }

      case Remindable.strip:
        {
          break;
        }

      case Remindable.medication:
        {
          final result = _getNotificationDetail<MedicationReminderModel>(
            notificationId,
            MedicationReminderModel.empty(),
            SharedPreferencesKeys.medicineList,
          );
          if (result != null) {
            return ReminderDetailResult.medication(result);
          }

          break;
        }

      case Remindable.hbA1c:
        {
          final result = _getNotificationDetail<Hba1CReminderModel>(
            notificationId,
            Hba1CReminderModel.empty(),
            SharedPreferencesKeys.hba1cList,
          );
          if (result != null) {
            return ReminderDetailResult.hba1C(result);
          }

          break;
        }
    }

    return null;
  }

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
}
