class GetAvailabilityRateResponse {
  int? userId;
  int? appointmentId;
  int? doctorRate;
  int? videoConferanceRate;
  String? suggestion;
  int? id;
  String? createdDate;
  String? updatedDate;
  bool? isDeleted;
  bool? discardId;

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
    userId = json['user_id'] as int?;
    appointmentId = json['appointment_id'] as int?;
    doctorRate = json['doctor_rate'] as int?;
    videoConferanceRate = json['video_conferance_rate'] as int?;
    suggestion = json['suggestion'] as String?;
    id = json['id'] as int?;
    createdDate = json['created_date'] as String?;
    updatedDate = json['updated_date'] as String?;
    isDeleted = json['is_deleted'] as bool?;
    discardId = json['discard_id'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['appointment_id'] = appointmentId;
    data['doctor_rate'] = doctorRate;
    data['video_conferance_rate'] = videoConferanceRate;
    data['suggestion'] = suggestion;
    data['id'] = id;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['is_deleted'] = isDeleted;
    data['discard_id'] = discardId;
    return data;
  }
}
