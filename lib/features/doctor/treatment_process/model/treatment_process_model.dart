part of '../view/treatment_process_screen.dart';

class TreatmentProcessItemModel {
  int? id;
  String? title;
  String? description;
  DateTime? dateTime;

  TreatmentProcessItemModel({
    this.id,
    this.title,
    this.description,
    this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return TreatmentModel(
      treatment: description,
      createDate: dateTime?.toIso8601String(),
      id: id,
    ).toJson();
  }
}
