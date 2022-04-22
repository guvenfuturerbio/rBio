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
    return TreatmentModel(
      treatment: description,
      createDate: dateTime,
      id: id,
    ).toJson();
  }

  factory TreatmentProcessItemModel.fromJson(Map<String, dynamic> json) {
    return TreatmentProcessItemModel(
      id: json['id'],
      description: json['treatment'],
      dateTime: json['create_date'],
    );
  }
}
