import 'AppointmentType.dart';
import 'doctor.dart';

class Part {
  String startDateTime;
  String endDateTime;
  int interval;
  Doctor doctor;
  AppointmentType type;
  int id;

  Part(
      {this.startDateTime,
        this.endDateTime,
        this.interval,
        this.doctor,
        this.type,
        this.id});

  Part.fromJson(Map<String, dynamic> json) {
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    interval = json['interval'];
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    type = json['type'] != null
        ? new AppointmentType.fromJson(json['type'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date_time'] = this.startDateTime;
    data['end_date_time'] = this.endDateTime;
    data['interval'] = this.interval;
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}