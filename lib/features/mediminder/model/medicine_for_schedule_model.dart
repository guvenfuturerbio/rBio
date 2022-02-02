class MedicineForScheduledModel {
  int? notificationId;
  String? name;
  int? dayIndex;
  String? time;
  int? dosage;
  String? medicinePeriod;
  String? remindable;
  String? usageType;

  MedicineForScheduledModel({
    this.notificationId,
    this.name,
    this.dayIndex,
    this.time,
    this.medicinePeriod,
    this.dosage,
    this.remindable,
    this.usageType,
  });

  factory MedicineForScheduledModel.fromJson(Map<String, dynamic> parsedJson) {
    return MedicineForScheduledModel(
        notificationId: parsedJson['id'] as int?,
        name: parsedJson['name'] as String?,
        dayIndex: parsedJson['day'] as int?,
        time: parsedJson['time'] as String?,
        medicinePeriod: parsedJson['medicinePeriod'] as String?,
        dosage: parsedJson['dosage'] as int?,
        remindable: parsedJson['remindable'] as String?,
        usageType: parsedJson['usageType'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.notificationId,
      "name": this.name,
      "day": this.dayIndex,
      "time": this.time.toString(),
      "medicinePeriod": this.medicinePeriod.toString(),
      "dosage": this.dosage,
      "remindable": this.remindable.toString(),
      "usageType": this.usageType
    };
  }
}
