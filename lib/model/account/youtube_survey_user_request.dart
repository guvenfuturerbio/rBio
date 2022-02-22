class YoutubeSurveyUserRequest {
  String? name;
  String? surname;
  String? phone;
  String? id;

  YoutubeSurveyUserRequest({
    this.name,
    this.surname,
    this.phone,
    this.id,
  });

  factory YoutubeSurveyUserRequest.fromJson(Map<String, dynamic> json) =>
      YoutubeSurveyUserRequest(
        name: json['name'] as String?,
        surname: json['sur_name'] as String?,
        phone: json['phone'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'sur_name': surname,
        'phone': phone,
        'id': id,
      };
}
