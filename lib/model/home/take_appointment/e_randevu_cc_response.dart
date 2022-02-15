class ERandevuCCResponse {
  String? cardHolder;
  String? cardNumber;
  String? cvv;
  String? expirationMonth;
  String? expirationYear;

  ERandevuCCResponse({
    this.cardHolder,
    this.cardNumber,
    this.cvv,
    this.expirationMonth,
    this.expirationYear,
  });

  factory ERandevuCCResponse.fromJson(Map<String, dynamic> json) =>
      ERandevuCCResponse(
        cardHolder: json['CardHolder'] as String?,
        cardNumber: json['CardNumber'] as String?,
        cvv: json['Ccv'] as String?,
        expirationMonth: json['ExpirationMonth'] as String?,
        expirationYear: json['ExpirationYear'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'CardHolder': cardHolder,
        'CardNumber': cardNumber,
        'Ccv': cvv,
        'ExpirationMonth': expirationMonth,
        'ExpirationYear': expirationYear,
      };
}
