import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core.dart';
import '../enums/environment.dart';
import '../enums/secret_keys.dart';

class SecretUtils {
  SecretUtils._();

  static SecretUtils _instance;

  static SecretUtils get instance {
    _instance ??= SecretUtils._();
    return _instance;
  }

  // ************************** **************************

  final _map = <SecretKeys, String>{};

  String get(SecretKeys key) => _map[key];

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
      SecretKeys.values.firstWhere((v) => GetEnumValue(v) == s);
}
