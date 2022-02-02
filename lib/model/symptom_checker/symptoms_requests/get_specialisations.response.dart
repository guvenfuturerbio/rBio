class GetSpecialisationsResponse {
  int? id;
  String? name;
  dynamic accuracy;
  int? ranking;

  GetSpecialisationsResponse({this.id, this.name, this.accuracy, this.ranking});

  GetSpecialisationsResponse.fromJson(Map<String, dynamic> json) {
    id = json['ID'] as int?;
    name = json['Name'] as String?;
    accuracy = json['Accuracy'] as dynamic;
    ranking = json['Ranking'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Name'] = name;
    data['Accuracy'] = accuracy;
    data['Ranking'] = ranking;
    return data;
  }
}
