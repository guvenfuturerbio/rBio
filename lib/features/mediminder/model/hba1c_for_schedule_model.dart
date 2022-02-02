class Hba1CForScheduleModel {
  int? id;
  String? lastTestDate;
  String? lastTestValue;
  String? reminderDate;

  Hba1CForScheduleModel({
    this.id,
    this.lastTestDate,
    this.lastTestValue,
    this.reminderDate,
  });

  factory Hba1CForScheduleModel.fromJson(Map<String, dynamic> json) =>
      Hba1CForScheduleModel(
        id: json["id"] as int,
        lastTestDate: json["last_test_date"] as String?,
        lastTestValue: json["last_test_value"] as String?,
        reminderDate: json["reminder_date"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_test_date": lastTestDate,
        "last_test_value": lastTestValue,
        "reminder_date": reminderDate,
      };
}
