// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_cc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CC _$CCFromJson(Map<String, dynamic> json) {
  return CC(
    cardHolder: json['card_holder'] as String,
    cardNumber: json['card_number'] as String,
    cvv: json['ccv'] as String,
    expirationMonth: json['expiration_month'] as String,
    expirationYear: json['expiration_year'] as String,
  );
}

Map<String, dynamic> _$CCToJson(CC instance) => <String, dynamic>{
      'card_holder': instance.cardHolder,
      'card_number': instance.cardNumber,
      'ccv': instance.cvv,
      'expiration_month': instance.expirationMonth,
      'expiration_year': instance.expirationYear,
    };
