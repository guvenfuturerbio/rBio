class Disease {
  String name;
  String shortName;
  int id;

  Disease({this.name, this.shortName, this.id});

  Disease.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortName = json['short_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['id'] = this.id;
    return data;
  }
}