import 'package:json_annotation/json_annotation.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/payment/payment_cc.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/payment/payment_appointment.dart';
part 'payment.g.dart';

@JsonSerializable()
class Payment {
  @JsonKey(name: 'appointment')
  PaymentAppointment appointment;
  @JsonKey(name: 'cc')
  CC cc;
  @JsonKey(name: 'entegration_id')
  int entegration_id;

  Payment({this.appointment, this.cc, this.entegration_id});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
