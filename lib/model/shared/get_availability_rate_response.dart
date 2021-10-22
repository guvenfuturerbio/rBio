class GetAvailabilityRateResponse {
  int userId;
  int appointmentId;
  int doctorRate;
  int videoConferanceRate;
  String suggestion;
  int id;
  String createdDate;
  String updatedDate;
  bool isDeleted;
  bool discardId;

  GetAvailabilityRateResponse({
    this.userId,
    this.appointmentId,
    this.doctorRate,
    this.videoConferanceRate,
    this.suggestion,
    this.id,
    this.createdDate,
    this.updatedDate,
    this.isDeleted,
    this.discardId,
  });

  GetAvailabilityRateResponse.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    appointmentId = json['appointment_id'];
    doctorRate = json['doctor_rate'];
    videoConferanceRate = json['video_conferance_rate'];
    suggestion = json['suggestion'];
    id = json['id'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    isDeleted = json['is_deleted'];
    discardId = json['discard_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['appointment_id'] = this.appointmentId;
    data['doctor_rate'] = this.doctorRate;
    data['video_conferance_rate'] = this.videoConferanceRate;
    data['suggestion'] = this.suggestion;
    data['id'] = this.id;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['is_deleted'] = this.isDeleted;
    data['discard_id'] = this.discardId;
    return data;
  }
}
