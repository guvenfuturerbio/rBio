class GetChatContactsResponse {
  String contactNameSurname;
  String contactFirebaseEmail;
  String imageUrl;
  bool isActive;
  String firebaseUserId;
  String firebaseToken;
  int contactUserId;
  int id;

  GetChatContactsResponse(
      {this.contactNameSurname,
      this.contactFirebaseEmail,
      this.imageUrl,
      this.isActive,
      this.firebaseUserId,
      this.contactUserId,
      this.id});

  GetChatContactsResponse.fromJson(Map<String, dynamic> json) {
    contactNameSurname = json['contact_name_surname'];
    contactFirebaseEmail = json['contact_firebase_email'];
    imageUrl = json['image_url'];
    isActive = json['is_active'];
    firebaseUserId = json['firebase_user_id'];
    firebaseToken = json['firebase_token'];
    contactUserId = json['contactUserId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_name_surname'] = this.contactNameSurname;
    data['contact_firebase_email'] = this.contactFirebaseEmail;
    data['image_url'] = this.imageUrl;
    data['is_active'] = this.isActive;
    data['firebase_user_id'] = this.firebaseUserId;
    data['firebase_token'] = this.firebaseToken;
    data['contactUserId'] = this.contactUserId;
    data['id'] = this.id;
    return data;
  }
}
