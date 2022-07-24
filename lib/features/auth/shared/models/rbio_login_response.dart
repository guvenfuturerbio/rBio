import 'package:json_annotation/json_annotation.dart';

import '../../../../core/core.dart';

part 'rbio_login_response.g.dart';

@JsonSerializable()
class RbioLoginResponse extends IBaseModel<RbioLoginResponse> {
  @JsonKey(name: "sso_response")
  SsoResponse? ssoResponse;

  @JsonKey(name: "roles")
  List<String>? roles;

  @JsonKey(name: "firebase_user_email")
  String? firebaseUserEmail;

  @JsonKey(name: "firebase_user_salt")
  String? firebaseUserSalt;

  RbioLoginResponse({
    this.ssoResponse,
    this.roles,
    this.firebaseUserEmail,
    this.firebaseUserSalt,
  });

  @override
  Map<String, dynamic> toJson() => _$RbioLoginResponseToJson(this);

  @override
  RbioLoginResponse fromJson(Map<String, dynamic> json) =>
      RbioLoginResponse.fromJson(json);

  factory RbioLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$RbioLoginResponseFromJson(json);
}

@JsonSerializable()
class SsoResponse {
  @JsonKey(name: "access_token")
  String? accessToken;

  @JsonKey(name: "error")
  String? error;

  @JsonKey(name: "error_description")
  String? errorDescription;

  @JsonKey(name: "http_status_code")
  int? httpStatusCode;

  SsoResponse({
    this.accessToken,
    this.error,
    this.errorDescription,
    this.httpStatusCode,
  });

  factory SsoResponse.fromJson(Map<String, dynamic> json) =>
      _$SsoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SsoResponseToJson(this);
}
