class AppointedDoctor {
  String primaryDoctorName;
  int primaryDoctorId;
  String lastDoctorNameOfPatientAppointment;
  int lastDoctorIdOfPatientAppointment;

  AppointedDoctor(
      {this.primaryDoctorName,
        this.primaryDoctorId,
        this.lastDoctorNameOfPatientAppointment,
        this.lastDoctorIdOfPatientAppointment});

  AppointedDoctor.fromJson(Map<String, dynamic> json) {
    primaryDoctorName = json['primary_doctor_name'];
    primaryDoctorId = json['primary_doctor_id'];
    lastDoctorNameOfPatientAppointment =
    json['last_doctor_name_of_patient_appointment'];
    lastDoctorIdOfPatientAppointment =
    json['last_doctor_id_of_patient_appointment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary_doctor_name'] = this.primaryDoctorName;
    data['primary_doctor_id'] = this.primaryDoctorId;
    data['last_doctor_name_of_patient_appointment'] =
        this.lastDoctorNameOfPatientAppointment;
    data['last_doctor_id_of_patient_appointment'] =
        this.lastDoctorIdOfPatientAppointment;
    return data;
  }
}