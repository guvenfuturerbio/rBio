class HospitalModel {
  String name;
  int provinceId;
  int id;

  HospitalModel({
    this.name,
    this.provinceId,
    this.id,
  });

  HospitalModel.fromJson(Map<String, dynamic> json) {
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
