class TranslatorRequest {
  int interpreterId;

  TranslatorRequest({
    this.interpreterId,
  });

  factory TranslatorRequest.fromJson(Map<String, dynamic> json) => TranslatorRequest(
        interpreterId: json['interpreter_id'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'interpreter_id': interpreterId,
      };
}
