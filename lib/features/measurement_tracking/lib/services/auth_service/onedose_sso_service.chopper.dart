// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onedose_sso_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ODSsoService extends ODSsoService {
  _$ODSsoService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ODSsoService;

  @override
  Future<Response<dynamic>> login(
      {String clientId,
      String grantType,
      String clientSecret,
      String scope,
      String username,
      String password}) {
    final $url = '/auth/realms/GuvenComplex/protocol/openid-connect/token';
    final $body = <String, dynamic>{
      'client_id': clientId,
      'grant_type': grantType,
      'client_secret': clientSecret,
      'scope': scope,
      'username': username,
      'password': password
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
