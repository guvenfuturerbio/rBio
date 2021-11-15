import 'package:chopper/chopper.dart';

import '../../helper/build_configurations.dart';
import 'network_connection_checker.dart';

part 'sso_service.chopper.dart';

@ChopperApi()
abstract class SsoService extends ChopperService {
  static SsoService create() {
    final client = ChopperClient(
        baseUrl: BuildConfigurations.DOCTOR_SSO_URL,
        services: [_$SsoService()],
        interceptors: [
          HttpLoggingInterceptor(),
          NetworkConnectionChecker(),
        ],
        converter: FormUrlEncodedConverter());
    return _$SsoService(client);
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
