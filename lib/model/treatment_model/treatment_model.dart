import 'package:hive_flutter/hive_flutter.dart';

part 'treatment_model.g.dart';

@HiveType(typeId: 4)
class TreatmentModel {
/*
{
  "treatment": "testAdd",
  "create_date": "2022-01-13T10:23:47.652422+03:00",
  "id": 8
} 
*/
  @HiveField(0)
  String? treatment;
  @HiveField(1)
  DateTime? createDate;
  @HiveField(2)
  int? id;

  TreatmentModel({
    this.treatment,
    this.createDate,
    this.id,
  });
  TreatmentModel.fromJson(Map<String, dynamic> json) {
    treatment = json['treatment']?.toString();
    createDate = json['create_date'] != null
        ? DateTime.parse(json['create_date'] as String) as DateTime?
        : DateTime.now();
    id = json['id']?.toInt() as int?;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['treatment'] = treatment;
    data['create_date'] = createDate?.toIso8601String();
    data['id'] = id;
    return data;
  }
}
