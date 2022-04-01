import 'dart:convert';

class Hba1CForScheduleModel {
  int? notificationId;
  String? lastTestDate;
  String? lastTestValue;
  String? scheduledDate;
  int? createdDate;

  Hba1CForScheduleModel({
    this.notificationId,
    this.lastTestDate,
    this.lastTestValue,
    this.scheduledDate,
    this.createdDate,
  });

  factory Hba1CForScheduleModel.fromJson(Map<String, dynamic> json) =>
      Hba1CForScheduleModel(
        notificationId: json["notificationId"],
        lastTestDate: json["lastTestDate"],
        lastTestValue: json["lastTestValue"],
        scheduledDate: json["scheduledDate"],
        createdDate: json["createdDate"],
      );

  Map<String, dynamic> toJson() => {
        "notificationId": notificationId,
        "lastTestDate": lastTestDate,
        "lastTestValue": lastTestValue,
        "scheduledDate": scheduledDate,
        "createdDate": createdDate,
      };

  Hba1CForScheduleModel copyWith({
    int? notificationId,
    String? lastTestDate,
    String? lastTestValue,
    String? scheduledDate,
    int? createdDate,
  }) {
    return Hba1CForScheduleModel(
      notificationId: notificationId ?? this.notificationId,
      lastTestDate: lastTestDate ?? this.lastTestDate,
      lastTestValue: lastTestValue ?? this.lastTestValue,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  String toString() {
    return 'Hba1CForScheduleModel(notificationId: $notificationId, lastTestDate: $lastTestDate, lastTestValue: $lastTestValue, scheduledDate: $scheduledDate, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hba1CForScheduleModel &&
        other.notificationId == notificationId &&
        other.lastTestDate == lastTestDate &&
        other.lastTestValue == lastTestValue &&
        other.scheduledDate == scheduledDate &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return notificationId.hashCode ^
        lastTestDate.hashCode ^
        lastTestValue.hashCode ^
        scheduledDate.hashCode ^
        createdDate.hashCode;
  }
}
