
import 'Speciality.dart';

class DoctorSpecialities {
  int specialityId;
  Speciality speciality;

  DoctorSpecialities({this.specialityId, this.speciality});

  DoctorSpecialities.fromJson(Map<String, dynamic> json) {
    specialityId = json['speciality_id'];
    speciality = json['speciality'] != null
        ? new Speciality.fromJson(json['speciality'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speciality_id'] = this.specialityId;
    if (this.speciality != null) {
      data['speciality'] = this.speciality.toJson();
    }
    return data;
  }
}