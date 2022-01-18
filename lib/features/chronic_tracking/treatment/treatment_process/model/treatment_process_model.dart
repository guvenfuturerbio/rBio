part of '../view/treatment_process_screen.dart';

class TreatmentProcessItemModel {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;

  TreatmentProcessItemModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.dateTime,
  });
  toJson() {
    return TreatmentModel(treatment: description, createDate: dateTime, id: id)
        .toJson();
  }
}
