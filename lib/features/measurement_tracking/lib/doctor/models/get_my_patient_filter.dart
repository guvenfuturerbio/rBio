import 'package:json_annotation/json_annotation.dart';

part 'get_my_patient_filter.g.dart';

@JsonSerializable()
class GetMyPatientFilter {
  @JsonKey(name: 'start')
  String start;
  @JsonKey(name: 'end')
  String end;
  @JsonKey(name: 'skip')
  String skip;
  @JsonKey(name: 'take')
  String take;

  GetMyPatientFilter({
    this.start,
    this.end,
    this.skip,
    this.take
  });

  factory GetMyPatientFilter.fromJson(Map<String, dynamic> json) => _$GetMyPatientFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GetMyPatientFilterToJson(this);
}


