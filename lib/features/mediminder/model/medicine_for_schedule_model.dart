class MedicineForScheduledModel {
  int? notificationId;
  String? name;
  int? dayIndex;
  String? time;
  int? dosage;
  String? medicinePeriod;
  String? remindable;
  String? usageType;
  int? scheduledDate;
  int? createdDate;

  MedicineForScheduledModel({
    this.notificationId,
    this.name,
    this.dayIndex,
    this.time,
    this.medicinePeriod,
    this.dosage,
    this.remindable,
    this.usageType,
    this.scheduledDate,
    this.createdDate,
  });

  factory MedicineForScheduledModel.fromJson(Map<String, dynamic> parsedJson) {
    return MedicineForScheduledModel(
      notificationId: parsedJson['id'],
      name: parsedJson['name'],
      dayIndex: parsedJson['day'],
      time: parsedJson['time'],
      medicinePeriod: parsedJson['medicinePeriod'],
      dosage: parsedJson['dosage'],
      remindable: parsedJson['remindable'],
      usageType: parsedJson['usageType'],
      scheduledDate: parsedJson['scheduledDate'],
      createdDate: parsedJson['createdDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": notificationId,
      "name": name,
      "day": dayIndex,
      "time": time.toString(),
      "medicinePeriod": medicinePeriod.toString(),
      "dosage": dosage,
      "remindable": remindable.toString(),
      "usageType": usageType,
      "scheduledDate": scheduledDate,
      "createdDate": createdDate,
    };
  }

  MedicineForScheduledModel copyWith({
    int? notificationId,
    String? name,
    int? dayIndex,
    String? time,
    int? dosage,
    String? medicinePeriod,
    String? remindable,
    String? usageType,
    int? scheduledDate,
    int? createdDate,
  }) {
    return MedicineForScheduledModel(
      notificationId: notificationId ?? this.notificationId,
      name: name ?? this.name,
      dayIndex: dayIndex ?? this.dayIndex,
      time: time ?? this.time,
      dosage: dosage ?? this.dosage,
      medicinePeriod: medicinePeriod ?? this.medicinePeriod,
      remindable: remindable ?? this.remindable,
      usageType: usageType ?? this.usageType,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MedicineForScheduledModel &&
      other.notificationId == notificationId &&
      other.name == name &&
      other.dayIndex == dayIndex &&
      other.time == time &&
      other.dosage == dosage &&
      other.medicinePeriod == medicinePeriod &&
      other.remindable == remindable &&
      other.usageType == usageType &&
      other.scheduledDate == scheduledDate &&
      other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return notificationId.hashCode ^
      name.hashCode ^
      dayIndex.hashCode ^
      time.hashCode ^
      dosage.hashCode ^
      medicinePeriod.hashCode ^
      remindable.hashCode ^
      usageType.hashCode ^
      scheduledDate.hashCode ^
      createdDate.hashCode;
  }
}
