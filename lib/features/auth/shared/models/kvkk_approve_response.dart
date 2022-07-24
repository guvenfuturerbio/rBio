class KvkkApproveResponse {
  bool? isKVKKAprovved;
  String? kVKKAprovvedDate;

  KvkkApproveResponse({
    this.isKVKKAprovved,
    this.kVKKAprovvedDate,
  });

  KvkkApproveResponse.fromJson(Map<String, dynamic> json) {
    isKVKKAprovved = json['isKVKKAprovved'] as bool?;
    kVKKAprovvedDate = json['KVKKAprovvedDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isKVKKAprovved'] = isKVKKAprovved;
    data['KVKKAprovvedDate'] = kVKKAprovvedDate;
    return data;
  }
}
