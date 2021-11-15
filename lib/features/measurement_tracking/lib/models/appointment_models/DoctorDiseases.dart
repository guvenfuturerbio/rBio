
import 'Disease.dart';

class DoctorDiseases {
  Disease disease;
  int id;

  DoctorDiseases({this.disease, this.id});

  DoctorDiseases.fromJson(Map<String, dynamic> json) {
    disease =
    json['disease'] != null ? new Disease.fromJson(json['disease']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.disease != null) {
      data['disease'] = this.disease.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}