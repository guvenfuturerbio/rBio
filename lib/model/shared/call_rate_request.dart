class CallRateRequest {
  String suggestionAndRequest;
  int availabilityId;
  int doctorRate;
  int videoConferanceRate;

  CallRateRequest({
    this.suggestionAndRequest,
    this.availabilityId,
    this.doctorRate,
    this.videoConferanceRate,
  });

  CallRateRequest.fromJson(Map<String, dynamic> json) {
    suggestionAndRequest = json['suggestion_and_request'];
    availabilityId = json['availability_id'];
    doctorRate = json['doctor_rate'];
    videoConferanceRate = json['video_conferance_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suggestion_and_request'] = this.suggestionAndRequest;
    data['availability_id'] = this.availabilityId;
    data['doctor_rate'] = this.doctorRate;
    data['video_conferance_rate'] = this.videoConferanceRate;
    return data;
  }
}
