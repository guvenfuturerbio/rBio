import 'package:onedosehealth/models/payment/payment_response_datum.dart';

class PaymentResponse {
  bool isSuccessful;
  Null message;
  Datum datum;

  PaymentResponse({this.isSuccessful, this.message, this.datum});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    isSuccessful = json['is_successful'];
    message = json['message'];
    datum = json['datum'] != null ? new Datum.fromJson(json['datum']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_successful'] = this.isSuccessful;
    data['message'] = this.message;
    if (this.datum != null) {
      data['datum'] = this.datum.toJson();
    }
    return data;
  }
}
