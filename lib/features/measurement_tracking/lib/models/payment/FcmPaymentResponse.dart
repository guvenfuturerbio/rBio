class FcmPaymentResponse {
  String code;
  String videoId;
  String errorText;

  FcmPaymentResponse({this.code, this.videoId, this.errorText});

  FcmPaymentResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    videoId = json['video_id'];
    errorText = json['error_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['video_id'] = this.videoId;
    data['error_text'] = this.errorText;
    return data;
  }
}