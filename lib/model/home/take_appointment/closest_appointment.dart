class ClosestAppointment {
  int hospitalId;
  String date;

  ClosestAppointment({
    this.hospitalId,
    this.date,
  });

  ClosestAppointment.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospital_id'];
    if (json['date'] != null) {
      date = json['date'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_id'] = this.hospitalId;
    data['date'] = this.date;
    return data;
  }
}
