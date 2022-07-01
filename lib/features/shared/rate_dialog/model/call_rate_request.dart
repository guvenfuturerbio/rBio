class CallRateRequest {
  String? suggestionAndRequest;
  int? availabilityId;
  int? doctorRate;
  int? videoConferanceRate;

  CallRateRequest({
    this.suggestionAndRequest,
    this.availabilityId,
    this.doctorRate,
    this.videoConferanceRate,
  });

  CallRateRequest.fromJson(Map<String, dynamic> json) {
    suggestionAndRequest = json['suggestion_and_request'] as String?;
    availabilityId = json['availability_id'] as int?;
    doctorRate = json['doctor_rate'] as int?;
    videoConferanceRate = json['video_conferance_rate'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suggestion_and_request'] = suggestionAndRequest;
    data['availability_id'] = availabilityId;
    data['doctor_rate'] = doctorRate;
    data['video_conferance_rate'] = videoConferanceRate;
    return data;
  }
}
