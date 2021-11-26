import 'package:json_annotation/json_annotation.dart';

part 'get_blood_glucose_data_of_person.g.dart';

@JsonSerializable()
class GetBloodGlucoseDataOfPerson {
  @JsonKey(name: 'entegration_id')
  int id;
  @JsonKey(name: 'start')
  String start;
  @JsonKey(name: 'end')
  String end;

  GetBloodGlucoseDataOfPerson({this.id, this.start, this.end});

  factory GetBloodGlucoseDataOfPerson.fromJson(Map<String, dynamic> json) =>
      _$GetBloodGlucoseDataOfPersonFromJson(json);

  Map<String, dynamic> toJson() => _$GetBloodGlucoseDataOfPersonToJson(this);
}
