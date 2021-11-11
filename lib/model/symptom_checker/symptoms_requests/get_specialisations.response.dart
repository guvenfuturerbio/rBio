class GetSpecialisationsResponse {
  int id;
  String name;
  dynamic accuracy;
  int ranking;

  GetSpecialisationsResponse({this.id, this.name, this.accuracy, this.ranking});

  GetSpecialisationsResponse.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
    accuracy = json['Accuracy'];
    ranking = json['Ranking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['Name'] = this.name;
    data['Accuracy'] = this.accuracy;
    data['Ranking'] = this.ranking;
    return data;
  }
}
