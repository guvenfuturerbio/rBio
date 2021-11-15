
import 'AppointmentType.dart';

class AppointmentTypeCategory {
  AppointmentType appointmentType;
  AppointmentType appointmentCategory;
  int id;

  AppointmentTypeCategory(
      {this.appointmentType, this.appointmentCategory, this.id});

  AppointmentTypeCategory.fromJson(Map<String, dynamic> json) {
    appointmentType = json['appointment_type'] != null
        ? new AppointmentType.fromJson(json['appointment_type'])
        : null;
    appointmentCategory = json['appointment_category'] != null
        ? new AppointmentType.fromJson(json['appointment_category'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointmentType != null) {
      data['appointment_type'] = this.appointmentType.toJson();
    }
    if (this.appointmentCategory != null) {
      data['appointment_category'] = this.appointmentCategory.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}
