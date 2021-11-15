import 'AppointmentType.dart';
import 'User.dart';

class Patient {
  User user;
  String registerNo;
  bool selfRegistered;
  int patientTypeId;
  int userId;
  int genderId;
  AppointmentType gender;
  AppointmentType patientType;
  int id;

  Patient(
      {this.user,
        this.registerNo,
        this.selfRegistered,
        this.patientTypeId,
        this.userId,
        this.genderId,
        this.gender,
        this.patientType,
        this.id});

  Patient.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    registerNo = json['register_no'];
    selfRegistered = json['self_registered'];
    patientTypeId = json['patient_type_id'];
    userId = json['user_id'];
    genderId = json['gender_id'];
    gender = json['gender'] != null
        ? new AppointmentType.fromJson(json['gender'])
        : null;
    patientType = json['patient_type'] != null
        ? new AppointmentType.fromJson(json['patient_type'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['register_no'] = this.registerNo;
    data['self_registered'] = this.selfRegistered;
    data['patient_type_id'] = this.patientTypeId;
    data['user_id'] = this.userId;
    data['gender_id'] = this.genderId;
    if (this.gender != null) {
      data['gender'] = this.gender.toJson();
    }
    if (this.patientType != null) {
      data['patient_type'] = this.patientType.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}