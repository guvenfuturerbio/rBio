import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core.dart';

class SecretHelper {
  SecretHelper._();

  static SecretHelper? _instance;

  static SecretHelper get instance {
    _instance ??= SecretHelper._();
    return _instance!;
  }

  // ************************** **************************

  final _map = <SecretKeys, String>{};

  String get(SecretKeys key) {
    final value = _map[key];
    if (value == null) {
      throw Exception("$key valu null");
    }

    return value;
  }

  Future<void> setup(
    Environment env, {
    Map<SecretKeys, String> remote = const {},
  }) async {
    await dotenv.load(fileName: env.xFileName);
    final local =
        dotenv.env.map((key, value) => MapEntry(_fromString(key), value));
    _map.addAll({...local, ...remote});
  }

  SecretKeys _fromString(s) =>
      SecretKeys.values.firstWhere((v) => getEnumValue(v) == s);
}
