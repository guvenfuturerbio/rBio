import 'payment_cc_request.dart';

class PackagePaymentRequest {
  String? subPackageItemId;
  PaymentCCRequest? cc;

  PackagePaymentRequest({
    this.subPackageItemId,
    this.cc,
  });

  factory PackagePaymentRequest.fromJson(Map<String, dynamic> json) => PackagePaymentRequest(
        subPackageItemId: json['sub_package_item_id'] as String?,
        cc: PaymentCCRequest.fromJson(json['cc'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sub_package_item_id': subPackageItemId,
        'cc': cc,
      };
}
