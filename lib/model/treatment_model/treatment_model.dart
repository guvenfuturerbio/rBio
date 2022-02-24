import 'package:json_annotation/json_annotation.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'treatment_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class TreatmentModel {
  @HiveField(0)
  @JsonKey(name: "treatment")
  String? treatment;

  @HiveField(1)
  @JsonKey(name: "create_date")
  DateTime? createDate;

  @HiveField(2)
  @JsonKey(name: "id")
  int? id;

  TreatmentModel({
    this.treatment,
    this.createDate,
    this.id,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) =>
      _$TreatmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$TreatmentModelToJson(this);
}
