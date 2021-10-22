library guven_login;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'guven_login.g.dart';

abstract class GuvenLogin implements Built<GuvenLogin, GuvenLoginBuilder> {
  String get access_token;
  int get expires_in;
  int get refresh_expires_in;
  String get refresh_token;
  String get token_type;
  String get id_token;
  @nullable // reponseda no-before-policy eksi işareti ile yazıldığı için sorunlu.
  int get not_before_policy;
  String get session_state;
  String get scope;

  GuvenLogin._();

  factory GuvenLogin([updates(GuvenLoginBuilder b)]) = _$GuvenLogin;

  String toJson() {
    return json.encode(serializers.serializeWith(GuvenLogin.serializer, this));
  }

  static GuvenLogin fromJson(String jsonString) {
    return serializers.deserializeWith(
        GuvenLogin.serializer, json.decode(jsonString));
  }

  static Serializer<GuvenLogin> get serializer => _$guvenLoginSerializer;
}
