class GetBodySymptomsResponse {
  int id;
  String name;
  bool hasRedFlag;
  List<int> healthSymptomLocationIDs;
  String profName;
  List<String> synonyms;

  GetBodySymptomsResponse(
      {this.id,
      this.name,
      this.hasRedFlag,
      this.healthSymptomLocationIDs,
      this.profName,
      this.synonyms});

  GetBodySymptomsResponse.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
    hasRedFlag = json['HasRedFlag'];
    healthSymptomLocationIDs = json['HealthSymptomLocationIDs'] != null
        ? json['HealthSymptomLocationIDs'].cast<int>()
        : null;
    profName = json['ProfName'];
    synonyms =
        json['Synonyms'] != null ? json['Synonyms'].cast<String>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['Name'] = this.name;
    data['HasRedFlag'] = this.hasRedFlag;
    data['HealthSymptomLocationIDs'] = this.healthSymptomLocationIDs;
    data['ProfName'] = this.profName;
    data['Synonyms'] = this.synonyms;
    return data;
  }
}
