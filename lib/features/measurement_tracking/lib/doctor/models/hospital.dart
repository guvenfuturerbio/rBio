class Hospital {
  String name;
  int provinceId;
  int id;

  Hospital({this.name, this.provinceId, this.id});

  Hospital.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    provinceId = json['province_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['province_id'] = this.provinceId;
    data['id'] = this.id;
    return data;
  }
}