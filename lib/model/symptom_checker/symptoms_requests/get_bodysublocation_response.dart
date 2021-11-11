class GetBodySublocationResponse {
  int id;
  String name;

  GetBodySublocationResponse({this.id, this.name});

  GetBodySublocationResponse.fromJson(Map<String, dynamic> json) {
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
