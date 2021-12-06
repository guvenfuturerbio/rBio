class MedicineForScheduledModel {
  int notificationId;
  String name;
  int dayIndex;
  String time;
  int dosage;
  String medicinePeriod;
  String remindable;
  String usageType;

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
        notificationId: parsedJson['id'],
        name: parsedJson['name'],
        dayIndex: parsedJson['day'],
        time: parsedJson['time'],
        medicinePeriod: parsedJson['medicinePeriod'],
        dosage: parsedJson['dosage'],
        remindable: parsedJson['remindable'],
        usageType: parsedJson['usageType']);
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
