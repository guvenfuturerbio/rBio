class GetSymptomsResponse {
  int id;
  String name;

  GetSymptomsResponse({this.id, this.name});

  GetSymptomsResponse.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['Name'] = this.name;
    return data;
  }
}
