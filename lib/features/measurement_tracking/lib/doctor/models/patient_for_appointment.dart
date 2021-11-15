import 'user.dart';

class Patient {
  User user;
  int id;

  Patient({this.user, this.id});

  Patient.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}