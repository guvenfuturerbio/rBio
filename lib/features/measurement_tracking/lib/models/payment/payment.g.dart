// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment(
    appointment: json['appointment'] == null
        ? null
        : PaymentAppointment.fromJson(
            json['appointment'] as Map<String, dynamic>),
    cc: json['cc'] == null
        ? null
        : CC.fromJson(json['cc'] as Map<String, dynamic>),
    entegration_id: json['entegration_id'] as int,
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'appointment': instance.appointment,
      'cc': instance.cc,
      'entegration_id': instance.entegration_id,
    };
