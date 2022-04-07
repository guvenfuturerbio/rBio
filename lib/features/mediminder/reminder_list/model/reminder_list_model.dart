import '../../../../../core/core.dart';

class ReminderListModel {
  final int notificationId;
  final int scheduledDate;
  final int createdDate;
  /// /profile/get-all
  final int entegrationId;
  final Remindable remindable;
  final String title;
  final String? subTitle;
  final String nameAndSurname;

  ReminderListModel({
    required this.notificationId,
    required this.scheduledDate,
    required this.createdDate,
    required this.entegrationId,
    required this.remindable,
    required this.title,
    this.subTitle,
    required this.nameAndSurname,
  });
}
