import '../../../../../core/core.dart';
import '../../mediminder.dart';

class ReminderListModel {
  final int notificationId;
  final int scheduledDate;
  final int createdDate;
  final int entegrationId;
  final Remindable remindable;
  final String title;
  final String? subTitle;
  final String nameAndSurname;
  final bool status;
  final MedicationReminderModel? medicationReminderModel;

  ReminderListModel({
    required this.notificationId,
    required this.scheduledDate,
    required this.createdDate,
    required this.entegrationId,
    required this.remindable,
    required this.title,
    this.subTitle,
    required this.nameAndSurname,
    required this.status,
    this.medicationReminderModel,
  });
}
