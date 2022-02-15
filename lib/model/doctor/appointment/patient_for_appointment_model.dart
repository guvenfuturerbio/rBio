import 'user_for_appointment_model.dart';

class PatientForAppointmentModel {
  UserForAppointmentModel? user;
  int? id;

  PatientForAppointmentModel({
    this.user,
    this.id,
  });

  PatientForAppointmentModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null
        ? UserForAppointmentModel.fromJson(json['user'] as Map<String, dynamic>)
        : null;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['id'] = id;
    return data;
  }
}
