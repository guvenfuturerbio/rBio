class ClosestAppointment {
  int? hospitalId;
  String? date;

  ClosestAppointment({
    this.hospitalId,
    this.date,
  });

  ClosestAppointment.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospital_id'] as int?;
    if (json['date'] != null) {
      date = json['date'] as String?;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hospital_id'] = hospitalId;
    data['date'] = date;
    return data;
  }
}
