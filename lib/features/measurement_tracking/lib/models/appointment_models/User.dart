class User {
  int id;
  String name;
  String identificationNumber;

  User({this.id, this.name, this.identificationNumber});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    identificationNumber = json['identification_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['identification_number'] = this.identificationNumber;
    return data;
  }
}