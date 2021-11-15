import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../helper/build_configurations.dart';
import '../helper/jwt_token_parser.dart';
import '../models/add_firebase_body.dart';
import '../models/login_response.dart';
import '../notifiers/user_notifiers.dart';
import 'api_service.dart';
import 'sso_service.dart';

class UserService {
  // ignore: non_constant_identifier_names
  static String INVALID_AUTHORIZATION = "invalid_authorization";
  Future<LoginResponse> login(String userId, String password) async {
    final response = await SsoService.create().login(
        clientId: BuildConfigurations.DOCTOR_CLIENT_ID,
        grantType: "password",
        clientSecret: BuildConfigurations.DOCTOR_CLIENT_SECRET,
        scope: "openid",
        username: userId,
        password: password);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      final LoginResponse _login = LoginResponse.fromJson(responseBody);
      print(parseJwtPayLoad(_login.accessToken)["realm_access"]["roles"]
          .toString());
      if (parseJwtPayLoad(_login.accessToken)["realm_access"]["roles"]
              .toString()
              .contains("ADMain") ||
          parseJwtPayLoad(_login.accessToken)["realm_access"]["roles"]
              .toString()
              .contains("MDMain")) {
        return _login;
      } else {
        throw Exception(INVALID_AUTHORIZATION);
      }
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw Exception(HttpStatus.unauthorized);
    } else {
      throw Exception(response.statusCode);
    }
  }

  addFirebaseToken() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: UserNotifiers.JWT_TOKEN);
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    var tok = await FirebaseMessaging.instance.getAPNSToken();
    print(tok);
    _firebaseMessaging.getToken().then((token) async {
      final response = await BaseProvider.create(jwtToken).addFirebaseToken(
          AddFirebaseToken(
              firebaseId: token, phoneInfo: await getDeviceInformation()));
      print(response.statusCode);
    });
  }

  Future<String> getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.toJsonString();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.toJsonString();
    } else {
      throw Exception('getDEviceInformation');
    }
  }
}

extension on AndroidDeviceInfo {
  String toJsonString() {
    Map<String, dynamic> jsonMap = new Map();
    jsonMap.addAll({
      "android_id": androidId,
      "is_physical_device": isPhysicalDevice,
      "product": product,
      "model": model,
      "id": id,
      "host": host,
      "hardware": hardware,
      "fingerprint": fingerprint,
      "display": display,
      "device": device,
      "brand": brand,
      "bootloader": bootloader,
      "board": board,
      "base_os": version.baseOS,
      "release": version.release,
      "sdk_int": version.sdkInt
    });

    return jsonEncode(jsonMap);
  }
}

extension on IosDeviceInfo {
  String toJsonString() {
    Map<String, dynamic> jsonMap = new Map();
    jsonMap.addAll({
      "name": name,
      "systemName": systemName,
      "systemVersion": systemVersion,
      "model": model,
      "localizedModel": localizedModel,
      "identifierForVendor": identifierForVendor,
      "isPhysicalDevice": isPhysicalDevice,
      "sysname": utsname.sysname,
      "nodename": utsname.nodename,
      "release": utsname.release,
      "version": utsname.version,
      "machine": utsname.machine
    });

    return jsonEncode(jsonMap);
  }
}
