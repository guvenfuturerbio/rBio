class Zoom {
  String hostId;

  Zoom({this.hostId});

  Zoom.fromJson(Map<String, dynamic> json) {
    hostId = json['host_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['host_id'] = this.hostId;
    return data;
  }
}