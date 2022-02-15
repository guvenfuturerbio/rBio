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
        id: json["id"],
        lastTestDate: json["last_test_date"],
        lastTestValue: json["last_test_value"],
        reminderDate: json["reminder_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_test_date": lastTestDate,
        "last_test_value": lastTestValue,
        "reminder_date": reminderDate,
      };
}
