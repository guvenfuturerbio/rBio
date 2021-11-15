import 'Part.dart';

class Appointment {
  Part part;
  String startTime;
  String endTime;
  bool isTaken;
  Null appointmentTypeCategoryId;
  Null availabilityCloseTypeId;
  bool timeOut;
  bool canDelete;
  String dateTime;
  Null patient;
  int id;

  Appointment(
      {this.part,
        this.startTime,
        this.endTime,
        this.isTaken,
        this.appointmentTypeCategoryId,
        this.availabilityCloseTypeId,
        this.timeOut,
        this.canDelete,
        this.dateTime,
        this.patient,
        this.id});

  Appointment.fromJson(Map<String, dynamic> json) {
    part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    startTime = json['start_time'];
    endTime = json['end_time'];
    isTaken = json['is_taken'];
    appointmentTypeCategoryId = json['appointment_type_category_id'];
    availabilityCloseTypeId = json['availability_close_type_id'];
    timeOut = json['time_out'];
    canDelete = json['can_delete'];
    dateTime = json['date_time'];
    patient = json['patient'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.part != null) {
      data['part'] = this.part.toJson();
    }
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['is_taken'] = this.isTaken;
    data['appointment_type_category_id'] = this.appointmentTypeCategoryId;
    data['availability_close_type_id'] = this.availabilityCloseTypeId;
    data['time_out'] = this.timeOut;
    data['can_delete'] = this.canDelete;
    data['date_time'] = this.dateTime;
    data['patient'] = this.patient;
    data['id'] = this.id;
    return data;
  }
}