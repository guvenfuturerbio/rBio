class ZoomModel {
  String hostId;

  ZoomModel({
    this.hostId,
  });

  ZoomModel.fromJson(Map<String, dynamic> json) {
    hostId = json['host_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['host_id'] = this.hostId;
    return data;
  }
}
