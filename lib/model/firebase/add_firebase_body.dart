import 'package:json_annotation/json_annotation.dart';
part 'add_firebase_body.g.dart';

@JsonSerializable()
class AddFirebaseToken {
  @JsonKey(name: 'fire_base_id')
  String? firebaseId;

  @JsonKey(name: 'phone_info')
  String? phoneInfo;

  AddFirebaseToken({
    this.firebaseId,
    this.phoneInfo,
  });

  factory AddFirebaseToken.fromJson(Map<String, dynamic> json) =>
      _$AddFirebaseTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AddFirebaseTokenToJson(this);
}
