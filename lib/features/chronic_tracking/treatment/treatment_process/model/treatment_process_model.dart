part of '../view/treatment_process_screen.dart';

class TreatmentProcessItemModel {
  final int? id;
  final String? title;
  final String? description;
  final DateTime? dateTime;

  TreatmentProcessItemModel({
     this.id,
     this.title,
     this.description,
     this.dateTime,
  });
  Map<String, dynamic> toJson() {
    return TreatmentModel(treatment: description, createDate: dateTime, id: id)
        .toJson();
  }
}
