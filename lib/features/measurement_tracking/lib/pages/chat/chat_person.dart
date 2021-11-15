class ChatPerson {
  String name;
  String id;
  int doctorId;
  String url;

  ChatPerson({this.name, this.id, this.doctorId, this.url});

  ChatPerson.fromJson(Map<String, dynamic> json) {
    name = json['doctor_name'];
    id = json['doctor_system_name'];
    doctorId = json['doctor_id'];
    url = "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_name'] = this.name;
    data['doctor_system_name'] = this.id;
    data['doctor_id'] = this.doctorId;
    return data;
  }
}
