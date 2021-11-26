class Country {
  String name;
  String phoneCode;
  String abbreviation;
  int id;

  Country({this.name, this.phoneCode, this.abbreviation, this.id});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneCode = json['phone_code'];
    abbreviation = json['abbreviation'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_code'] = this.phoneCode;
    data['abbreviation'] = this.abbreviation;
    data['id'] = this.id;
    return data;
  }
}