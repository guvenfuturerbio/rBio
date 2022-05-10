class UserLoginStarterResponse {
  bool? isTwoFa;
  bool? isSsoValid;
  int? userId;
  int? httpStatusCode;

  UserLoginStarterResponse({
    this.isTwoFa,
    this.isSsoValid,
    this.userId,
    this.httpStatusCode,
  });

  UserLoginStarterResponse.fromJson(Map<String, dynamic> json) {
    isTwoFa = json['is_two_fa'];
    isSsoValid = json['is_sso_valid'];
    userId = json['user_id'];
    httpStatusCode = json['http_status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_two_fa'] = isTwoFa;
    data['is_sso_valid'] = isSsoValid;
    data['user_id'] = userId;
    data['http_status_code'] = httpStatusCode;
    return data;
  }
}
