class VoucherPriceRequest {
  String resourceId;
  String tenantId;
  String departmentId;
  String voucherCode;

  VoucherPriceRequest(
      {this.resourceId, this.tenantId, this.departmentId, this.voucherCode});

  VoucherPriceRequest.fromJson(Map<String, dynamic> json) {
    resourceId = json['resourceId'];
    tenantId = json['tenantId'];
    departmentId = json['departmentId'];
    voucherCode = json['voucherCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceId'] = this.resourceId;
    data['tenantId'] = this.tenantId;
    data['departmentId'] = this.departmentId;
    data['voucherCode'] = this.voucherCode;
    return data;
  }
}