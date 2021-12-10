import 'user_for_appointment_model.dart';

class PatientForAppointmentModel {
  UserForAppointmentModel user;
  int id;

  PatientForAppointmentModel({
    this.user,
    this.id,
  });

  PatientForAppointmentModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null
        ? new UserForAppointmentModel.fromJson(json['user'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}
