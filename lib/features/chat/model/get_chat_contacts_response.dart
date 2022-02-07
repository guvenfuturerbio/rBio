class GetChatContactsResponse {
  String? contactNameSurname;
  String? contactFirebaseEmail;
  String? imageUrl;
  bool? isActive;
  String? firebaseUserId;
  String? firebaseToken;
  int? contactUserId;
  int? id;

  GetChatContactsResponse(
      {this.contactNameSurname,
      this.contactFirebaseEmail,
      this.imageUrl,
      this.isActive,
      this.firebaseUserId,
      this.contactUserId,
      this.id});

  GetChatContactsResponse.fromJson(Map<String, dynamic> json) {
    contactNameSurname = json['contact_name_surname'] as String?;
    contactFirebaseEmail = json['contact_firebase_email'] as String?;
    imageUrl = json['image_url'] as String?;
    isActive = json['is_active'] as bool?;
    firebaseUserId = json['firebase_user_id'] as String?;
    firebaseToken = json['firebase_token'] as String?;
    contactUserId = json['contactUserId'] as int?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact_name_surname'] = contactNameSurname;
    data['contact_firebase_email'] = contactFirebaseEmail;
    data['image_url'] = imageUrl;
    data['is_active'] = isActive;
    data['firebase_user_id'] = firebaseUserId;
    data['firebase_token'] = firebaseToken;
    data['contactUserId'] = contactUserId;
    data['id'] = id;
    return data;
  }
}
