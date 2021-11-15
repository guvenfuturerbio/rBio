import 'package:json_annotation/json_annotation.dart';
part 'payment_cc.g.dart';

@JsonSerializable()
class CC {
  @JsonKey(name: 'card_holder')
  String cardHolder;
  @JsonKey(name: 'card_number')
  String cardNumber;
  @JsonKey(name: 'ccv')
  String cvv;
  @JsonKey(name: 'expiration_month')
  String expirationMonth;
  @JsonKey(name: 'expiration_year')
  String expirationYear;

  CC({
    this.cardHolder,
    this.cardNumber,
    this.cvv,
    this.expirationMonth,
    this.expirationYear
  });

  factory CC.fromJson(Map<String, dynamic> json) => _$CCFromJson(json);

  Map<String, dynamic> toJson() => _$CCToJson(this);
}