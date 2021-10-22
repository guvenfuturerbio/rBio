class PaymentCCRequest {
  String cardHolder;
  String cardNumber;
  String cvv;
  String expirationMonth;
  String expirationYear;

  PaymentCCRequest({
    this.cardHolder,
    this.cardNumber,
    this.cvv,
    this.expirationMonth,
    this.expirationYear,
  });

  factory PaymentCCRequest.fromJson(Map<String, dynamic> json) => PaymentCCRequest(
        cardHolder: json['card_holder'] as String,
        cardNumber: json['card_number'] as String,
        cvv: json['ccv'] as String,
        expirationMonth: json['expiration_month'] as String,
        expirationYear: json['expiration_year'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'card_holder': cardHolder,
        'card_number': cardNumber,
        'ccv': cvv,
        'expiration_month': expirationMonth,
        'expiration_year': expirationYear,
      };
}
