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
}
