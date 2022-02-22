class HospitalModel {
  String? name;
  int? provinceId;
  int? id;

  HospitalModel({
    this.name,
    this.provinceId,
    this.id,
  });

  HospitalModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    provinceId = json['province_id'] as int?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['province_id'] = provinceId;
    data['id'] = id;
    return data;
  }
}
