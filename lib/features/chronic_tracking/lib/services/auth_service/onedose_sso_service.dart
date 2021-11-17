import 'package:chopper/chopper.dart';

import '../../helper/build_configurations.dart';

part 'onedose_sso_service.chopper.dart';

@ChopperApi()
abstract class ODSsoService extends ChopperService {
  static ODSsoService create() {
    final client = ChopperClient(
        baseUrl: BuildConfigurations.SSO_URL,
        services: [_$ODSsoService()],
        interceptors: [HttpLoggingInterceptor()],
        converter: FormUrlEncodedConverter());
    return _$ODSsoService(client);
  }

  @Post(path: "/auth/realms/GuvenComplex/protocol/openid-connect/token")
  Future<Response> login(
      {@Field("client_id") String clientId,
      @Field("grant_type") String grantType,
      @Field("client_secret") String clientSecret,
      @Field("scope") String scope,
      @Field("username") String username,
      @Field("password") String password});
}
