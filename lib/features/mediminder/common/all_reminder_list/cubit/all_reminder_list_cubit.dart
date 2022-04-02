import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onedosehealth/core/core.dart';

import '../../../mediminder.dart';

part 'all_reminder_list_cubit.freezed.dart';
part 'all_reminder_list_state.dart';

class AllReminderListCubit extends Cubit<AllReminderListState> {
  AllReminderListCubit(this._sharedPreferencesManager)
      : super(const AllReminderListState.initial());
  final ISharedPreferencesManager _sharedPreferencesManager;

  FutureOr<void> fetchAll() async {
    emit(const AllReminderListState.loadInProgress());
    emit(
      AllReminderListState.success(
        AllReminderListResult(_getAll()),
      ),
    );
  }

  // #region _getAll
  List<AllReminderListModel> _getAll() {
    final allProfiles = getIt<ProfileStorageImpl>().getAll();

    final result = <AllReminderListModel>[];

    final hba1cList = _sharedPreferencesManager
            .getStringList(SharedPreferencesKeys.hba1cList) ??
        [];
    final medicineList = _sharedPreferencesManager
            .getStringList(SharedPreferencesKeys.medicineList) ??
        [];
    final bloodGlucoseList = _sharedPreferencesManager
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
  // #endregion

  Future<void> removeReminder(AllReminderListModel model) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (successResult) async {
        final currentList = successResult.list;

        // Vm'de ki listeden item'ı sil
        currentList
            .removeWhere((item) => item.notificationId == model.notificationId);

        // Notification'ı iptal et
        await getIt<LocalNotificationManager>()
            .cancelNotification(model.notificationId);

        // Shared Preferences'da ki listeyi güncelle
        switch (model.remindable) {
          case Remindable.bloodGlucose:
            {
              await _updateLocalList(
                model.notificationId,
                SharedPreferencesKeys.bloodGlucoseList,
                BloodGlucoseReminderModel(
                  notificationId: model.notificationId,
                  scheduledDate: model.scheduledDate,
                  createdDate: model.createdDate,
                  entegrationId: model.entegrationId,
                ),
              );
              break;
            }

          case Remindable.strip:
            // TODO: Handle this case.
            break;

          case Remindable.medication:
            {
              await _updateLocalList(
                model.notificationId,
                SharedPreferencesKeys.medicineList,
                MedicationReminderModel(
                  notificationId: model.notificationId,
                  scheduledDate: model.scheduledDate,
                  createdDate: model.createdDate,
                  entegrationId: model.entegrationId,
                ),
              );
              break;
            }

          case Remindable.hbA1c:
            {
              await _updateLocalList(
                model.notificationId,
                SharedPreferencesKeys.hba1cList,
                Hba1CReminderModel(
                  notificationId: model.notificationId,
                  scheduledDate: model.scheduledDate,
                  createdDate: model.createdDate,
                  entegrationId: model.entegrationId,
                ),
              );
              break;
            }
        }

        emit(
          AllReminderListState.success(
            AllReminderListResult(currentList),
          ),
        );
      },
    );
  }

  Future<void> _updateLocalList<T extends ReminderEntity>(
    int notificationId,
    SharedPreferencesKeys sharedKeys,
    T entity,
  ) async {
    List<String> jsonList =
        _sharedPreferencesManager.getStringList(sharedKeys) ?? [];
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
    await _sharedPreferencesManager.setStringList(
      sharedKeys,
      saveList,
    );
  }
}
