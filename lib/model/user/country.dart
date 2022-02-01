class Country {
  String? name;
  String? phoneCode;
  String? abbreviation;
  int? id;

  Country({this.name, this.phoneCode, this.abbreviation, this.id});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    phoneCode = json['phone_code'] as String?;
    abbreviation = json['abbreviation'] as String?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_code'] = phoneCode;
    data['abbreviation'] = abbreviation;
    data['id'] = id;
    return data;
  }
}
