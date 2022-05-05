import '../../../../core/core.dart';

abstract class ReminderEntity<T> {
  final int notificationId;
  final Remindable remindable;
  final int scheduledDate;
  final int createdDate;
  final int entegrationId;
  final String? nameAndSurname;
  bool status;

  ReminderEntity({
    required this.notificationId,
    required this.remindable,
    required this.scheduledDate,
    required this.createdDate,
    required this.entegrationId,
    required this.nameAndSurname,
    required this.status,
  });

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'remindable': remindable.xRawValue,
        'scheduledDate': scheduledDate,
        'createdDate': createdDate,
        'entegrationId': entegrationId,
        'nameAndSurname': nameAndSurname,
        'status': status,
      };
}

extension ReminderEntityExtension on ReminderEntity<dynamic>? {
  SharedPreferencesKeys get xGetSharedKeys {
    if (this == null) {
      throw Exception("ReminderEntity is null");
    }

    switch (this!.remindable) {
      case Remindable.bloodGlucose:
        return SharedPreferencesKeys.bloodGlucoseList;

      case Remindable.medication:
        return SharedPreferencesKeys.medicineList;

      case Remindable.hbA1c:
        return SharedPreferencesKeys.hba1cList;

      case Remindable.strip:
        throw Exception("Uninplemented");
    }
  }
}
