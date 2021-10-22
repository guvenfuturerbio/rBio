class StreamType {
  String hostId;
  String provider;

  StreamType({this.hostId, this.provider});

  StreamType.fromJson(Map<String, dynamic> json) {
    hostId = json['host_id'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['host_id'] = this.hostId;
    data['provider'] = this.provider;
    return data;
  }
}
