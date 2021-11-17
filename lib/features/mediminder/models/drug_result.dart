import 'package:json_annotation/json_annotation.dart';
part 'drug_result.g.dart';


@JsonSerializable()
class DrugResult {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'id')
  int id;

  DrugResult({this.name, this.id});

  factory DrugResult.fromJson(Map<String, dynamic> json) => _$DrugResultFromJson(json);

  Map<String, dynamic> toJson() => _$DrugResultToJson(this);
}