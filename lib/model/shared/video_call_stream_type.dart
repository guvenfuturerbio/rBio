class StreamType {
  String? hostId;
  String? provider;

  StreamType({
    this.hostId,
    this.provider,
  });

  StreamType.fromJson(Map<String, dynamic> json) {
    hostId = json['host_id'] as String?;
    provider = json['provider'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['host_id'] = hostId;
    data['provider'] = provider;
    return data;
  }
}
