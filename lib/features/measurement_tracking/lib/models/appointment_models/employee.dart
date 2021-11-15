import 'User.dart';

class Employee {
  User user;
  int doctorId;

  Employee({this.user, this.doctorId});

  Employee.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    doctorId = json['doctor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['doctor_id'] = this.doctorId;
    return data;
  }
}