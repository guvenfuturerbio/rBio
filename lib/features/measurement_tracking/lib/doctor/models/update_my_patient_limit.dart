import 'package:json_annotation/json_annotation.dart';

part 'update_my_patient_limit.g.dart';

@JsonSerializable()
class UpdateMyPatientLimit {
  @JsonKey(name: 'range_min')
  int rangeMin;
  @JsonKey(name: 'range_max')
  int rangeMax;
  @JsonKey(name: 'hyper')
  int hyper;
  @JsonKey(name: 'hypo')
  int hypo;

  UpdateMyPatientLimit({
    this.rangeMin,
    this.rangeMax,
    this.hyper,
    this.hypo
  });

  factory UpdateMyPatientLimit.fromJson(Map<String, dynamic> json) => _$UpdateMyPatientLimitFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMyPatientLimitToJson(this);
}


