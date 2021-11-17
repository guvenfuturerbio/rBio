import "dart:async";

import 'package:chopper/chopper.dart';

import '../../helper/build_configurations.dart';
import '../../helper/strings.dart';
import '../../services/network_connection_service.dart';

// Aşağıdaki dosyanın oluşması ve güncel kalması için şu komutu Terminalden çalıştır:
// flutter packages pub run build_runner watch
part 'login_provider.chopper.dart';

@ChopperApi()
abstract class LoginProvider extends ChopperService {
  static LoginProvider create() {
    final client = ChopperClient(
        baseUrl: BuildConfigurations.SSO_URL,
        services: [_$LoginProvider()],
        interceptors: [HttpLoggingInterceptor(), NetworkConnectionChecker()],
        converter: FormUrlEncodedConverter());
    return _$LoginProvider(client);
  }

  @Post(path: Strings.loginPath)
  Future<Response> loginUi(
      @Field("client_id") String clientId,
      @Field("grant_type") String grantType,
      @Field("client_secret") String clientSecret,
      @Field("scope") String scope,
      @Field("username") String username,
      @Field("password") String password);
}
