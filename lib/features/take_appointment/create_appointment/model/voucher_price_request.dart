class VoucherPriceRequest {
  String? resourceId;
  String? tenantId;
  String? departmentId;
  String? voucherCode;

  VoucherPriceRequest({
    this.resourceId,
    this.tenantId,
    this.departmentId,
    this.voucherCode,
  });

  VoucherPriceRequest.fromJson(Map<String, dynamic> json) {
    resourceId = json['resourceId'] as String?;
    tenantId = json['tenantId'] as String?;
    departmentId = json['departmentId'] as String?;
    voucherCode = json['voucherCode'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resourceId'] = resourceId;
    data['tenantId'] = tenantId;
    data['departmentId'] = departmentId;
    data['voucherCode'] = voucherCode;
    return data;
  }
}
