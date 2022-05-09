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
  toJson() {
    return TreatmentModel(
      treatment: description,
      createDate: dateTime,
      id: id,
    ).toJson();
  }
}
