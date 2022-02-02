import 'package:json_annotation/json_annotation.dart';
part 'blood_glucose_value_detail_model.g.dart';

@JsonSerializable()
class BloodGlucoseValueDetail {
  @JsonKey(name: 'occurrence_time')
  String? time;
  @JsonKey(name: 'sugar_measure_tag_id')
  int? tag;


  BloodGlucoseValueDetail(
      {this.time, this.tag,});

  factory BloodGlucoseValueDetail.fromJson(Map<String, dynamic> json) => _$BloodGlucoseValueDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BloodGlucoseValueDetailToJson(this);
}
