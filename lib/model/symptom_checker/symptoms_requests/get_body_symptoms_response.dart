import 'package:json_annotation/json_annotation.dart';

part 'get_body_symptoms_response.g.dart';

@JsonSerializable()
class GetBodySymptomsResponse {
  @JsonKey(name: "ID")
  int? id;

  @JsonKey(name: "Name")
  String? name;

  @JsonKey(name: "HasRedFlag")
  bool? hasRedFlag;

  @JsonKey(name: "HealthSymptomLocationIDs")
  List<int>? healthSymptomLocationIDs;

  @JsonKey(name: "ProfName")
  String? profName;

  @JsonKey(name: "Synonyms")
  List<String>? synonyms;

  GetBodySymptomsResponse({
    this.id,
    this.name,
    this.hasRedFlag,
    this.healthSymptomLocationIDs,
    this.profName,
    this.synonyms,
  });

  factory GetBodySymptomsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBodySymptomsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBodySymptomsResponseToJson(this);
}
