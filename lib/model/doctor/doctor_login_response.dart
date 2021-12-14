class DoctorLoginResponse {
  String accessToken;
  int expiresIn;
  int refreshExpiresIn;
  String refreshToken;
  String tokenType;
  String sessionState;
  String scope;

  DoctorLoginResponse({
    this.accessToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
    this.tokenType,
    this.sessionState,
    this.scope,
  });

  DoctorLoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshExpiresIn = json['refresh_expires_in'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    sessionState = json['session_state'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'access_token': this.accessToken,
        'expires_in': this.expiresIn,
        'refresh_expires_in': this.refreshExpiresIn,
        'refresh_token': this.refreshToken,
        'token_type': this.tokenType,
        'session_state': this.sessionState,
        'scope': this.scope,
      };
}
