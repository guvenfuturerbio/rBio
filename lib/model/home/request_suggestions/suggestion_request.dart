class SuggestionRequest {
  String? suggestionText;

  SuggestionRequest({
    this.suggestionText,
  });

  factory SuggestionRequest.fromJson(Map<String, dynamic> json) =>
      SuggestionRequest(
        suggestionText: json['suggestion_and_request'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'suggestion_and_request': suggestionText,
      };
}
