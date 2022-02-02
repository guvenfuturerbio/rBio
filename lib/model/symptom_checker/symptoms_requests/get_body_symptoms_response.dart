class GetBodySymptomsResponse {
  int? id;
  String? name;
  bool? hasRedFlag;
  List<int>? healthSymptomLocationIDs;
  String? profName;
  List<String>? synonyms;

  GetBodySymptomsResponse({
    this.id,
    this.name,
    this.hasRedFlag,
    this.healthSymptomLocationIDs,
    this.profName,
    this.synonyms,
  });

  GetBodySymptomsResponse.fromJson(Map<String, dynamic> json) {
    id = json['ID'] as int?;
    name = json['Name'] as String?;
    hasRedFlag = json['HasRedFlag'] as bool?;
    healthSymptomLocationIDs =
        json['HealthSymptomLocationIDs'].cast<int>() as List<int>?;
    profName = json['ProfName'] as String?;
    synonyms = json['Synonyms'].cast<String>() as List<String>?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Name'] = name;
    data['HasRedFlag'] = hasRedFlag;
    data['HealthSymptomLocationIDs'] = healthSymptomLocationIDs;
    data['ProfName'] = profName;
    data['Synonyms'] = synonyms;
    return data;
  }
}
