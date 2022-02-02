class RbioLoginResponse {
  RbioLoginResponse({
    this.token,
    this.roles,
    this.firebase_user_email,
    this.firebase_user_salt,
  });

  String? firebase_user_email;
  String? firebase_user_salt;
  Token? token;
  List<String>? roles;

  factory RbioLoginResponse.fromJson(Map<String, dynamic> json) =>
      RbioLoginResponse(
        token: Token.fromJson(json["token"] as Map<String, dynamic>),
        roles: List<String>.from(json["roles"].map((x) => x) as List<String>),
        firebase_user_email: json['firebase_user_email'] as String?,
        firebase_user_salt: json['firebase_user_salt'] as String?,
      );

  Map<String, dynamic> toJson() => {
        "token": token?.toJson(),
        "roles": List<dynamic>.from(roles!.map((x) => x)),
      };
}

class Token {
  String? accessToken;
  int? expiresIn;
  int? refreshExpiresIn;
  String? refreshToken;
  String? tokenType;
  String? sessionState;
  String? scope;

  Token({
    this.accessToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
    this.tokenType,
    this.sessionState,
    this.scope,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"] as String?,
        expiresIn: json["expires_in"] as int?,
        refreshExpiresIn: json["refresh_expires_in"] as int?,
        refreshToken: json["refresh_token"] as String?,
        tokenType: json["token_type"] as String?,
        sessionState: json["session_state"] as String?,
        scope: json["scope"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "refresh_expires_in": refreshExpiresIn,
        "refresh_token": refreshToken,
        "token_type": tokenType,
        "session_state": sessionState,
        "scope": scope,
      };
}
