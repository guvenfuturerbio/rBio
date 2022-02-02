class SymptomAuthResponse {
  String? token;
  int? validThrough;

  SymptomAuthResponse({this.token, this.validThrough});

  SymptomAuthResponse.fromJson(Map<String, dynamic> json) {
    token = json['Token'] as String?;
    validThrough = json['ValidThrough'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    data['ValidThrough'] = validThrough;
    return data;
  }
}
