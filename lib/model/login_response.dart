class LoginResponse {
  String? accessToken;
  int? expiresIn;
  int? refreshExpiresIn;
  String? refreshToken;
  String? tokenType;
  String? idToken;
  int? notBeforePolicy;
  String? sessionState;
  String? scope;

  LoginResponse({
    this.accessToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
    this.tokenType,
    this.idToken,
    this.notBeforePolicy,
    this.sessionState,
    this.scope,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'] as String?;
    expiresIn = json['expires_in'] as int?;
    refreshExpiresIn = json['refresh_expires_in'] as int?;
    refreshToken = json['refresh_token'] as String?;
    tokenType = json['token_type'] as String?;
    idToken = json['id_token'] as String?;
    notBeforePolicy = json['not-before-policy'] as int?;
    sessionState = json['session_state'] as String?;
    scope = json['scope'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['refresh_expires_in'] = refreshExpiresIn;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['id_token'] = idToken;
    data['not-before-policy'] = notBeforePolicy;
    data['session_state'] = sessionState;
    data['scope'] = scope;
    return data;
  }
}
