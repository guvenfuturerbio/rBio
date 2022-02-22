import 'package:json_annotation/json_annotation.dart';

import '../../core/core.dart';

part 'rbio_login_response.g.dart';

@JsonSerializable()
class RbioLoginResponse extends IBaseModel<RbioLoginResponse> {
  @JsonKey(name: 'firebase_user_email')
  String? firebaseUserEmail;

  @JsonKey(name: 'firebase_user_salt')
  String? firebaseUserSalt;

  @JsonKey(name: 'token')
  Token? token;

  @JsonKey(name: 'roles')
  List<String>? roles;

  RbioLoginResponse({
    this.token,
    this.roles,
    this.firebaseUserEmail,
    this.firebaseUserSalt,
  });

  factory RbioLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$RbioLoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RbioLoginResponseToJson(this);

  @override
  RbioLoginResponse fromJson(Map<String, dynamic> json) {
    return RbioLoginResponse.fromJson(json);
  }
}

@JsonSerializable()
class Token extends IBaseModel<Token> {
  @JsonKey(name: 'access_token')
  String? accessToken;

  @JsonKey(name: 'expires_in')
  int? expiresIn;

  @JsonKey(name: 'refresh_expires_in')
  int? refreshExpiresIn;

  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  @JsonKey(name: 'token_type')
  String? tokenType;

  @JsonKey(name: 'session_state')
  String? sessionState;

  @JsonKey(name: 'scope')
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

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  Token fromJson(Map<String, dynamic> json) {
    return Token.fromJson(json);
  }
}
