class TranslatorResponse {
  String? language;
  String? name;
  int? id;

  TranslatorResponse({
    this.language,
    this.name,
    this.id,
  });

  TranslatorResponse.fromJson(Map<String, dynamic> json) {
    language = json['language'] as String?;
    name = json['name'] as String?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language'] = language;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
