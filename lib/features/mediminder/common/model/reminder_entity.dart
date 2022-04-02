import '../../../../core/core.dart';

class ReminderEntity {
  final int notificationId;
  final Remindable remindable;
  final int scheduledDate;
  final int createdDate;

  ReminderEntity({
    required this.notificationId,
    required this.remindable,
    required this.scheduledDate,
    required this.createdDate,
  });

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'remindable': remindable.xRawValue,
        'scheduledDate': scheduledDate,
        'createdDate': createdDate,
      };

  factory ReminderEntity.fromJson(Map<String, dynamic> json) => ReminderEntity(
        notificationId: json['notificationId'] as int,
        remindable: (json['remindable'] as String).xRemindableKeys!,
        scheduledDate: json['scheduledDate'] as int,
        createdDate: json['createdDate'] as int,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReminderEntity &&
        other.notificationId == notificationId &&
        other.remindable == remindable &&
        other.scheduledDate == scheduledDate &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return notificationId.hashCode ^
        remindable.hashCode ^
        scheduledDate.hashCode ^
        createdDate.hashCode;
  }
}
