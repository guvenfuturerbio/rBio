class AddFirebaseTokenRequest {
  String firebaseId;
  String phoneInfo;

  AddFirebaseTokenRequest({
    this.firebaseId,
    this.phoneInfo,
  });

  factory AddFirebaseTokenRequest.fromJson(Map<String, dynamic> json) =>
      AddFirebaseTokenRequest(
        firebaseId: json['fire_base_id'] as String,
        phoneInfo: json['phone_info'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'fire_base_id': firebaseId,
        'phone_info': phoneInfo,
      };
}
