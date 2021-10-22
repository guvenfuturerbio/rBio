class KvkkApproveResponse {
  bool isKVKKAprovved;
  String kVKKAprovvedDate;

  KvkkApproveResponse({
    this.isKVKKAprovved,
    this.kVKKAprovvedDate,
  });

  KvkkApproveResponse.fromJson(Map<String, dynamic> json) {
    isKVKKAprovved = json['isKVKKAprovved'];
    kVKKAprovvedDate = json['KVKKAprovvedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isKVKKAprovved'] = this.isKVKKAprovved;
    data['KVKKAprovvedDate'] = this.kVKKAprovvedDate;
    return data;
  }
}
