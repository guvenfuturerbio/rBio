import 'package:json_annotation/json_annotation.dart';

import 'model/treatment_model/treatment_model.dart';

part 'yeni.g.dart';

@JsonSerializable()
class YeniModel {
  @JsonKey(name: "treatment_list")
  List<TreatmentModel>? treatmentList;
  
  YeniModel({
    this.treatmentList,
  });

  factory YeniModel.fromJson(Map<String, dynamic> json) => _$YeniModelFromJson(json);

  Map<String, dynamic> toJson() => _$YeniModelToJson(this);
}
