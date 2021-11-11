class GetBodyLocationResponse {
  int id;
  String name;

  GetBodyLocationResponse({this.id, this.name});

  GetBodyLocationResponse.fromJson(Map<String, dynamic> json) {
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
