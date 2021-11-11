class SymptomAuthResponse {
  String token;
  int validThrough;

  SymptomAuthResponse({this.token, this.validThrough});

  SymptomAuthResponse.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    validThrough = json['ValidThrough'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['ValidThrough'] = this.validThrough;
    return data;
  }
}