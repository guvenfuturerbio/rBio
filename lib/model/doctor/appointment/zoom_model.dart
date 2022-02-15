class ZoomModel {
  String? hostId;

  ZoomModel({
    this.hostId,
  });

  ZoomModel.fromJson(Map<String, dynamic> json) {
    hostId = json['host_id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['host_id'] = hostId;
    return data;
  }
}
