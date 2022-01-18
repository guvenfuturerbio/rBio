///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class TreatmentModel {
/*
{
  "treatment": "testAdd",
  "create_date": "2022-01-13T10:23:47.652422+03:00",
  "id": 8
} 
*/

  String treatment;
  DateTime createDate;
  int id;

  TreatmentModel({
    this.treatment,
    this.createDate,
    this.id,
  });
  TreatmentModel.fromJson(Map<String, dynamic> json) {
    treatment = json['treatment']?.toString();
    createDate = json['create_date'] != null
        ? DateTime.parse(json['create_date'])
        : DateTime.now();
    id = json['id']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['treatment'] = treatment;
    data['create_date'] = createDate.toIso8601String();
    data['id'] = id;
    return data;
  }
}
